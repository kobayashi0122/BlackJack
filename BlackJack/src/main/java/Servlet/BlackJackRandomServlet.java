package Servlet;

import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/random")
public class BlackJackRandomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String[] CARDS = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "A"};

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        Random random = new Random();
        
        // ディーラーカード
        String dealerCard = CARDS[random.nextInt(CARDS.length)];  // CARDS配列からランダムに選択

        // 自分カード
        String playerCard1 = CARDS[random.nextInt(CARDS.length)]; // CARDS配列からランダムに選択
        String playerCard2 = CARDS[random.nextInt(CARDS.length)]; // CARDS配列からランダムに選択

        // 出力
        response.getWriter().println("<h1>ディーラーカード：" + dealerCard + "</h1>");
        response.getWriter().println("<h1>自分カード：" + playerCard1 + " , " + playerCard2 + "</h1>");
    }
}