package cn.leaves.websnap.crawler;

import edu.uci.ics.crawler4j.crawler.CrawlConfig;
import edu.uci.ics.crawler4j.crawler.CrawlController;
import edu.uci.ics.crawler4j.fetcher.PageFetcher;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * 对象爬虫控制器。
 * Created by leaves chen<leaves615@gmail.com> on 15/8/9.
 */
public class InstanceCrawlController extends CrawlController {
    static final Logger logger = LoggerFactory.getLogger(InstanceCrawlController.class);

    public InstanceCrawlController(
            CrawlConfig config, PageFetcher pageFetcher, RobotstxtServer robotstxtServer) throws Exception {
        super(config, pageFetcher, robotstxtServer);
    }

    public void start(WebCrawlerEx webCrawler, int numberOfCrawlers) {
        start(webCrawler, numberOfCrawlers, false);
    }

    public void startNonBlocking(WebCrawlerEx webCrawler, int numberOfCrawlers) {
        start(webCrawler, numberOfCrawlers, false);
    }

    protected void start(WebCrawlerEx webCrawler, int numberOfCrawlers, boolean isBlocking) {
        try {
            finished = false;
            crawlersLocalData.clear();
            final List<Thread> threads = new ArrayList<>();
            final List<WebCrawlerEx> crawlers = new ArrayList<>();

            for (int i = 1; i <= numberOfCrawlers; i++) {
                WebCrawlerEx crawler = webCrawler;
                Thread thread = new Thread(crawler, "Crawler " + i);
                crawler.setThread(thread);
                crawler.init(i, this);
                thread.start();
                crawlers.add(crawler);
                threads.add(thread);
                logger.info("Crawler {} started", i);
            }

            final CrawlController controller = this;

            Thread monitorThread = new Thread(new Runnable() {

                @Override
                public void run() {
                    try {
                        synchronized (waitingLock) {

                            while (true) {
                                sleep(10);
                                boolean someoneIsWorking = false;
                                for (int i = 0; i < threads.size(); i++) {
                                    Thread thread = threads.get(i);
                                    if (!thread.isAlive()) {
                                        if (!shuttingDown) {
                                            logger.info("Thread {} was dead, I'll recreate it", i);
                                            WebCrawlerEx crawler = webCrawler;
                                            thread = new Thread(crawler, "Crawler " + (i + 1));
                                            threads.remove(i);
                                            threads.add(i, thread);
                                            crawler.setThread(thread);
                                            crawler.init(i + 1, controller);
                                            thread.start();
                                            crawlers.remove(i);
                                            crawlers.add(i, crawler);
                                        }
                                    } else if (crawlers.get(i).isNotWaitingForNewURLs()) {
                                        someoneIsWorking = true;
                                    }
                                }
                                if (!someoneIsWorking) {
                                    // Make sure again that none of the threads are alive.
                                    logger.info("It looks like no thread is working, waiting for 10 seconds to make sure...");
                                    sleep(10);

                                    someoneIsWorking = false;
                                    for (int i = 0; i < threads.size(); i++) {
                                        Thread thread = threads.get(i);
                                        if (thread.isAlive() && crawlers.get(i).isNotWaitingForNewURLs()) {
                                            someoneIsWorking = true;
                                        }
                                    }
                                    if (!someoneIsWorking) {
                                        if (!shuttingDown) {
                                            long queueLength = frontier.getQueueLength();
                                            if (queueLength > 0) {
                                                continue;
                                            }
                                            logger.info("No thread is working and no more URLs are in queue waiting for another 10 seconds to make sure...");
                                            sleep(10);
                                            queueLength = frontier.getQueueLength();
                                            if (queueLength > 0) {
                                                continue;
                                            }
                                        }

                                        logger.info("All of the crawlers are stopped. Finishing the process...");
                                        // At this step, frontier notifies the threads that were waiting for new URLs and they should stop
                                        frontier.finish();
                                        for (WebCrawlerEx crawler : crawlers) {
                                            crawler.onBeforeExit();
                                            crawlersLocalData.add(crawler.getMyLocalData());
                                        }

                                        logger.info("Waiting for 10 seconds before final clean up...");
                                        sleep(10);

                                        frontier.close();
                                        docIdServer.close();
                                        pageFetcher.shutDown();

                                        finished = true;
                                        waitingLock.notifyAll();
                                        env.close();

                                        return;
                                    }
                                }
                            }
                        }
                    } catch (Exception e) {
                        logger.error("Unexpected Error", e);
                    }
                }
            });

            monitorThread.start();

            if (isBlocking) {
                waitUntilFinish();
            }

        } catch (Exception e) {
            logger.error("Error happened", e);
        }
    }
}
