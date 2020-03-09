package servlets;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.util.*;

//При переходе по /analyze сервер отправит обработанне данные обратно в index.jsp
@WebServlet("/analyze")
public class Analyze extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doPost(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        String link = request.getParameter("link");
        int cout=1;
        ArrayList linkList= new ArrayList();
        ArrayList textList= new ArrayList();
        Document doc;
        //Изменение полученных ссылок до кликабельного состояния и отправка
        if(link.startsWith("http")){
            System.out.println("arab "+link);
            doc = Jsoup.connect(link).get();
        }else
            doc = Jsoup.connect("https://" + link).get();
        Elements links = doc.select("a[href]");
        for (Element linkk : links) {
            if(linkk.text().isEmpty()){
                continue;
            }
            if(linkk.attr("href").isEmpty()){
                continue;
            }
            textList.add(linkk.text());

            if(linkk.attr("href").startsWith("/")){
                linkList.add(link+linkk.attr("href"));
            }else {
                linkList.add(linkk.attr("href"));
            }
            cout++;
        }

        request.setAttribute("link", linkList);
        request.setAttribute("text", textList);

        for(int i=0;i<linkList.size();i++){
            System.err.println(i+" " + linkList.get(i));
            System.out.println(i+" " + textList.get(i));
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

}