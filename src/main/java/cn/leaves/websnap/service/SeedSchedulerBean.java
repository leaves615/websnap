package cn.leaves.websnap.service;

import cn.leaves.websnap.batis.entity.Seed;
import cn.leaves.websnap.batis.mapper.SeedMapper;
import cn.leaves.websnap.crawler.GeneralCrawler;
import cn.leaves.websnap.crawler.InstanceCrawlController;
import edu.uci.ics.crawler4j.crawler.CrawlConfig;
import edu.uci.ics.crawler4j.crawler.CrawlController;
import edu.uci.ics.crawler4j.fetcher.PageFetcher;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtConfig;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtServer;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.joda.time.DateTime;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PreDestroy;
import javax.annotation.Resource;
import java.io.File;
import java.util.*;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/9.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")
@Component
public class SeedSchedulerBean implements ApplicationContextAware,DisposableBean {
    private static final Log logger = LogFactory.getLog(SeedSchedulerBean.class);

    private Map<Long, CrawlController> runningSeeds = Collections.synchronizedMap(new HashMap<Long, CrawlController>());
    @Resource
    private SeedMapper     seedMapper;

    private ApplicationContext applicationContext;


    @Scheduled(cron = "0/10 * *  * * ? ")
    @Transactional
    public void seedScheduler() {
        if (logger.isDebugEnabled()) {
            logger.debug("start ");
        }
        List<Seed> seeds = seedMapper.selectAll();
        for (Seed seed : seeds) {
            if (runningSeeds.containsKey(seed.getId())) {
                continue;
            }
            if (!seed.getStatus()) {
                continue;
            }
            CronSequenceGenerator cronSequenceGenerator = new CronSequenceGenerator(seed.getCron().trim());
            Date lastDate = seed.getLastexecutetime();
            if (lastDate == null) {
                lastDate = new DateTime().withTime(0, 0, 0, 0).toDate();
            }
            Date cronDate = cronSequenceGenerator.next(lastDate);
            if (logger.isDebugEnabled()) {
                logger.debug("seed[" + seed.getName() + "] next cronDate is " + cronDate);
            }
            DateTime dateTime = new DateTime(cronDate);
            if (dateTime.isBeforeNow()) {
                startCrawler(seed);
            }
        }
    }

    private void startCrawler(Seed seed) {
        GeneralCrawler crawler = applicationContext.getBean(GeneralCrawler.class);
        if (logger.isInfoEnabled()) {
            logger.info("start crawler for seed: " + seed);
        }
        String crawlStorageFolder = System.getProperty("java.io.tmpdir") + File.separator + "seed_" + seed.getId();
        int numberOfCrawlers = seed.getNumberOfCrawler();

        try {
            CrawlConfig config = new CrawlConfig();
            config.setCrawlStorageFolder(crawlStorageFolder);
            config.setResumableCrawling(false);

        /*
         * Instantiate the controller for this crawl.
         */
            PageFetcher pageFetcher = new PageFetcher(config);
            RobotstxtConfig robotstxtConfig = new RobotstxtConfig();
            RobotstxtServer robotstxtServer = new RobotstxtServer(robotstxtConfig, pageFetcher);
            InstanceCrawlController controller = new InstanceCrawlController(config, pageFetcher, robotstxtServer);

        /*
         * For each crawl, you need to add some seed urls. These are the first
         * URLs that are fetched and then the crawler starts following links
         * which are found in these pages
         */
            controller.addSeed(seed.getUrl());

        /*
         * Start the crawl. This is a blocking operation, meaning that your code
         * will reach the line after this only when crawling is finished.
         */
            crawler.init(seed.getId());
            controller.startNonBlocking(crawler, numberOfCrawlers);
            runningSeeds.put(seed.getId(), controller);
        } catch (Exception e) {
            if (logger.isErrorEnabled()) {
                logger.error("start crawler failed", e);
            }
        }
    }

    @Scheduled(cron = "0/10 * *  * * ? ")
    public void checkCrawlerStatus() {
        Iterator<Map.Entry<Long,CrawlController>> iterator = runningSeeds.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<Long, CrawlController> next = iterator.next();
            if (next.getValue().isFinished()) {
                Seed update = new Seed();
                update.setId(next.getKey());
                update.setLastexecutetime(DateTime.now().toDate());
                seedMapper.updateByPrimaryKeySelective(update);
                iterator.remove();
            }
        }
    }


    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {

        this.applicationContext = applicationContext;
    }

    @Override
    public void destroy() throws Exception {
        Iterator<Map.Entry<Long,CrawlController>> iterator = runningSeeds.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<Long, CrawlController> next = iterator.next();
            next.getValue().shutdown();
            next.getValue().waitUntilFinish();
        }
        Thread.currentThread().sleep(2000);
        while(runningSeeds.size()>0) {
            Thread.currentThread().sleep(1000);
        }
    }
}
