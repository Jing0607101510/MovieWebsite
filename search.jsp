<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%>
<%! int num_per_page = 20;%>
<% request.setCharacterEncoding("utf-8");
  //try{
  String keyword = request.getParameter("keyword");
  String tmp = request.getParameter("page");
  int page_ = tmp==null?1:Integer.parseInt(tmp);
  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  ResultSet rs;
  if(keyword!=null)
    rs = stmt.executeQuery("select * from movies where name like '%"+keyword+"%' or director like '%"+keyword+"%' or screenwriter like '%"+keyword+"%' or actor like '%"+keyword+"%'");
  else
    rs = stmt.executeQuery("select * from movies order by RAND() limit 100");
  ArrayList<Map<String, Object>> results  = new ArrayList<>();
  while(rs.next()){
      Map<String, Object> map = new HashMap<>();
      map.put("id", rs.getInt("id"));
      map.put("name", rs.getString("name"));
      map.put("rate", rs.getDouble("rate"));
      map.put("poster", rs.getString("poster"));
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
        <title>猫瓣电影 | 好电影一网打尽 </title>
        <link rel="icon" href="source/猫爪.png" type="image/x-icon">
        <script src="functions.js"></script>
        <link type="text/css" href="movie.css" rel="stylesheet">
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
                    <li id="search" class="active"><a href="search.jsp" id="search">搜索</a></li>
                </ul>
            </div>


            <form action="search.jsp" class="search-form">
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
    <div class="search-result">
        <div class="search-result-header">
            <header>
                <h3>相关影视作品</h3>
            </header>
        </div>
        <div class="movie-grid-result">
            <ul>
            <% int start = (page_-1) * num_per_page; 
            for(int i = start; i < results.size() && i < start+num_per_page; i++){
               %><li>
                    <a href="film.jsp?movie_id=<%=results.get(i).get("id")%>" target="_blank">
                        <img src="<%=results.get(i).get("poster")%>" class="poster" alt="<%=results.get(i).get("name")%>">
                    </a>
                    <h2>
                        <a href="film.jsp?movie_id=<%=results.get(i).get("id")%>" target="_blank"><%=results.get(i).get("name")%></a>
                    </h2>
                    <footer>
                        <span class="star"></span>
                        <span class="movie-rating"><%=results.get(i).get("rate")%></span>
                    </footer>
                </li>
            <%}%>
            </ul>
        </div>
    </div>

    <div class="movie-pager">
        <ul class="list-pager">
            <% for(int i = 0; i < results.size(); i+=num_per_page){
                int cur_page = i / num_per_page + 1;
                if(cur_page == page_){
            %><li class="active"><a class="page" href="javascript:void(0)" style="cursor:default"><%=cur_page%></a></li><%
                }
                else{
                    %><li><a class="page" href="search.jsp?page=<%=cur_page%>" style="cursor:pointer"><%=cur_page%></a></li><%
                }
            }
            %>
        </ul>
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
</html>