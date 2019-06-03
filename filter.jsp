<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%>
<%! int per_page = 28;%>
<% request.setCharacterEncoding("utf-8");
  //try{
  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  ResultSet rs;

  String area = request.getParameter("area");
  String year = request.getParameter("year");
  String kind = request.getParameter("kind");
  String tmp = request.getParameter("page");
  int page_ = tmp == null ? 1 : Integer.parseInt(tmp);

  String parameter = "";
  if(area!=null && (area.equals("全部"))) area=null;
  if(year!=null && (year.equals("全部"))) year=null;
  if(kind!=null && (kind.equals("全部"))) kind=null;
  String forKind = (area==null?"":"&area="+area) + (year==null?"":"&year="+year);
  String forYear = (area==null?"":"&area="+area) + (kind==null?"":"&kind="+kind);
  String forArea = (year==null?"":"&year="+year) + (kind==null?"":"&kind="+kind);
  if(area==null && year==null && kind==null){
      parameter = "";
      rs = stmt.executeQuery("select * from movies");
      area = "全部";
      year = "全部";
      kind = "全部";
  }
  else if(area==null && year==null && kind!=null){
      parameter = "&kind="+kind;
      rs = stmt.executeQuery("select * from movies where kind like'%"+kind+"%'");
      area = "全部";
      year = "全部";
  }
  else if(area==null && year!=null && kind==null){
      parameter = "&year="+year;
      rs = stmt.executeQuery("select * from movies where year like '%"+year+"%'");
      area = "全部";
      kind = "全部";
  }
  else if(area==null && year!=null && kind!=null){
      parameter = "&year="+year+"&kind="+kind;
      rs = stmt.executeQuery("select * from movies where year like '%"+year+"%' and kind like '%"+kind+"%'");
      area = "全部";
  }
  else if(area!=null && year==null && kind==null){
      parameter = "&area="+area;
      rs = stmt.executeQuery("select * from movies where area like'%"+area+"%'");
      year = "全部";
      kind = "全部";
  }
  else if(area!=null && year==null && kind!=null){
      parameter = "&area="+area+"&kind="+kind;
      rs = stmt.executeQuery("select * from movies where area like '%"+area+"%' and kind like '%"+kind+"%'");
      year = "全部";
  }
  else if(area!=null && year!=null && kind==null){
      parameter = "&area="+area+"&year="+year;
      rs = stmt.executeQuery("select * from movies where area like '%"+area+"%' and year like '%"+year+"%'");
      kind = "全部";
  }
  else{
      parameter = "&area="+area+"&year="+year+"&kind="+kind;
      rs = stmt.executeQuery("select * from movies where area like '%"+area+"%' and year like '%"+year+"%' and kind like '%"+kind+"%'");
  }
  
  ArrayList<Map<String, Object>> results = new ArrayList<>();
  while(rs.next()){
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("id", rs.getInt("id"));
      map.put("name", rs.getString("name"));
      map.put("rate", rs.getDouble("rate"));
      map.put("poster", rs.getString("poster"));
      results.add(map);
  }
  String regions[] = {"全部", "中国大陆", "美国", "韩国", "日本", "香港", "台湾", "泰国", "印度", "法国", "英国"};
  String types[] = {"全部", "爱情", "喜剧", "动画", "剧情", "恐怖", "惊悚", "科幻", "动作", "悬疑", "犯罪", "战争", "家庭", "西部", "歌舞", "运动", "武侠", "传记", "奇幻", "儿童", "古装", "历史"};
  String ages[] = {"全部", "2017", "2016", "2014", "2013", "2012", "2011","2010", "2009", "2008", "2006", "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1997"};
  

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

  rs.close();
  stmt.close();
  con.close();

%>
<!DOCTYPE html>
<html>
<head>
    <title>猫瓣电影 | 好电影一网打尽</title>
    <link rel="icon" href="source/猫爪.png" type="image/x-icon">
    <link type="text/css" rel="stylesheet" href="movie.css">
</head>
<body>
    <div class="header">
        <div class="header-inner">

            <a href="index.jsp" class="logo"><img src="source/猫瓣电影.png" alt="猫瓣电影"></a>

            <div class="nav">
                <ul class="navbar">
                    <li id="home"><a href="index.jsp">首页</a></li>
                    <li id="film" class="active"><a href="filter.jsp">电影</a></li>
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

    <div class="filter-container">
        <header>
            <h3>电影筛选</h3>
        </header>
        <div class="filter">
            <ul class="tags-lines">
                <li class="tags-line" data-val="{tagTypeName:'cat'}">
                    <div class="tags-title">类型：</div>
                    <ul class="tags">
                    <% for(int i = 0; i < types.length; i++){%>
                        <li class="<%=kind.equals(types[i])?"active":""%>">
                            <a href="<%=kind.equals(types[i])?"javascript:void(0)":("?kind="+types[i]+forKind)%>"><%=types[i]%></a>
                        </li>
                    <%}%>
                    </ul>
                </li>
                <li class="tags-line" data-val="{tagTypeName:'source'}">
                    <div class="tags-title">区域：</div>
                    <ul class="tags">
                    <% for(int i = 0; i < regions.length; i++){ %>
                        <li class="<%=area.equals(regions[i])?"active":""%>">
                            <a href="<%=area.equals(regions[i])?"javascript:void(0)":("?area="+regions[i]+forArea)%>"><%=regions[i]%></a>
                        </li>
                    <%}%>
                    </ul>
                </li>
                <li class="tags-line" data-val="{tagTypeName:'year'}">
                    <div class="tags-title">年代：</div>
                    <ul class="tags">
                    <% for(int i=0; i < ages.length; i++){ %>
                        <li class="<%=year.equals(ages[i])?"active":""%>">
                            <a href="<%=year.equals(ages[i])?"javascript:void(0)":("?year="+ages[i]+forYear)%>"><%=ages[i]%></a>
                        </li>
                       <%}%>
                    </ul>
                </li>
            </ul>
        </div>
        
    </div>

    <div class="filter-result">
      <div class="filter-header">
        <span class="filter-header-left">筛选结果</span>
      </div>
      <div class="filter-movie-content">
        <ul class="filter-movie-list">
        <% int start = (page_-1) * per_page;
          for(int i = start; i < results.size() && i < start+per_page; i++){%>
          <li class="filter-movie-item">
            <div class="filter-item-content">
              <a href="film.jsp?movie_id=<%=results.get(i).get("id")%>"><img class="filter-movie-img" src="<%=results.get(i).get("poster")%>"></a>
              <div class="filter-movie-info">
                <a class="filter-movie-name" href="film.jsp?movie_id=<%=results.get(i).get("id")%>"><%=results.get(i).get("name")%></a>
                <span class="filter-movie-rate"><%=results.get(i).get("rate")%></span>
              </div>
            </div>
          </li>
          <%}%>
        </ul>
      </div>
    </div>

    <div class="movie-pager">
        <ul class="list-pager">
            <% for(int i = 0; i < results.size(); i+=per_page){
                int cur_page = i / per_page + 1;
                if(cur_page == page_){
            %><li class="active"><a class="page" href="javascript:void(0)" style="cursor:default"><%=cur_page%></a></li><%
                }
                else{
                    %><li><a class="page" href="filter.jsp?page=<%=cur_page+parameter%>" style="cursor:pointer"><%=cur_page%></a></li><%
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
</body>
</html>