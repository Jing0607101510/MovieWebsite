<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%><%
    request.setCharacterEncoding("utf-8");

    Cookie[] cookies = request.getCookies();
    Map<String, String> map = new HashMap<>();
    if(cookies!=null){
       for(int i = 0; i < cookies.length; i++){
           if(cookies[i].getName().equals("user_id") || cookies[i].getName().equals("user_password")){
               cookies[i].setMaxAge(0);
               response.addCookie(cookies[i]);
           }
           map.put(cookies[i].getName(), cookies[i].getValue());
       }
       if(map.containsKey("user_id") && map.containsKey("user_password")){
           Class.forName("com.mysql.jdbc.Driver");
           String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
           Connection con = DriverManager.getConnection(conStr, "user", "123");
           Statement stmt = con.createStatement();
           ResultSet rs = stmt.executeQuery("select * from users where id="+map.get("user_id")+" and password='"+map.get("user_password")+"'");
           if(rs.next()){
               rs.close();
               int cnt1 = stmt.executeUpdate("delete from reviews where user_id="+map.get("user_id"));
               int cnt2 = stmt.executeUpdate("delete from users where id="+map.get("user_id"));
           }
       }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>猫瓣电影 | 好电影一网打尽</title>
    <link rel="icon" href="source/猫爪.png" type="image/x-icon">
    <script> 
        window.history.go(-1);
    </script>
</head>
<body></body>
</html>