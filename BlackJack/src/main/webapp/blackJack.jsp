<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <title>ブラックジャック理論値</title>
</head>
<body>
    <h1>初期手札選択</h1>

    <%
        HttpSession se = request.getSession(); // セッションを取得

        // リクエストからパラメータを取得
        String dealerCard = request.getParameter("dealerCard");
        String playerCard1 = request.getParameter("playerCard1");
        String playerCard2 = request.getParameter("playerCard2");

        // パラメータが存在する場合はセッションに保存
        if (dealerCard != null && playerCard1 != null && playerCard2 != null) {
            se.setAttribute("dealerCard", dealerCard);
            se.setAttribute("playerCard1", playerCard1);
            se.setAttribute("playerCard2", playerCard2);
        } else {
            // パラメータが存在しない場合はセッションから取得
            dealerCard = (String) se.getAttribute("dealerCard");
            playerCard1 = (String) se.getAttribute("playerCard1");
            playerCard2 = (String) se.getAttribute("playerCard2");
        }
    %>

    <form action="blackJack.jsp" method="post">
        <label for="dealerCard">ディーラーアップカード：</label>
        <select id="dealerCard" name="dealerCard">
            <option value="1" <%= "1".equals(dealerCard) ? "selected" : "" %>>1</option>
            <option value="2" <%= "2".equals(dealerCard) ? "selected" : "" %>>2</option>
            <option value="3" <%= "3".equals(dealerCard) ? "selected" : "" %>>3</option>
            <option value="4" <%= "4".equals(dealerCard) ? "selected" : "" %>>4</option>
            <option value="5" <%= "5".equals(dealerCard) ? "selected" : "" %>>5</option>
            <option value="6" <%= "6".equals(dealerCard) ? "selected" : "" %>>6</option>
            <option value="7" <%= "7".equals(dealerCard) ? "selected" : "" %>>7</option>
            <option value="8" <%= "8".equals(dealerCard) ? "selected" : "" %>>8</option>
            <option value="9" <%= "9".equals(dealerCard) ? "selected" : "" %>>9</option>
            <option value="10" <%= "10".equals(dealerCard) ? "selected" : "" %>>10</option>
        </select>
        <br>
        <label for="playerCard1">自分手札1：</label>
        <select id="playerCard1" name="playerCard1">
            <option value="1" <%= "1".equals(playerCard1) ? "selected" : "" %>>1</option>
            <option value="2" <%= "2".equals(playerCard1) ? "selected" : "" %>>2</option>
            <option value="3" <%= "3".equals(playerCard1) ? "selected" : "" %>>3</option>
            <option value="4" <%= "4".equals(playerCard1) ? "selected" : "" %>>4</option>
            <option value="5" <%= "5".equals(playerCard1) ? "selected" : "" %>>5</option>
            <option value="6" <%= "6".equals(playerCard1) ? "selected" : "" %>>6</option>
            <option value="7" <%= "7".equals(playerCard1) ? "selected" : "" %>>7</option>
            <option value="8" <%= "8".equals(playerCard1) ? "selected" : "" %>>8</option>
            <option value="9" <%= "9".equals(playerCard1) ? "selected" : "" %>>9</option>
            <option value="10" <%= "10".equals(playerCard1) ? "selected" : "" %>>10</option>
        </select>
        <br>
        <label for="playerCard2">自分手札2：</label>
        <select id="playerCard2" name="playerCard2">
            <option value="1" <%= "1".equals(playerCard2) ? "selected" : "" %>>1</option>
            <option value="2" <%= "2".equals(playerCard2) ? "selected" : "" %>>2</option>
            <option value="3" <%= "3".equals(playerCard2) ? "selected" : "" %>>3</option>
            <option value="4" <%= "4".equals(playerCard2) ? "selected" : "" %>>4</option>
            <option value="5" <%= "5".equals(playerCard2) ? "selected" : "" %>>5</option>
            <option value="6" <%= "6".equals(playerCard2) ? "selected" : "" %>>6</option>
            <option value="7" <%= "7".equals(playerCard2) ? "selected" : "" %>>7</option>
            <option value="8" <%= "8".equals(playerCard2) ? "selected" : "" %>>8</option>
            <option value="9" <%= "9".equals(playerCard2) ? "selected" : "" %>>9</option>
            <option value="10" <%= "10".equals(playerCard2) ? "selected" : "" %>>10</option>
        </select>
        <br>
        <input type="submit" value="表示">
    </form>

    <%
        if (dealerCard != null && playerCard1 != null && playerCard2 != null) {
        	int dealerCd = Integer.parseInt(dealerCard);
            int playerCd1 = Integer.parseInt(playerCard1);
            int playerCd2 = Integer.parseInt(playerCard2);
            int playerTotal = playerCd1 + playerCd2;

            String resultValue = "結果取得エラー"; // デフォルト値 →改善検討 tomcat10 javax.servletからjakarta.servletに変更
            String overView = "説明取得エラー"; // デフォルト値

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // JDBCドライバのクラスをロード
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/blackjack", "root", "root"); // 改善検討
                PreparedStatement stmt = conn.prepareStatement("SELECT result_value, overview FROM T_BASIC_STRATEGY WHERE dealer_card = ? AND hand_total = ?");
                stmt.setInt(1, dealerCd);
                stmt.setInt(2, playerTotal);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    resultValue = rs.getString("result_value");
                    overView = rs.getString("overview");
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            out.println("<h1>情報</h1>");
            out.println("<h2>ディーラー：" + dealerCd + "</h2>");
            out.println("<h2>手札合計：" + playerTotal + "</h2>");
            out.println("<h2>推薦行動：" + resultValue + "</h2>");
            out.println("<h2>説明：" + overView + "</h2>");
        }
    %>
    <a href="index.jsp">index</a>
</body>
</html>