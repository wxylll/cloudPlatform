package cn.baimu.utils;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.IOException;

public class MapUtil {
    private static String position = "http://restapi.amap.com/v3/geocode/geo?key=2778de5c45eaa7653553c3d919b956c2&s=rsv3&output=XML&address=";
    private static String route = "https://restapi.amap.com/v3/direction/walking?output=XML&key=7e006891239adb09b95c0b528977944c";

    /**
     * 获取到达目的地的距离和时间
     * @param origin
     * @param destination
     * @return
     */
    public static String getDistanceAndTime(String origin, String destination) {
        Connection.Response _origin = getResponse(position + origin);
        Connection.Response _destination = getResponse(position + destination);
        String originPoint = "&origin=" + Jsoup.parse(_origin.body()).getElementsByTag("location").text();
        String destinationPoint = "&destination=" + Jsoup.parse(_destination.body()).getElementsByTag("location").text();
        String routeUrl = route + originPoint + destinationPoint;
        Connection.Response result = getResponse(routeUrl);
        Document dom = Jsoup.parse(result.body());
        if (dom.getElementsByTag("status").text().equals("1")) {
            String distance = dom.getElementsByTag("distance").first().text();
            String _time = dom.getElementsByTag("duration").first().text();
            int time = Integer.valueOf(_time) / 60;
            return distance + ":" + time;
        }
        return null;
    }

    private static Connection.Response getResponse(String url) {
        Connection.Response res = null;
        try {
            res = Jsoup.connect(url)
                    .header("Accept", "*/*")
                    .header("Accept-Encoding", "gzip, deflate")
                    .header("Accept-Language","zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3")
                    .header("Content-Type", "application/json;charset=UTF-8")
                    .header("User-Agent","Mozilla/5.0 (Windows NT 6.1; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0")
                    .timeout(10000).ignoreContentType(true).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }

}
