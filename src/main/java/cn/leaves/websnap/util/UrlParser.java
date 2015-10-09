package cn.leaves.websnap.util;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/10/8.
 *
 * @Author leaves chen<leaves615@gmail.com>
 */
public class UrlParser {
    private URL origin;

    public UrlParser(String url) throws MalformedURLException {
        this.origin = new URL(url);
    }

    public String getDomain() {
        return origin.getHost();
    }

    public String getBase() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(origin.getProtocol());
        stringBuilder.append("://");
        stringBuilder.append(origin.getHost());
        switch (origin.getPort()) {
            case -1:
            case 80:
            case 443:break;
            default:
                stringBuilder.append(":");
                stringBuilder.append(origin.getPort());
        }
        return stringBuilder.toString();
    }

    public String getDir() {
        String path = getBase()+origin.getPath();
        return path.substring(0, path.lastIndexOf("/"));
    }

    public static void main(String[] args) throws MalformedURLException {
        UrlParser urlParser = new UrlParser(
                "https://www.google.com/a/a/a/a/a/search?newwindow=1&c2coff=1&q=java+url+%E6%8E%A5%E5%8F%A3&oq=java+url+%E6%8E%A5%E5%8F%A3&gs_l=serp.3...436480.438849.0.439582.9.8.1.0.0.0.576.1525.3-1j0j2.3.0....0...1c.1j4.64.serp..6.3.971.DCYRr6HJwdM");
        System.out.println(urlParser.getBase());
        System.out.println(urlParser.getDir());
    }
}
