<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%><%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%><%@ page import="org.apache.commons.fileupload.*"%><%@ page import="org.apache.commons.fileupload.disk.*"%><%@ page import="org.apache.commons.fileupload.servlet.*"%><%@ page import="java.sql.*"%><%! 
String getFileNameExtension(String filePath){
    File file = new File(filePath);
    String fileName = file.getName();
    String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
    return suffix;
}
%><% request.setCharacterEncoding("utf-8");%><% 
  boolean isMultipart = ServletFileUpload.isMultipartContent(request);//是否用multipart提交的?
  int user_id = 100;

  String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(conStr, "user", "123");
  Statement stmt = con.createStatement();
  Statement stmt2 = con.createStatement();
  int cnt = 0;
  int cnt2 = 0;
  if(isMultipart){
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    List items = upload.parseRequest(request);
    Map<String, Object> map = new HashMap<>();
    for (int i = 0; i < items.size(); i++) {
        FileItem fi = (FileItem) items.get(i);
        if (fi.isFormField()) {//如果是表单字段
            //out.print(fi.getFieldName()+":"+fi.getString("utf-8"));
            map.put(fi.getFieldName(), fi.getString("utf-8"));
        }
        else {//如果是文件
            DiskFileItem dfi = (DiskFileItem) fi;
            if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
               //out.print("文件被上传到服务上的实际位置： ");
                String fileName=application.getRealPath("/icons") + "/" + user_id + "." + getFileNameExtension(dfi.getName());
                //out.print(new File(fileName).getAbsolutePath());
                dfi.write(new File(fileName));
                String filePosition = "/icons/"+user_id+"."+ getFileNameExtension(dfi.getName());
                cnt2 = stmt2.executeUpdate("update users set icon='"+ filePosition +"' where id="+user_id);
            } //if
        } //if
    }

    if(map.get("birthday")!=null&&map.get("birthday")!=""){
      cnt = stmt.executeUpdate("update users set nickname = '"+map.get("nickname")+"', gender='"+map.get("gender")+"', birthday='"+map.get("birthday")+
             "', status='"+map.get("status")+"', career='"+map.get("career")+"', interest='"+map.get("interest")+"', signature='"+map.get("signature")+"' where id="+user_id);
    }
    else{
      cnt = stmt.executeUpdate("update users set nickname = '"+map.get("nickname")+"', gender='"+map.get("gender")+"', birthday=null"+
             ", status='"+map.get("status")+"', career='"+map.get("career")+"', interest='"+map.get("interest")+"', signature='"+map.get("signature")+"' where id="+user_id);
    }
  }

  if(cnt+cnt2>0){
      %>修改成功！<%
  }
  else{
      %>修改失败<%
  }

  
  //try{
//  int id = 100;
//  String nickname = request.getParameter("nickname");
//  String gender = request.getParameter("gender");
//  String birthday = request.getParameter("birthday");
//  String status = request.getParameter("status");
//  String career = request.getParameter("career");
//  String interest = request.getParameter("interest");
//  String signature = request.getParameter("signature");

  
  
  //if(birthday!=""){
  //     cnt = stmt.executeUpdate("update users set nickname = '"+nickname+"', gender='"+gender+"', birthday='"+birthday+
  //           "', status='"+status+"', career='"+career+"', interest='"+interest+"', signature='"+signature+"' where id="+id);
  //}
  //else{
  //     cnt = stmt.executeUpdate("update users set nickname = '"+nickname+"', gender='"+gender+"', birthday=null"+
  //           ", status='"+status+"', career='"+career+"', interest='"+interest+"', signature='"+signature+"' where id="+id);
  //}
//  out.print(id);
// out.print(nickname);
//  out.print(gender);
//  out.print(birthday);
//  out.print(status);
//  out.print(career);
//  out.print(interest);
//  out.print(signature);
%>