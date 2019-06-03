<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%>
<% request.setCharacterEncoding("utf-8");
   Cookie[] cookies = request.getCookies();
   if(cookies!=null){
       for(int i = 0; i < cookies.length; i++){
           if(cookies[i].getName().equals("user_id") || cookies[i].getName().equals("user_password")){
               cookies[i].setMaxAge(0);
               response.addCookie(cookies[i]);
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