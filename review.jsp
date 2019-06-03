<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%>
<% request.setCharacterEncoding("utf-8");
  //try{
  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  Statement stmt_icon = con.createStatement();
  ResultSet rs = stmt.executeQuery("select * from reviews");
  ArrayList<Map<String, Object>> reviews = new ArrayList<>();
  while(rs.next()){
    Map<String, Object> map = new HashMap<>();
    ResultSet rs_icon = stmt_icon.executeQuery("select icon from users where id="+rs.getInt("user_id"));
    rs_icon.next();
    map.put("user_name", rs.getString("user_name"));
    map.put("user_icon", rs_icon.getString("icon"));
    map.put("movie_id", rs.getInt("movie_id"));
    map.put("movie_name", rs.getString("movie_name"));
    map.put("rate", rs.getDouble("rate"));
    map.put("time", rs.getDate("time"));
    map.put("content", rs.getString("content"));
    reviews.add(map);
    rs_icon.close();
  }
  rs.close();
  stmt.close();
  stmt_icon.close();

  Boolean online = false;
  Map<String, String> cookies = new HashMap<>();
  Cookie[] cookie_items = request.getCookies();
  if(cookie_items!=null){
    for(Cookie cookie_item : cookie_items){
        cookies.put(cookie_item.getName(), cookie_item.getValue());
    }
    if(cookies.containsKey("user_id")&&cookies.containsKey("user_password")){
        Statement stmt_online = con.createStatement();
        ResultSet rs_online = stmt_online.executeQuery("select id from users where id="+cookies.get("user_id")+" and password='"+cookies.get("user_password")+"'");
        if(rs_online.next()){
            online=true;
        }
        rs_online.close();
        stmt_online.close();
    }
  }
  con.close();
%>
<!DOCTYPE html>
<html>
    <head>
      <title>猫瓣电影 | 好电影一网打尽 </title>
      <link rel="icon" href="source/猫爪.png" type="image/x-icon">
      <link type="text/css" rel="stylesheet" href="movie.css">
      <script src="functions.js"></script>
      <meta charset="UTF-8">
    </head>
    <body>
    <div class="header">
        <div class="header-inner">

            <a href="index.jsp" class="logo"><img src="source/猫瓣电影.png" alt="猫瓣电影"></a>

            <div class="nav">
                <ul class="navbar">
                    <li id="home"><a href="index.jsp">首页</a></li>
                    <li id="film"><a href="filter.jsp">电影</a></li>
                    <li id="board"><a href="rank.jsp" id="board">榜单</a></li>
                    <li id="review" class="active"><a href="review.jsp" id="news">热评</a></li>
                    <li id="search"><a href="search.jsp" id="search">搜索</a></li>
                </ul>
            </div>


            <form action="search.jsp" target="_blank" class="search-form">
                <input class="submit" type="submit" value="">
                <input name="keyword" class="search" type="search" maxlength="32" placeholder="搜索电影、电视剧、综艺、影人"
                    autocomplete="off">
                <input class="mask" type="text" value="">
            </form>

            <% if(online==false){ %>
            <div class="user">
                <div class="img"></div>
                <span class="caret"></span>
                <ul class="menu">
                    <li><a href="login.html">登录</a></li>
                    <li><a href="register.html">注册</a></li>
                </ul>
            </div>
            <%} else{%>
            <div class="user">
                <div class="img"></div>
                <span class="caret"></span>
                <ul class="menu">
                    <li style="padding-top:75px;"><a href="user.jsp" style="margin-left:-10px;">基本信息</a></li>
                    <li style="padding-top:5px;"><a href="exit.jsp" style="margin-left:-10px;">退出登录</a></li>
                    <li style="padding-top:5px;"><a href="delete_user.jsp" style="margin-left:-10px;">注销账号</a></li>
                </ul>
            </div>
            <%}%>
        </div>
    </div>
      <div class="movie-review">
        <div class="movie-review-header">
          <span class="movie-review-header-left">电影评论</span>
        </div>
        <div class="review-list" id="review-list">
        <% for(int i = 0; i < reviews.size(); i++){%>
            <div class="review-page-user-icon">
              <img class="review-icon-image" src="<%=reviews.get(i).get("user_icon")%>">
            </div>
            <div class="review-content-body">
              <div><span class="review-user-name"><%=reviews.get(i).get("user_name")%></span></div>
              <div>看过<a class="review-movie-name" href="film.jsp?movie_id=<%=reviews.get(i).get("movie_id")%>"><%=reviews.get(i).get("movie_name")%></a><span class="star"></span><span class="movie-rating" style="visibility:hidden;"><%=reviews.get(i).get("rate")%></span></div>
              <div><span class="review-time"><%=reviews.get(i).get("time")%></span></div>
              <div class="review-content">
                <%=reviews.get(i).get("content")%>
              </div>
            </div>
        <%}%>
        </div>
      </div>

      <div class="footer" style="visibility:visible">
    <p class="friendly-links">友情链接：
      <a href="https://maoyan.com">猫眼电影</a>
      <span></span>
      <a href="https://movie.douban.com">豆瓣电影</a>
    </p>
    <p>
        ©2019
        猫瓣电影 maoban.com
    </p>
  </div>
      
    <script> rating_star(); </script>
    </body>
</html>