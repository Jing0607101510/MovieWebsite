<%@ page language="java" import="java.util.*,java.sql.*, java.text.*"
contentType="text/html; charset=utf-8"
%><% request.setCharacterEncoding("utf-8");
  //try{
  int id = Integer.parseInt(request.getParameter("user_id"));
  int movie_id = Integer.parseInt(request.getParameter("movie_id"));
  String content = request.getParameter("content");
  String score = request.getParameter("score");
  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  Statement stmt_movie = con.createStatement();
  ResultSet rs_user = stmt.executeQuery("select nickname, icon from users where id="+id);
  ResultSet rs_movie = stmt_movie.executeQuery("select name from movies where id="+movie_id);
  rs_user.next();
  rs_movie.next();

  SimpleDateFormat sdf = new SimpleDateFormat();
  sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
  java.util.Date date = new java.util.Date();
  String date_str = sdf.format(date);

  String sql = String.format("insert into reviews (user_id, user_name, movie_id, movie_name, content, time, rate) values (%d, '%s', %d, '%s', '%s', '%s', %s)", id, rs_user.getString("nickname"), movie_id, rs_movie.getString("name"),
                content, date_str, score);
  String icon = rs_user.getString("icon");
  String nickname = rs_user.getString("nickname");
  rs_user.close();
  rs_movie.close();
  int cnt = stmt.executeUpdate(sql);
  stmt.close();
  stmt_movie.close();
  con.close();
%>
<div class="review-user-icon">
    <img class="review-icon-image" src="<%=icon%>">
    </div>
    <div class="review-content-body">
    <div><span class="review-user-name"><%=nickname%></span></div>
    <span class="star" style="margin-left:5px;"></span><span class="movie-rating" style="visibility:hidden;"><%=score%></span>
    <div><span class="review-time"><%=date_str%></span></div>
    <div class="review-content">
        <%=content%>
    </div>
</div>
