<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%><%
    request.setCharacterEncoding("utf-8");

    Cookie[] cookies = request.getCookies();
    Map<String, String> map = new HashMap<>();
    if(cookies!=null){
       for(int i = 0; i < cookies.length; i++){
           map.put(cookies[i].getName(), cookies[i].getValue());
       }
       if(map.containsKey("user_id") && map.containsKey("user_password")){
           String input_password = request.getParameter("password");
           if(input_password.equals(map.get("user_password"))){
                Class.forName("com.mysql.jdbc.Driver");
                String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
                Connection con = DriverManager.getConnection(conStr, "user", "123");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("select * from users where id="+map.get("user_id")+" and password='"+map.get("user_password")+"'");
                if(rs.next()){
                    String new_password = request.getParameter("new_password");
                    rs.close();
                    int cnt1 = stmt.executeUpdate("update users set password='"+new_password+"' where id="+map.get("user_id"));
                    out.print("success");
                    Cookie cookie = new Cookie("user_password", new_password);
                    cookie.setMaxAge(-1);
                    cookie.setPath("/16337250");
                    response.addCookie(cookie);
                }
                
           }
       }
    }
%>