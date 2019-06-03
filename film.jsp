<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%><% request.setCharacterEncoding("utf-8");
  //try{
  int id = Integer.parseInt(request.getParameter("movie_id"));
  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  Statement stmt_icon = con.createStatement();
  Statement stmt_reviews = con.createStatement();
  ResultSet rs = stmt.executeQuery("select * from movies where id="+id);
  Map<String, Object> map = new HashMap<>();

  if(rs.next()){
    map.put("id", rs.getInt("id"));
    map.put("name", rs.getString("name"));
    map.put("year", rs.getString("year"));
    map.put("director", rs.getString("director"));
    map.put("screenwriter", rs.getString("screenwriter"));
    map.put("actor", rs.getString("actor"));
    map.put("kind", rs.getString("kind"));
    map.put("area", rs.getString("area"));
    map.put("language", rs.getString("language"));
    map.put("runtime", rs.getString("runtime"));
    map.put("rate", rs.getDouble("rate"));
    map.put("summary", rs.getString("summary"));
    map.put("poster", rs.getString("poster"));
  } 

  ArrayList<Map<String, Object>> movies = new ArrayList<>();
  ResultSet rs_movies = stmt.executeQuery("select id, name, rate, poster from movies order by RAND() limit 6");
  while(rs_movies.next()){
    Map<String, Object> movie = new HashMap<>();
    movie.put("id", rs_movies.getInt("id"));
    movie.put("name", rs_movies.getString("name"));
    movie.put("rate", rs_movies.getDouble("rate"));
    movie.put("poster", rs_movies.getString("poster"));
    movies.add(movie);
  }
  rs_movies.close();

  ArrayList<Map<String, Object>> reviews = new ArrayList<>();
  ResultSet rs_reviews = stmt_reviews.executeQuery("select user_id, user_name, content, time, rate from reviews where movie_id="+id);
  while(rs_reviews.next()){
    Map<String, Object> map_review = new HashMap<>();
    map_review.put("user_name", rs_reviews.getString("user_name"));
    map_review.put("content", rs_reviews.getString("content"));
    map_review.put("time", rs_reviews.getDate("time"));
    map_review.put("rate", rs_reviews.getDouble("rate"));
    ResultSet rs_icon = stmt_icon.executeQuery("select icon from users where id="+rs_reviews.getInt("user_id"));
    rs_icon.next();
    map_review.put("icon", rs_icon.getString("icon"));
    rs_icon.close();
    reviews.add(map_review);
  }
  rs_reviews.close();
  stmt_reviews.close();
  stmt_icon.close();
  stmt.close();

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
<head>
    <title>猫瓣电影 | 好电影一网打尽 </title>
    <link rel="icon" href="source/猫爪.png" type="image/x-icon">
    <link type="text/css" rel="stylesheet" href="movie.css">
    <script src="functions.js"></script>
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
                    <li id="news"><a href="review.jsp" id="news">热评</a></li>
                    <li id="cinemas"><a href="search.jsp" id="search">搜索</a></li>
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
    <div class="banner">
        <div class="banner-inner">
            <div class="banner-left">
                <img class="banner-movie-poster" src="<%=map.get("poster")%>" alt>
            </div>
            <div class="banner-right">
                <div class="banner-movie-info">
                    <h3 class="name"><%=map.get("name")%></h3>
                    <ul>
                        <li class="banner-leixing"><%=map.get("kind")%></li>
                        <li class="banner-area"><%=map.get("area")%></li>
                        <li class="banner-time"><%=map.get("year")%></li>
                        <li class="banner-runtime"><%=map.get("runtime")%></li>
                    </ul>
                </div>
                <div class="banner-rate">
                    <h6>评分</h6>
                    <span class="banner-rate-inner movie-rating"><%=map.get("rate")%></span>
                    <span class="star"></span>
                </div>
            </div>
        </div>
    </div>

    <div class="movie-video">
        <video id="video" controls="" preload="" src="videos/video.mp4" height="600px" width="1100px" style="margin:auto;"></video>
    </div>

    <div class="content-container">
        <div class="brief-info">
            <div class="mod-title">
                <h3>电影信息</h3>
            </div>
            <div class="mod-content">
                <div class="mode-content-info">
                    <div>导 演：<span class="daoyan"><%=map.get("director")%></span></div>
                    <div>编 剧：<span class="bianju"><%=map.get("screenwriter")%></span></div>
                    <div>主 演：<span class="zhuyan"><%=map.get("actor")%></span></div>
                    <div>类 型：<span class="leixing"><%=map.get("kind")%></span></div>
                    <div>区 域：<span class="area"><%=map.get("area")%></span></div>
                    <div>语 言：<span class="yuyan"><%=map.get("language")%></span></div>
                </div>
            </div>
        </div>
        <div class="brief-info">
            <div class="mod-title">
                <h3>电影简介</h3>
            </div>
            <div class="mod-content">
                <span class="mod-movie-info">
                        <%=map.get("summary")%>
                </span>
            </div>
        </div>
    </div>

    <div class="edit-review">
        <form class="review-form">
            <div class="textarea" id="input_div">
                <textarea class="textarea-inner" id="textarea-inner" placeholder="一起来互动吧！" onfocus="show_shadow('input_div')" onblur="hide_shadow('input_div')"></textarea>
            </div>
            <div class="review-rate">
            评分：
              <span onmouseover="light_star(1);" onmouseout="star1_dark();" class="review-star" id="star1"><img src="source/star_dark.png" hsrc="source/star_light.png"></span>
              <span onmouseover="light_star(2);" class="review-star" id="star2"><img src="source/star_dark.png" hsrc="source/star_light.png"></span>
              <span onmouseover="light_star(3);" class="review-star" id="star3"><img src="source/star_dark.png" hsrc="source/star_light.png"></span>
              <span onmouseover="light_star(4);" class="review-star" id="star4"><img src="source/star_dark.png" hsrc="source/star_light.png"></span>
              <span onmouseover="light_star(5);" class="review-star" id="star5"><img src="source/star_dark.png" hsrc="source/star_light.png"></span>
            </div>
            <input class="summit-button" type="button" value="发 布" onclick='post_review(<%=id%>, <%=(online?cookies.get("user_id"):-1)%>);'/>
            <span id="rate-score" style="visibility:hidden">0</span>
        </form>
    </div>

    <div class="movie-review">
      <div class="movie-review-header">
        <span class="movie-review-header-left">最新评论</span>
      </div>
      <div class="review-list" id="review-list">
      <% for(int i = 0; i < reviews.size(); i++){ %>
          <div class="review-user-icon">
            <img class="review-icon-image" src="<%=reviews.get(i).get("icon")%>">
          </div>
          <div class="review-content-body">
            <div><span class="review-user-name"><%=reviews.get(i).get("user_name")%></span></div>
            <span class="star" style="margin-left:5px;"></span><span class="movie-rating" style="visibility:hidden;"><%=reviews.get(i).get("rate")%></span>
            <div><span class="review-time"><%=reviews.get(i).get("time")%></span></div>
            <div class="review-content">
              <%=reviews.get(i).get("content")%>
            </div>
          </div>
      <%}%>
      </div>
    </div>

    <div class="movie-like">
    <div class="movie-like-header">
      <span class="movie-like-header-left">猜你喜欢</span>
    </div>
    <div class="movie-like-content">
      <ul>
        <li>
          <a href="film.jsp?movie_id=<%=movies.get(0).get("id")%>" target="_blank">
            <img src="<%=movies.get(0).get("poster")%>" class="movie-like-poster" alt="<%=movies.get(0).get("name")%>">
          </a>
          <h2>
            <a href="film.jsp?movie_id=<%=movies.get(0).get("id")%>" target="_blank"><%=movies.get(0).get("name")%></a>
          </h2>
          <footer>
            <span class="star"></span>
            <span class="movie-rating"><%=movies.get(0).get("rate")%></span>
          </footer>
        </li>
        <li>
          <a href="film.jsp?movie_id=<%=movies.get(1).get("id")%>" target="_blank">
            <img src="<%=movies.get(1).get("poster")%>" class="movie-like-poster" alt="<%=movies.get(1).get("name")%>">
          </a>
          <h2>
            <a href="film.jsp?movie_id=<%=movies.get(1).get("id")%>" target="_blank"><%=movies.get(1).get("name")%></a>
          </h2>
          <footer>
            <span class="star"></span>
            <span class="movie-rating"><%=movies.get(1).get("rate")%></span>
          </footer>
        </li>
        <li>
          <a href="film.jsp?movie_id=<%=movies.get(2).get("id")%>" target="_blank">
            <img src="<%=movies.get(2).get("poster")%>" class="movie-like-poster" alt="<%=movies.get(2).get("name")%>">
          </a>
          <h2>
            <a href="film.jsp?movie_id=<%=movies.get(2).get("id")%>" target="_blank"><%=movies.get(2).get("name")%></a>
          </h2>
          <footer>
            <span class="star"></span>
            <span class="movie-rating"><%=movies.get(2).get("rate")%></span>
          </footer>
        </li>
        <li>
          <a href="film.jsp?movie_id=<%=movies.get(3).get("id")%>" target="_blank">
            <img src="<%=movies.get(3).get("poster")%>" class="movie-like-poster" alt="<%=movies.get(3).get("name")%>">
          </a>
          <h2>
            <a href="film.jsp?movie_id=<%=movies.get(3).get("id")%>" target="_blank"><%=movies.get(3).get("name")%></a>
          </h2>
          <footer>
            <span class="star"></span>
            <span class="movie-rating"><%=movies.get(3).get("rate")%></span>
          </footer>
        </li>
        <li>
          <a href="https://www.baidu.com" target="_blank">
            <img src="<%=movies.get(4).get("poster")%>" class="movie-like-poster" alt="<%=movies.get(4).get("name")%>">
          </a>
          <h2>
            <a href="film.jsp?movie_id=<%=movies.get(4).get("id")%>" target="_blank"><%=movies.get(4).get("name")%></a>
          </h2>
          <footer>
            <span class="star"></span>
            <span class="movie-rating"><%=movies.get(4).get("rate")%></span>
          </footer>
        </li>
        <li>
          <a href="film.jsp?movie_id=<%=movies.get(5).get("id")%>" target="_blank">
            <img src="<%=movies.get(5).get("poster")%>" class="movie-like-poster" alt="<%=movies.get(5).get("name")%>">
          </a>
          <h2>
            <a href="film.jsp?movie_id=<%=movies.get(5).get("id")%>" target="_blank"><%=movies.get(5).get("name")%></a>
          </h2>
          <footer>
            <span class="star"></span>
            <span class="movie-rating"><%=movies.get(5).get("rate")%></span>
          </footer>
        </li>
      </ul>
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
    <script>
      rating_star();
    </script>
</body>
