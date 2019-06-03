<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8"); response.addHeader("Access-Control-Allow-Origin", "*");%><%
int account = Integer.parseInt(request.getParameter("account"));
String password = request.getParameter("password");
String msg = "";
String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(conStr, "user", "123");
Statement stmt = con.createStatement();
ResultSet rs_user = stmt.executeQuery("select nickname from users where id="+account);
int cnt = 0;
if(rs_user.next()) {
    msg = "账号已经存在！请选择另一个账号";
}
else {
    String sql = String.format("insert into users (id, nickname, password, icon) values (%s, '%s', '%s', '%s')", account, "用户"+String.valueOf(account), password, "icons/default.png");
    cnt = stmt.executeUpdate(sql);
    if(cnt!=0){
        msg="注册成功";
        Cookie cookie_id = new Cookie("user_id", String.valueOf(account));
        cookie_id.setMaxAge(-1);
        cookie_id.setPath("/16337250");
        Cookie cookie_pd = new Cookie("user_password", password);
        cookie_pd.setMaxAge(-1);
        cookie_pd.setPath("/16337250");
        response.addCookie(cookie_id);
        response.addCookie(cookie_pd);
    }
}
%><%=msg%>