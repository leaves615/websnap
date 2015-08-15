package cn.leaves.websnap;

import edu.uci.ics.crawler4j.crawler.Page;
import edu.uci.ics.crawler4j.crawler.WebCrawler;
import edu.uci.ics.crawler4j.parser.HtmlParseData;
import edu.uci.ics.crawler4j.url.WebURL;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/6.
 */
public class MyCrawler extends WebCrawler {
    public static Set<String> exists = new HashSet<>();
    private  static     String      base   = "/Users/leaves/Desktop/temp2";

    static {
        File[] files = new File(base).listFiles();
        for (File file : files) {
            exists.add(file.getName());
        }
    }

    @Override
    public boolean shouldVisit(Page page, WebURL url) {
        return url.getDomain().startsWith("513gp.org") && url.getPath().endsWith("html")&&!exists.contains(url.getPath().substring(1));
    }

    @Override
    public void visit(Page page) {
        if (page.getParseData() instanceof HtmlParseData) {
            HtmlParseData htmlParseData = (HtmlParseData) page.getParseData();
            String text = htmlParseData.getText();
            String html = htmlParseData.getHtml();
            Document document = Jsoup.parse(html);
            String fileName = page.getWebURL().getPath().substring(1);
            try(BufferedWriter writer = new BufferedWriter(new FileWriter(base+ File.separator+fileName))) {
                writer.append(document.select(".chaptertitle").text());
                writer.newLine();
                writer.append(document.select("#BookText").text());
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.out.println("visit: " + page.getWebURL().getPath());
        }
    }
}
