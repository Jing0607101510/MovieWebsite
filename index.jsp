<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%><%
    request.setCharacterEncoding("utf-8");
  
    String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    ArrayList<Map<String, Object>> top15_1 = new ArrayList<>();
    ArrayList<Map<String, Object>> top15_2 = new ArrayList<>();
    ArrayList<Map<String, Object>> movieShowing = new ArrayList<>();
    ArrayList<Map<String, Object>> movieWelcome = new ArrayList<>();
    ArrayList<Map<String, Object>> movieNew = new ArrayList<>();
    ArrayList<Map<String, Object>> movieSearch = new ArrayList<>();
    //try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(conStr, "user", "123");
        Statement stmt = con.createStatement();

        ResultSet rs_top15_1 = stmt.executeQuery("select id, name, rate from movies order by rate desc limit 15");
        while(rs_top15_1.next()){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", rs_top15_1.getInt("id"));
            map.put("name", rs_top15_1.getString("name"));
            map.put("rate", rs_top15_1.getDouble("rate"));
            top15_1.add(map);
        }
        rs_top15_1.close();

        ResultSet rs_top15_2 = stmt.executeQuery("select id, name, rate from movies order by year limit 15");
        while(rs_top15_2.next()){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", rs_top15_2.getInt("id"));
            map.put("name", rs_top15_2.getString("name"));
            map.put("rate", rs_top15_2.getDouble("rate"));
            top15_2.add(map);
        }
        rs_top15_2.close();

        ResultSet rs_movieShowing = stmt.executeQuery("select id, name, rate, poster from movies  ORDER BY  RAND() LIMIT 12");
        while(rs_movieShowing.next()){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", rs_movieShowing.getInt("id"));
            map.put("name", rs_movieShowing.getString("name"));
            map.put("rate", rs_movieShowing.getDouble("rate"));
            map.put("poster", rs_movieShowing.getString("poster"));
            movieShowing.add(map);
        }
        rs_movieShowing.close();

        ResultSet rs_movieWelcome = stmt.executeQuery("select id, name, rate, poster from movies  ORDER BY  RAND() LIMIT 12");
        while(rs_movieWelcome.next()){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", rs_movieWelcome.getInt("id"));
            map.put("name", rs_movieWelcome.getString("name"));
            map.put("rate", rs_movieWelcome.getDouble("rate"));
            map.put("poster", rs_movieWelcome.getString("poster"));
            movieWelcome.add(map);
        }
        rs_movieWelcome.close();

        ResultSet rs_movieNew = stmt.executeQuery("select id, name, rate, poster from movies  ORDER BY  RAND() LIMIT 10");
        while(rs_movieNew.next()){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", rs_movieNew.getInt("id"));
            map.put("name", rs_movieNew.getString("name"));
            map.put("rate", rs_movieNew.getDouble("rate"));
            map.put("poster", rs_movieNew.getString("poster"));
            movieNew.add(map);
        }
        rs_movieNew.close();

        ResultSet rs_movieSearch = stmt.executeQuery("select id, name, rate, poster from movies  ORDER BY  RAND() LIMIT 10");
        while(rs_movieSearch.next()){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", rs_movieSearch.getInt("id"));
            map.put("name", rs_movieSearch.getString("name"));
            map.put("rate", rs_movieSearch.getDouble("rate"));
            map.put("poster", rs_movieSearch.getString("poster"));
            movieSearch.add(map);
        }

        
        Boolean online = false;
        Map<String, String> cookies = new HashMap<>();
        Cookie[] cookie_items = request.getCookies();
        if(cookie_items!=null){
          for(Cookie cookie_item : cookie_items){
          cookies.put(cookie_item.getName(), cookie_item.getValue());
          }
          if(cookies.containsKey("user_id")&&cookies.containsKey("user_password")){
            ResultSet rs_online = stmt.executeQuery("select id from users where id="+cookies.get("user_id")+" and password='"+cookies.get("user_password")+"'");
            if(rs_online.next()){
              online=true;
            }
            rs_online.close();
          }
        }
        

        rs_movieSearch.close(); 
        stmt.close(); 
        con.close();
    //}   
    //catch(Exception e){
    //    msg = e.getMessage();
    //}                
%>
<!DOCTYPE html>
<html>
<head>
  <title>猫瓣电影 | 好电影一网打尽</title>
  <link rel="icon" href="source/猫爪.png" type="image/x-icon">
  <link type="text/css" rel="stylesheet" href="movie.css">
  <script src="functions.js"></script>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Cache-Control" content="no-cache">
  <meta http-equiv="Expires" content="0">
</head>
<body>
<div class="header">
        <div class="header-inner">

            <a href="index.jsp" class="logo"><img src="source/猫瓣电影.png" alt="猫瓣电影"></a>

            <div class="nav">
                <ul class="navbar">
                    <li id="home" class="active"><a href="index.jsp">首页</a></li>
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

            <% if(online==false){%>
            <div class="user">
                <div class="img"></div>
                <span class="caret"></span>
                <ul class="menu">
                    <li><a href="login.html">登录</a></li>
                    <li><a href="register.html">注册</a></li>
                </ul>
            </div>
            <%} else{ %>
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



  <div class="part1">
    <div class="wrapper">
          <div class="panel">
            <div class="panel-header">
              <span class="panel-title-left">电影排行榜</span>
              <span class="panel-title-right">Top 15</span>
            </div>
            <div class="panel-content">
              <ul class="top15">
                <li class="ranking-item top1">
                  <a href="film.jsp?movie_id=<%=top15_1.get(0).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">1</i>
                      <span class="ranking-movie-name"><%=top15_1.get(0).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_1.get(0).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li> 
                <li class="ranking-item top2">
                  <a href="film.jsp?movie_id=<%=top15_1.get(1).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">2</i>
                      <span class="ranking-movie-name"><%=top15_1.get(1).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_1.get(1).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li> 
                <li class="ranking-item top3">
                  <a href="film.jsp?movie_id=<%=top15_1.get(2).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">3</i>
                      <span class="ranking-movie-name"><%=top15_1.get(2).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_1.get(2).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li>
                <li class="ranking-item top4">
                    <a href="film.jsp?movie_id=<%=top15_1.get(3).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">4</i>
                        <span class="ranking-movie-name"><%=top15_1.get(3).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(3).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li>
                <li class="ranking-item top5">
                    <a href="film.jsp?movie_id=<%=top15_1.get(4).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">5</i>
                        <span class="ranking-movie-name"><%=top15_1.get(4).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(4).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top6">
                    <a href="film.jsp?movie_id=<%=top15_1.get(5).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">6</i>
                        <span class="ranking-movie-name"><%=top15_1.get(5).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(5).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li>
                <li class="ranking-item top7">
                    <a href="film.jsp?movie_id=<%=top15_1.get(6).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">7</i>
                        <span class="ranking-movie-name"><%=top15_1.get(6).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(6).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top8">
                    <a href="film.jsp?movie_id=<%=top15_1.get(7).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">8</i>
                        <span class="ranking-movie-name"><%=top15_1.get(7).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(7).get("rate")%></span>分</span>
                      </span>
                  </a>
                </li>
                <li class="ranking-item top9">
                  <a href="film.jsp?movie_id=<%=top15_1.get(8).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">9</i>
                      <span class="ranking-movie-name"><%=top15_1.get(8).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_1.get(8).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li>
                <li class="ranking-item top10">
                    <a href="film.jsp?movie_id=<%=top15_1.get(9).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">10</i>
                        <span class="ranking-movie-name"><%=top15_1.get(9).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(9).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top11">
                    <a href="film.jsp?movie_id=<%=top15_1.get(10).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">11</i>
                        <span class="ranking-movie-name"><%=top15_1.get(10).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(10).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top12">
                    <a href="film.jsp?movie_id=<%=top15_1.get(11).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">12</i>
                        <span class="ranking-movie-name"><%=top15_1.get(11).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(11).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top13">
                    <a href="film.jsp?movie_id=<%=top15_1.get(12).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">13</i>
                        <span class="ranking-movie-name"><%=top15_1.get(12).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(12).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top14">
                    <a href="film.jsp?movie_id=<%=top15_1.get(13).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">14</i>
                        <span class="ranking-movie-name"><%=top15_1.get(13).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(13).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top15">
                    <a href="film.jsp?movie_id=<%=top15_1.get(14).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">15</i>
                        <span class="ranking-movie-name"><%=top15_1.get(14).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_1.get(14).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
              </ul>
            </div>
          </div>
    </div>

    <div class="movie-grid">
      <div class="movie-grid-header">
        <span class="movie-grid-header-left">正在上映</span>
        <%-- <span class="movie-grid-header-right"><a href="film.jsp" target="_blank">更多>></a></span> --%>
      </div>
      <div class="movie-grid-content">
        <ul>
          <li>
            <a href="film.jsp?movie_id=<%=movieShowing.get(0).get("id")%>" target="_blank">
              <img src="<%=movieShowing.get(0).get("poster")%>" class="poster" alt="<%=movieShowing.get(0).get("name")%>">
            </a>
            <h2>
              <a href="film.jsp?movie_id=<%=movieShowing.get(0).get("id")%>" target="_blank"><%=movieShowing.get(0).get("name")%></a>
            </h2>
            <footer>
              <span class="star"></span>
              <span class="movie-rating"><%=movieShowing.get(0).get("rate")%></span>
            </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(1).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(1).get("poster")%>" class="poster" alt="<%=movieShowing.get(1).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(1).get("id")%>" target="_blank"><%=movieShowing.get(1).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(1).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(2).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(2).get("poster")%>" class="poster" alt="<%=movieShowing.get(2).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(2).get("id")%>" target="_blank"><%=movieShowing.get(2).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(2).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(3).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(3).get("poster")%>" class="poster" alt="<%=movieShowing.get(3).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(3).get("id")%>" target="_blank"><%=movieShowing.get(3).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(3).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(4).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(4).get("poster")%>" class="poster" alt="<%=movieShowing.get(4).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(4).get("id")%>" target="_blank"><%=movieShowing.get(4).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(4).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(5).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(5).get("poster")%>" class="poster" alt="<%=movieShowing.get(5).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(5).get("id")%>" target="_blank"><%=movieShowing.get(5).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(5).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(6).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(6).get("poster")%>" class="poster" alt="<%=movieShowing.get(6).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(6).get("id")%>" target="_blank"><%=movieShowing.get(6).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(6).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(7).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(7).get("poster")%>" class="poster" alt="<%=movieShowing.get(7).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(7).get("id")%>" target="_blank"><%=movieShowing.get(7).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(7).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(8).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(8).get("poster")%>" class="poster" alt="<%=movieShowing.get(8).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(8).get("id")%>" target="_blank"><%=movieShowing.get(8).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(8).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(9).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(9).get("poster")%>" class="poster" alt="<%=movieShowing.get(9).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(9).get("id")%>" target="_blank"><%=movieShowing.get(9).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(9).get("rate")%></span>
              </footer>
          </li>
          <li>
              <a href="film.jsp?movie_id=<%=movieShowing.get(10).get("id")%>" target="_blank">
                <img src="<%=movieShowing.get(10).get("poster")%>" class="poster" alt="<%=movieShowing.get(10).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieShowing.get(10).get("id")%>" target="_blank"><%=movieShowing.get(10).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieShowing.get(10).get("rate")%></span>
              </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieShowing.get(11).get("id")%>" target="_blank">
                  <img src="<%=movieShowing.get(11).get("poster")%>" class="poster" alt="<%=movieShowing.get(11).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieShowing.get(11).get("id")%>" target="_blank"><%=movieShowing.get(11).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieShowing.get(11).get("rate")%></span>
                </footer>
              </li>
        </ul>
      </div>
    </div>
  </div>

  <div class="part4">
      <div class="movie-grid">
        <div class="movie-grid-header">
          <span class="movie-grid-header-left">热门电影</span>
          <!-- <span class="movie-grid-header-right"><a href="film.jsp" target="_blank">更多>></a></span> -->
        </div>
        <div class="movie-grid-content">
          <ul>
            <li>
              <a href="film.jsp?movie_id=<%=movieWelcome.get(0).get("id")%>" target="_blank">
                <img src="<%=movieWelcome.get(0).get("poster")%>" class="poster" alt="<%=movieWelcome.get(0).get("name")%>">
              </a>
              <h2>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(0).get("id")%>" target="_blank"><%=movieWelcome.get(0).get("name")%></a>
              </h2>
              <footer>
                <span class="star"></span>
                <span class="movie-rating"><%=movieWelcome.get(0).get("rate")%></span>
              </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(1).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(1).get("poster")%>" class="poster" alt="<%=movieWelcome.get(1).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(1).get("id")%>" target="_blank"><%=movieWelcome.get(1).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(1).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(2).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(2).get("poster")%>" class="poster" alt="<%=movieWelcome.get(2).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(2).get("id")%>" target="_blank"><%=movieWelcome.get(2).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(2).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(3).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(3).get("poster")%>" class="poster" alt="<%=movieWelcome.get(3).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(3).get("id")%>" target="_blank"><%=movieWelcome.get(3).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(3).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(4).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(4).get("poster")%>" class="poster" alt="<%=movieWelcome.get(4).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(4).get("id")%>" target="_blank"><%=movieWelcome.get(4).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(4).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(5).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(5).get("poster")%>" class="poster" alt="<%=movieWelcome.get(5).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(5).get("id")%>" target="_blank"><%=movieWelcome.get(5).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(5).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(6).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(6).get("poster")%>" class="poster" alt="<%=movieWelcome.get(6).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(6).get("id")%>" target="_blank"><%=movieWelcome.get(6).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(6).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(7).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(7).get("poster")%>" class="poster" alt="<%=movieWelcome.get(7).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(7).get("id")%>" target="_blank"><%=movieWelcome.get(7).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(7).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(8).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(8).get("poster")%>" class="poster" alt="<%=movieWelcome.get(8).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(8).get("id")%>" target="_blank"><%=movieWelcome.get(8).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(8).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(9).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(9).get("poster")%>" class="poster" alt="<%=movieWelcome.get(9).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(9).get("id")%>" target="_blank"><%=movieWelcome.get(9).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(9).get("rate")%></span>
                </footer>
            </li>
            <li>
                <a href="film.jsp?movie_id=<%=movieWelcome.get(10).get("id")%>" target="_blank">
                  <img src="<%=movieWelcome.get(10).get("poster")%>" class="poster" alt="<%=movieWelcome.get(10).get("name")%>">
                </a>
                <h2>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(10).get("id")%>" target="_blank"><%=movieWelcome.get(10).get("name")%></a>
                </h2>
                <footer>
                  <span class="star"></span>
                  <span class="movie-rating"><%=movieWelcome.get(10).get("rate")%></span>
                </footer>
              </li>
              <li>
                  <a href="film.jsp?movie_id=<%=movieWelcome.get(11).get("id")%>" target="_blank">
                    <img src="<%=movieWelcome.get(11).get("poster")%>" class="poster" alt="<%=movieWelcome.get(11).get("name")%>">
                  </a>
                  <h2>
                    <a href="film.jsp?movie_id=<%=movieWelcome.get(11).get("id")%>" target="_blank"><%=movieWelcome.get(11).get("name")%></a>
                  </h2>
                  <footer>
                    <span class="star"></span>
                    <span class="movie-rating"><%=movieWelcome.get(11).get("rate")%></span>
                  </footer>
                </li>
          </ul>
        </div>
      </div>
      <div class="wrapper">
          <div class="panel">
            <div class="panel-header">
              <span class="panel-title-left">最受欢迎</span>
              <span class="panel-title-right">Top 15</span>
            </div>
            <div class="panel-content">
              <ul class="top15">
                <li class="ranking-item top1">
                  <a href="film.jsp?movie_id=<%=top15_2.get(0).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">1</i>
                      <span class="ranking-movie-name"><%=top15_2.get(0).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_2.get(0).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li> 
                <li class="ranking-item top2">
                  <a href="film.jsp?movie_id=<%=top15_2.get(1).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">2</i>
                      <span class="ranking-movie-name"><%=top15_2.get(1).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_2.get(1).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li> 
                <li class="ranking-item top3">
                  <a href="film.jsp?movie_id=<%=top15_2.get(2).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">3</i>
                      <span class="ranking-movie-name"><%=top15_2.get(2).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_2.get(2).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li>
                <li class="ranking-item top4">
                    <a href="film.jsp?movie_id=<%=top15_2.get(3).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">4</i>
                        <span class="ranking-movie-name"><%=top15_2.get(3).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(3).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li>
                <li class="ranking-item top5">
                    <a href="film.jsp?movie_id=<%=top15_2.get(4).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">5</i>
                        <span class="ranking-movie-name"><%=top15_2.get(4).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(4).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top6">
                    <a href="film.jsp?movie_id=<%=top15_2.get(5).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">6</i>
                        <span class="ranking-movie-name"><%=top15_2.get(5).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(5).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li>
                <li class="ranking-item top7">
                    <a href="film.jsp?movie_id=<%=top15_2.get(6).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">7</i>
                        <span class="ranking-movie-name"><%=top15_2.get(6).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(6).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top8">
                    <a href="film.jsp?movie_id=<%=top15_2.get(7).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">8</i>
                        <span class="ranking-movie-name"><%=top15_2.get(7).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(7).get("rate")%></span>分</span>
                      </span>
                  </a>
                </li>
                <li class="ranking-item top9">
                  <a href="film.jsp?movie_id=<%=top15_2.get(8).get("id")%>" target="_blank">
                    <span>
                      <i class="ranking-index">9</i>
                      <span class="ranking-movie-name"><%=top15_2.get(8).get("name")%></span>
                      <span class="moive-rate"><span class="rating"><%=top15_2.get(8).get("rate")%></span>分</span>
                    </span>
                  </a>
                </li>
                <li class="ranking-item top10">
                    <a href="film.jsp?movie_id=<%=top15_2.get(9).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">10</i>
                        <span class="ranking-movie-name"><%=top15_2.get(9).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(9).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top11">
                    <a href="film.jsp?movie_id=<%=top15_2.get(10).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">11</i>
                        <span class="ranking-movie-name"><%=top15_2.get(10).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(10).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top12">
                    <a href="film.jsp?movie_id=<%=top15_2.get(11).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">12</i>
                        <span class="ranking-movie-name"><%=top15_2.get(11).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(11).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top13">
                    <a href="film.jsp?movie_id=<%=top15_2.get(12).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">13</i>
                        <span class="ranking-movie-name"><%=top15_2.get(12).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(12).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top14">
                    <a href="film.jsp?movie_id=<%=top15_2.get(13).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">14</i>
                        <span class="ranking-movie-name"><%=top15_2.get(13).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(13).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
                <li class="ranking-item top15">
                    <a href="film.jsp?movie_id=<%=top15_2.get(14).get("id")%>" target="_blank">
                      <span>
                        <i class="ranking-index">15</i>
                        <span class="ranking-movie-name"><%=top15_2.get(14).get("name")%></span>
                        <span class="moive-rate"><span class="rating"><%=top15_2.get(14).get("rate")%></span>分</span>
                      </span>
                    </a>
                </li> 
              </ul>
            </div>
          </div>
    </div>
  </div>

  <div class="part3">
    <div class="new-header">
      <span class="new-header-left">最新上线</span>
      <!-- <span class="new-header-right"><a href="https://www.baiduc.com">更多>></a></span> -->
    </div>
    <div class="new-movie-content">
      <ul class="new-movie-list">
        <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieNew.get(0).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(0).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(0).get("id")%>"><%=movieNew.get(0).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieNew.get(0).get("rate")%></span>
              </div>
            </div>
        </li>
        <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieNew.get(1).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(1).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(1).get("id")%>"><%=movieNew.get(1).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieNew.get(1).get("rate")%></span>
              </div>
            </div>
        </li>
        <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieNew.get(2).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(2).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(2).get("id")%>"><%=movieNew.get(2).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieNew.get(2).get("rate")%></span>
              </div>
            </div>
        </li>
        <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieNew.get(3).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(3).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(3).get("id")%>"><%=movieNew.get(3).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieNew.get(3).get("rate")%></span>
              </div>
            </div>
        </li>
        <li class="new-movie-item">
          <div class="item-content">
            <a href="film.jsp?movie_id=<%=movieNew.get(4).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(4).get("poster")%>"></a>
            <div class="new-movie-info">
              <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(4).get("id")%>"><%=movieNew.get(4).get("name")%></a></h2>
              <span class="new-movie-rate"><%=movieNew.get(4).get("rate")%></span>
            </div>
          </div>
        </li>
        <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieNew.get(5).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(5).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(5).get("id")%>"><%=movieNew.get(5).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieNew.get(5).get("rate")%></span>
              </div>
            </div>
          </li>
          <li class="new-movie-item">
              <div class="item-content">
                <a href="film.jsp?movie_id=<%=movieNew.get(6).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(6).get("poster")%>"></a>
                <div class="new-movie-info">
                  <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(6).get("id")%>"><%=movieNew.get(6).get("name")%></a></h2>
                  <span class="new-movie-rate"><%=movieNew.get(6).get("rate")%></span>
                </div>
              </div>
            </li>
            <li class="new-movie-item">
                <div class="item-content">
                  <a href="film.jsp?movie_id=<%=movieNew.get(7).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(7).get("poster")%>"></a>
                  <div class="new-movie-info">
                    <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(7).get("id")%>"><%=movieNew.get(7).get("name")%></a></h2>
                    <span class="new-movie-rate"><%=movieNew.get(7).get("rate")%></span>
                  </div>
                </div>
              </li>
              <li class="new-movie-item">
                  <div class="item-content">
                    <a href="film.jsp?movie_id=<%=movieNew.get(8).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(8).get("poster")%>"></a>
                    <div class="new-movie-info">
                      <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(8).get("id")%>"><%=movieNew.get(8).get("name")%></a></h2>
                      <span class="new-movie-rate"><%=movieNew.get(8).get("rate")%></span>
                    </div>
                  </div>
                </li>
                <li class="new-movie-item">
                    <div class="item-content">
                      <a href="film.jsp?movie_id=<%=movieNew.get(9).get("id")%>"><img class="new-movie-img" src="<%=movieNew.get(9).get("poster")%>"></a>
                      <div class="new-movie-info">
                        <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieNew.get(9).get("id")%>"><%=movieNew.get(9).get("name")%></a></h2>
                        <span class="new-movie-rate"><%=movieNew.get(9).get("rate")%></span>
                      </div>
                    </div>
                  </li>
      </ul>
    </div>
  </div>

  <div class="part5">
      <div class="new-header">
        <span class="new-header-left">热搜推荐</span>
      </div>
      <div class="new-movie-content">
        <ul class="new-movie-list">
          <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieSearch.get(0).get("id")%>"><img class="new-movie-img" src="<%=movieSearch.get(0).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieSearch.get(0).get("id")%>"><%=movieSearch.get(0).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieSearch.get(0).get("rate")%></span>
              </div>
            </div>
          </li>
          <li class="new-movie-item">
              <div class="item-content">
                <a href="film.jsp?movie_id=<%=movieSearch.get(1).get("id")%>"><img class="new-movie-img" src="<%=movieSearch.get(1).get("poster")%>"></a>
                <div class="new-movie-info">
                  <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieSearch.get(1).get("id")%>"><%=movieSearch.get(1).get("name")%></a></h2>
                  <span class="new-movie-rate"><%=movieSearch.get(1).get("rate")%></span>
                </div>
              </div>
          </li>
          <li class="new-movie-item">
              <div class="item-content">
                <a href="film.jsp?movie_id=<%=movieSearch.get(2).get("id")%>"><img class="new-movie-img" src="<%=movieSearch.get(2).get("poster")%>"></a>
                <div class="new-movie-info">
                  <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieSearch.get(2).get("id")%>"><%=movieSearch.get(2).get("name")%></a></h2>
                  <span class="new-movie-rate"><%=movieSearch.get(2).get("rate")%></span>
                </div>
              </div>
          </li>
          <li class="new-movie-item">
              <div class="item-content">
                <a href="film.jsp?movie_id=<%=movieSearch.get(3).get("id")%>"><img class="new-movie-img" src="<%=movieSearch.get(3).get("poster")%>"></a>
                <div class="new-movie-info">
                  <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieSearch.get(3).get("id")%>"><%=movieSearch.get(3).get("name")%></a></h2>
                  <span class="new-movie-rate"><%=movieSearch.get(3).get("rate")%></span>
                </div>
              </div>
          </li>
          <li class="new-movie-item">
            <div class="item-content">
              <a href="film.jsp?movie_id=<%=movieSearch.get(4).get("id")%>"><img class="new-movie-img" src="<%=movieSearch.get(4).get("poster")%>"></a>
              <div class="new-movie-info">
                <h2><a class="new-movie-name" href="film.jsp?movie_id=<%=movieSearch.get(4).get("id")%>"><%=movieSearch.get(4).get("name")%></a></h2>
                <span class="new-movie-rate"><%=movieSearch.get(4).get("rate")%></span>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>

  <%-- <div class="part2"> --%>
      <%-- <div class="review-header">
        <span class="review-header-left">热门影评</span>
        <!-- <span class="review-header-right"><a href="film.jsp" target="_blank">更多>></a></span> -->
      </div>
      <div class="review">
          <div class="user-icon">
            <img class="icon-image" src="fuchouzhelianmeng.jpg">
          </div>
          <div class="review-body">
            <h3><span class="user-name">复仇者</span> &nbsp;&nbsp; 评论 &nbsp;&nbsp; <span class="movie-name">《复仇者联盟》</span></h3>
            <div class="review-content">
              为什么这么好看？
            </div>
          </div>
      </div>
      <div class="review">
          <div class="user-icon">
            <img class="icon-image" src="fuchouzhelianmeng.jpg">
          </div>
          <div class="review-body">
            <h3><span class="user-name">复仇者</span> &nbsp;&nbsp; 评论 &nbsp;&nbsp; <span class="movie-name">《复仇者联盟》</span></h3>
            <div class="review-content">
              为什么这么好看？
            </div>
          </div>
      </div>
      <div class="review">
          <div class="user-icon">
            <img class="icon-image" src="fuchouzhelianmeng.jpg">
          </div>
          <div class="review-body">
            <h3><span class="user-name">复仇者</span> &nbsp;&nbsp; 评论 &nbsp;&nbsp; <span class="movie-name">《复仇者联盟》</span></h3>
            <div class="review-content">
              为什么这么好看？
            </div>
          </div>
      </div>
      <div class="review">
          <div class="user-icon">
            <img class="icon-image" src="fuchouzhelianmeng.jpg">
          </div>
          <div class="review-body">
            <h3><span class="user-name">复仇者</span> &nbsp;&nbsp; 评论 &nbsp;&nbsp; <span class="movie-name">《复仇者联盟》</span></h3>
            <div class="review-content">
              为什么这么好看？
            </div>
          </div>
      </div>
      <div class="review">
          <div class="user-icon">
            <img class="icon-image" src="fuchouzhelianmeng.jpg">
          </div>
          <div class="review-body">
            <h3><span class="user-name">复仇者</span> &nbsp;&nbsp; 评论 &nbsp;&nbsp; <span class="movie-name">《复仇者联盟》</span></h3>
            <div class="review-content">
              为什么这么好看？
            </div>
          </div>
      </div>
      <div class="review">
          <div class="user-icon">
            <img class="icon-image" src="fuchouzhelianmeng.jpg">
          </div>
          <div class="review-body">
            <h3><span class="user-name">复仇者</span> &nbsp;&nbsp; 评论 &nbsp;&nbsp; <span class="movie-name">《复仇者联盟》</span></h3>
            <div class="review-content">
              为什么这么好看？
            </div>
          </div>
      </div>
    </div> --%>

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