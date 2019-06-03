<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%><% request.setCharacterEncoding("utf-8");
  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  ResultSet rs = stmt.executeQuery("select * from movies order by rate limit 100");
  ArrayList<Map<String, Object>> results = new ArrayList<>();
  while(rs.next()){
      Map<String, Object> map = new HashMap<>();
      map.put("id", rs.getInt("id"));
      map.put("name", rs.getString("name"));
      map.put("poster", rs.getString("poster"));
      map.put("actor", rs.getString("actor"));
      map.put("year", rs.getString("year"));
      map.put("rate", rs.getDouble("rate"));
      map.put("rand_rate", Math.random()*10);
      results.add(map);
  }
  rs.close();
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
<html>

<head>
    <meta charset="utf-8">
    <title>猫瓣电影 | 好电影一网打尽 </title>
    <link rel="icon" href="source/猫爪.png" type="image/x-icon">
    <link type="text/css" rel="stylesheet" href="movie.css">
    <style>
        body {
            font-family: Microsoft YaHei, Helvetica, Arial, sans-serif;
            background-color: #fff;
            -webkit-font-smoothing: subpixel-antialiased;
        }


        div {
            display: block;
        }

        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 998;
            min-width: 1200px;
            background-color: #fff;
            border-bottom: 1px solid #ccc;
        }

        .header-inner {
            width: 1200px;
            margin: 0 auto;
            height: 80px;
        }

        .logo {
            margin-top: 10px;
            margin-left: -30px;
            margin-right: 30px;
            float: left;
            width: 160px;
            height: 50px;
            background: url("source/猫瓣电影.png") no-repeat 0;
            background-size: contain;
        }

        .nav li {
            margin-top: 0px;
            padding: 25px 15px;
            list-style: none;
            float: left;
            font-size: 20px;
        }

        .menu li:nth-child(1) {
            padding-top: 80px;
            margin-left: 25px;
            list-style: none;
        }

        .menu li:nth-child(2) {
            padding-top: 8px;
            margin-left: 25px;
            list-style: none;
        }

        .menu li a {
            color: #333;
            text-decoration: none;
        }


        .menu li a:hover {
            color: #00aeff;
            text-decoration: underline;
        }


        .search,
        .mask {
            position: absolute;
            left: 1085px;
            top : 15px;
            display: inline-block;
            height: 50px;
            line-height: 1.2;
            width: 280px;
            padding: 0 40px 0 20px;
            border: 1px solid #ccc;
            font-size: 14px;
            border-radius: 30px;
            background-color: #faf8fa;
            overflow: hidden;
            color: #333;
            z-index: 995;
            transition: all .2s ease;
        }

        .search:hover {
            transform: translateX(-235px);
            transition: all .2s ease;
        }


        .mask {
            height: 48px;
            border: 1px solid white;
            background-color: white;
            left: 1085px;
            z-index: 996;
        }

        .search:focus {
            outline: none;
        }

        .submit:hover+.search {
            transform: translateX(-235px);
            transition: all .2s ease;
        }

        .submit {
            display: inline-block;
            position: absolute;
            left: 1082px;
            top: 17px;
            height: 48px;
            width: 48px;
            border: 0px;
            border-radius: 30px;
            background: url("source/搜索.png") no-repeat center center;
            background-color: #00aeff;
            cursor: pointer;
            z-index: 997;
        }

        .submit:focus {
            outline: none;
        }

        .user {
            display: inline-block;
            position: absolute;
            margin-top: 15px;
            left: 1150px;
            height: 77px;
            width: 96px;
            border-left: 1px solid transparent;
            overflow: hidden;
            z-index: 998;
        }

        .user:hover {
            background-color: white;
            border-left: 1px solid #ccc;
            border-right: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            z-index: 999;
            height: 150px;
        }

        .user:hover .caret {
            transform: rotate(180deg);
            transition: all .2s ease;
        }

        .img {
            display: inline-block;
            position: absolute;
            left: 14px;
            top: 0px;
            height: 48px;
            width: 48px;
            border: 0px;
            border-radius: 30px;
            background: url("source/登录.png") no-repeat center center;
            background-color: #00aeff;
            cursor: pointer;
        }

        .caret {
            float: left;
            width: 0;
            height: 0;
            margin-top: 37px;
            margin-left: 70px;
            vertical-align: middle;
            border-top: 5px solid #666;
            border-right: 5px solid transparent;
            border-left: 5px solid transparent;
            transition: all .2s ease;
            z-index: 998;
        }

        .nav li a {
            color: black;
            text-decoration: none;
        }

        .nav li a:visited {
            color: black;
            text-decoration: none;
        }

        #board {
            background-color: #00aeff;
        }

        #board a {
            color: white;
        }

        .board-wrapper {
            position: relative;
            top: 100px;
            left: 250px;
            display: block;
            width : 1000px;
        }

        .board-wrapper dl {
            padding: 0;
            margin: 0;
            display: block;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
        }

        .board-wrapper dd {
            padding: 0;
            margin: 0;
            margin-bottom: 30px;
            font-size: 0;
            position: relative;
            overflow: hidden;
        }

        #board-index-1 {
            background: url("source/冠军.png");
            background-size: 100%;
            font-size: 0;
        }

        #board-index-2 {
            background: url("source/亚军.png");
            background-size: 100%;
            font-size: 0;
        }

        #board-index-3 {
            background: url("source/季军.png");
            background-size: 100%;
            font-size: 0;
        }

        .board-index {
            display: inline-block;
            width: 50px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            background: #f7f7f7;
            font-size: 18px;
            color: #999;
            font-weight: 700;
            position: absolute;
            left: 0;
            top: 85px;
        }

        i {
            font-style: italic;
        }

        .board-wrapper .image-link {
            display: inline-block;
            width: 160px;
            height: 220px;
            margin-left: 80px;
            position: relative;
            float: left;
        }

        a {
            text-decoration: none;
            background-color: transparent;
        }

        .board-item-main {
            display: inline-block;
            width: 680px;
            margin-left: 30px;
            height: 219px;
            float: left;
            line-height: 219px;
            border-bottom: 1px solid #e5e5e5;
        }

        .board-item-content {
            display: inline-block;
            vertical-align: middle;
            width: 680px;
            font-size: 0;
            line-height: 1;
        }

        .movie-item-info {
            font-size: 16px;
            display: inline-block;
            width: 420px;
            vertical-align: middle;
        }

        p {
            padding: 0;
            margin: 0;
            display: block;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
        }

        .board-item-content .name a {
            font-size: 26px;
            color: #333;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            width: 420px;
            display: block;
        }

        .board-item-content .star {
            margin-top: 18px;
            color: #333;
        }

        .movie-item-info .star {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .board-item-content .releasetime {
            margin-top: 8px;
            color: #999;
        }

        .movie-item-number {
            display: inline-block;
            text-align: right;
            width: 260px;
            vertical-align: top;
            margin-top: 10px;
            font-size: 16px;
        }

        .boxoffice .realtime {
            color: #00aeff;
            font-size: 20px;
        }

        .boxoffice .total-boxoffice {
            color: #999;
        }

        .stonefont {
            font-family: stonefont;
        }

        img.board-img{
            width : 160px;
            height : 220px;
            box-shadow : 5px -5px 5px #999;
        }
        img.board-img:hover{
            box-shadow : 5px -5px 5px #0AE;
        }

        .board-item-content .name a:hover{
            color : #0AE;
        }
    </style>
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

    <dl class="board-wrapper">
    <% for(int i = 0; i < results.size(); i++){ %>
        <dd>
            <i class="board-index" id="<%
                if(i==0) out.print("board-index-1");
                else if(i==1) out.print("board-index-2");
                else if(i==2) out.print("board-index-3");
                %>"><%=i+1%></i>
            <a href="film.jsp?movie_id=<%=results.get(i).get("id")%>" title="<%=results.get(i).get("name")%>" class="image-link">
                <img alt="<%=results.get(i).get("name")%>" class="board-img" src="<%=results.get(i).get("poster")%>">
            </a>
            <div class="board-item-main">
                <div class="board-item-content">
                    <div class="movie-item-info">
                        <p class="name"><a href="film.jsp?movie_id=<%=results.get(i).get("id")%>" title="<%=results.get(i).get("name")%>"><%=results.get(i).get("name")%></a></p>
                        <p class="star">主演：<%=results.get(i).get("actor")%></p>
                        <p class="releasetime">上映时间：<%=results.get(i).get("year")%></p>
                    </div>
                    <div class="movie-item-number boxoffice">
                        <p class="realtime">实时评分: <span><span class="stonefont"><%=results.get(i).get("rate")%></span></span>分
                        </p>
                        <p class="total-boxoffice">总评分: <span><span class="stonefont"><%=String.format("%.1f",results.get(i).get("rand_rate"))%></span></span>分
                        </p>
                    </div>

                </div>
            </div>
        </dd>
        <%}%>
    </dl>

    <div class="footer" style="visibility:visible; margin-top:200px;">
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

</body>

</html>