<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"
%><%
    request.setCharacterEncoding("utf-8");  
    String conStr = "jdbc:mysql://localhost:53306/movie_16337250"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(conStr, "user", "123");
    Statement stmt = con.createStatement();

    String id = "-1";
    Map<String, String> cookies = new HashMap<>();
    Cookie[] cookie_items = request.getCookies();
    if(cookie_items!=null){
        for(Cookie cookie_item : cookie_items){
            cookies.put(cookie_item.getName(), cookie_item.getValue());
        }
        if(cookies.containsKey("user_id")&&cookies.containsKey("user_password")){
            id = cookies.get("user_id");
        }
    }    
    
    Statement stmt1 = con.createStatement();
    ResultSet rs = stmt.executeQuery("select user_name, movie_id, movie_name, content, time, rate from reviews where user_id="+id+" order by time desc");
    ArrayList<Map<String, Object>> reviews = new ArrayList<>();
    while(rs.next()){
        Map<String, Object> map = new HashMap<>();
        map.put("user_name", rs.getString("user_name"));
        map.put("movie_id", rs.getInt("movie_id"));
        map.put("movie_name", rs.getString("movie_name"));
        map.put("content", rs.getString("content"));
        map.put("time", rs.getDate("time"));
        map.put("rate", rs.getDouble("rate"));
        ResultSet rs_icon = stmt1.executeQuery("select icon from users where id="+id);
        rs_icon.next();
        map.put("icon", rs_icon.getString("icon"));
        reviews.add(map);
    }

%>    

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>猫瓣电影 | 好电影一网打尽 </title>
    <link rel="icon" href="source/猫爪.png" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="personal_review.css">
    <script src="functions.js"></script>
    <script>

        function account_blur() {
            var x = document.getElementById("account").value;
            var y = document.getElementById("span-account-tip");
            if (x == '' || x == undefined || x == null) {
                y.style.visibility = "visible";
            }
            else {
                y.style.visibility = "hidden";
            }
        }
        function password_blur() {
            var x = document.getElementById("password").value;
            var y = document.getElementById("span-password-tip");
            if (x == '' || x == undefined || x == null) {
                y.style.visibility = "visible";
            }
            else {
                y.style.visibility = "hidden";
            }
        }
        function password_input() {
            var x = document.getElementById("password").value;
            var weak = document.getElementById("weak");
            var normal = document.getElementById("normal");
            var strong = document.getElementById("strong");
            if (x == '' || x == undefined || x == null) {

            }
            else if (x.length < 6) {
                weak.style.background = "#DC143C";
                normal.style.background = "#CCC";
                strong.style.background = "#CCC";
            }
            else if (x.length < 12) {
                weak.style.background = "#FFD700";
                normal.style.background = "#FFD700";
                strong.style.background = "#CCC";
            }
            else {
                weak.style.background = "#00FF00";
                normal.style.background = "#00FF00";
                strong.style.background = "#00FF00";
            }
        }

        function confirm_blur() {
            var x = document.getElementById("confirm").value;
            var y = document.getElementById("password").value;
            var z = document.getElementById("span-confirm-tip");
            var u = document.getElementById("confirm-error");
            if (x == '' || x == undefined || x == null) {
                z.style.visibility = "visible";
            }
            else if (x != y) {
                z.style.visibility = "visible";
                u.innerText = "前后密码不一致"
            }
            else {
                z.style.visibility = "hidden";
            }
        }

        function query_click() {
            var query_div = document.getElementById("query");
            var update_div = document.getElementById("update");
            var delete_div = document.getElementById("delete");
            var query_li = document.getElementById("query_li");
            var update_li = document.getElementById("update_li");
            var delete_li = document.getElementById("delete_li");
            var query_con = document.getElementById("avatar-container");
            var update_con = document.getElementById("update-container")
            var delete_con = document.getElementById("delete-container");
            var user_form = document.getElementById("userexinfo-form");
            var title = document.getElementById("user-title");
            title.innerHTML = "基本信息";
            query_con.style.visibility = "visible";
            update_con.style.visibility = "hidden";
            delete_con.style.visibility = "hidden";
            user_form.style.visibility = "visible";
            query_div.style.background = "#00aeff";
            update_div.style.background = "#f4f3f4";
            delete_div.style.background = "#f4f3f4";
            query_li.style.color = "#fff"
            update_li.style.color = "#000"
            delete_li.style.color = "#000"
        }

        function update_click() {
            var query_div = document.getElementById("query");
            var update_div = document.getElementById("update");
            var delete_div = document.getElementById("delete");
            var query_li = document.getElementById("query_li");
            var update_li = document.getElementById("update_li");
            var delete_li = document.getElementById("delete_li");
            var query_con = document.getElementById("avatar-container");
            var update_con = document.getElementById("update-container")
            var delete_con = document.getElementById("delete-container");
            var user_form = document.getElementById("userexinfo-form");
            var title = document.getElementById("user-title");
            title.innerHTML = "修改密码";
            query_con.style.visibility = "hidden";
            update_con.style.visibility = "visible";
            delete_con.style.visibility = "hidden";
            user_form.style.visibility = "hidden";
            query_div.style.background = "#f4f3f4";
            update_div.style.background = "#00aeff";
            delete_div.style.background = "#f4f3f4";
            query_li.style.color = "#000"
            update_li.style.color = "#fff"
            delete_li.style.color = "#000"
        }

        function delete_click() {
            var query_div = document.getElementById("query");
            var update_div = document.getElementById("update");
            var delete_div = document.getElementById("delete");
            var query_li = document.getElementById("query_li");
            var update_li = document.getElementById("update_li");
            var delete_li = document.getElementById("delete_li");
            var query_con = document.getElementById("avatar-container");
            var update_con = document.getElementById("update-container");
            var delete_con = document.getElementById("delete-container");
            var user_form = document.getElementById("userexinfo-form");
            var title = document.getElementById("user-title");
            title.innerHTML = "我的评论";
            query_con.style.visibility = "hidden";
            update_con.style.visibility = "hidden";
            delete_con.style.visibility = "visible";
            user_form.style.visibility = "hidden";
            query_div.style.background = "#f4f3f4";
            update_div.style.background = "#f4f3f4";
            delete_div.style.background = "#00aeff";
            query_li.style.color = "#000"
            update_li.style.color = "#000"
            delete_li.style.color = "#fff"
        }
    </script>

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
            height: 60px;
        }

        .logo {
            margin-top: -5px;
            margin-left: -30px;
            margin-right: 30px;
            float: left;
            width: 160px;
            height: 50px;
            background: url("source/猫瓣电影.png") no-repeat 0;
            background-size: contain;
        }

        .nav li {
            margin-top: -16px;
            padding: 25px 15px;
            list-style: none;
            float: left;
            font-size: 20px;
        }

        .menu li:nth-child(1) {
            padding-top: 70px;
            margin-left: -40px;
            list-style: none;
        }

        .menu li:nth-child(2) {
            padding-top: 8px;
            margin-left: -40px;
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
            margin-top: -16px;
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
            transition: .2s linear;
        }

        .img {
            display: inline-block;
            position: absolute;
            left: 14px;
            top: 17px;
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
        }

        .nav li a {
            color: black;
            text-decoration: none;
        }

        .nav li a:visited {
            color: black;
            text-decoration: none;
        }

        .menu li a {
            font-size: 14px;
        }

        .content {
            width: 1200px;
            height: 650px;
            border: 1px solid #ccc;
            margin: 100px auto;
        }

        .user-nav {
            position: absolute;
            top: 101px;
            bottom: 0;
            width: 200px;
            height: 649px;
            background-color: #f4f3f4;
            text-align: center;
            border-right: 1px solid #e1e1e1;
        }

        #query {
            margin-left: -40px;
            width: 199.5px;
            height: 60px;
            background-color: #00aeff;
            cursor: pointer;
        }

        #query li {
            color: white;
        }

        #update,
        #delete {
            cursor: pointer;
        }

        #update,
        #delete,
        #empty {
            margin: 0;
            margin-left: -40px;
            width: 199.5px;
            height: 60px;
        }

        .user-nav ul {
            list-style: none;
        }

        .user-nav ul li {
            padding: 20px;
            color: #333;
            vertical-align: middle;
            text-decoration: none;
            height: 100%;
        }

        .user-content {
            float: left;
            margin-left: 200px;
            padding-left: 40px;
            width: 922px;
        }

        .user-title {
            text-align: left;
            padding: 26px 0;
            color: #00aeff;
            font-size: 18px;
            border-bottom: 1px solid #e1e1e1;
            margin-bottom: 30px;
        }

        .avatar-container {
            position: absolute;
            top: 220px;
            left: 400px;
            text-align: center;
            color: #333;
            background: #fff;
            width: 270px;
            visibility: visible;
            outline: none;
        }

        .avatar-image {
            width: 260px;
            height: 260px;
            text-align: center;
            border-style: solid;
            border-color: #87CEFA;
        }

        .upload-btn {
            cursor: pointer;
            margin: 40px auto 0;
            width: 182px;
            height: 56px;
            line-height: 56px;
            color: #5b5b5b;
            background-color: #e6e6e6;
            border-radius: 10px;
            border: 1px;
            font-size: 18px;
            padding: 0;
        }

        .upload-btn:focus {
            outline: none;
        }

        .avatar-content:hover .avatar-image {
            border-color: #03a9f4;
            box-shadow: 0 0 15px #03a9f4;
        }

        #fileUpload {
            visibility: hidden;
        }

        .tips {
            color: #999;
            font-size: 14px;
            line-height: 30px;
        }

        .update-container {
            visibility: hidden;
        }

        .div-account-number {
            position: absolute;
            top: 30px;
        }

        .div-password-number {
            position: absolute;
            top: 100px;
        }

        .div-confirm-number {
            position: absolute;
            top: 190px;
        }

        .pw-strength {
            position: absolute;
            left: 373px;
            top: 240px;
        }

        .update-container label {
            position: absolute;
            top: 200px;
            left: 220px;
            width: 200px;
            padding-top: 6px;
            font-size: 16px;
            text-align: right;
            color: #333;
        }

        .account-number,
        .password-number,
        .confirm-number {
            position: absolute;
            top: 185px;
            left: 435px;
            box-sizing: border-box;
            width: 250px;
            height: 34px;
            border: 1.2px solid #aaa;
            background-color: #fff;
            margin: 16px 0;
            overflow: hidden;
            display: flex;
            align-items: center;
            padding: 10px;
        }

        .account-number:focus,
        .password-number:focus,
        .confirm-number:focus {
            border-style: solid;
            border-color: #03a9f4;
            box-shadow: 0 0 15px #03a9f4;
        }

        .span-account-tip,
        .span-password-tip,
        .span-confirm-tip {
            visibility: hidden;
            position: absolute;
            top: 0.5px;
            left: 415px;
        }

        .account-tip,
        .password-tip,
        .confirm-tip {
            position: absolute;
            top: 208px;
            left: 300px;
            width: 18px;
            height: 18px;
            background-image: url("source/警告.png");
            background-size: 100% 100%;
        }

        .account-error,
        .password-error,
        .confirm-error {
            margin-top: 3px;
            margin-left: -20px;
            font-size: 12px;
            color: #aaa;
        }

        .pw-strength {
            top: 340px;
            left: 525px;
        }

        .pw-strength-label {
            display: block;
            float: left;
            text-align: center;
            font-size: 12px;
            height: 20px;
            line-height: 20px;
            width: 82px;
            border-right: 2px solid #fff;
            color: #fff;
            background: #ccc;
        }

        .btn {
            position: absolute;
            left: 635px;
            top: 460px;
            background: #00aeef;
            color: #fff;
            display: inline-block;
            vertical-align: middle;
            padding: 7px 20px 6px;
            font-size: 14px;
            font-weight: 700;
            -webkit-font-smoothing: antialiased;
            line-height: 1.5;
            letter-spacing: .1em;
            text-align: center;
            text-decoration: none;
            border-width: 0 0 1px;
            border-style: solid;
            background-repeat: repeat-x;
            border-radius: 5px;
            user-select: none;
            cursor: pointer;
            width: 250px;
            margin-left: -110px;
        }

        .delete-container {
            position: absolute;
            top: 200px;
            left: 400px;
            visibility: hidden;
        }

        #delete_btn {
            top: 300px;
            left: 400px;
            outline: none;
        } 

        .userexinfo-form {
            padding-left: 550px;
            float: left;
            width: 495px;
            margin-left: 58px;
            background-color: white;
        }

        .userexinfo-form .userexinfo-form-section {
            color: #666;
            position: relative;
            margin: 20px 0;
            padding-left: 90px;
            height: 30px;
            line-height: 30px;
            font-size: 14px;
        }    

        .userexinfo-form p {
            position: absolute;
            top: 0;
            left: 0;
            width: 80px;
            text-align: right;
            color: #333;
            padding: 0;
            margin: 0;
        }

        .userexinfo-form .userexinfo-form-section p {
            font-size: 16px;
        }

        .userexinfo-form .userexinfo-form-section input[type=text] {
            width: 240px;
            font-size: 12px;
            height: 30px;
            padding-left: 10px;
        }

        button,
        input {
            overflow: visible;
        } 

        .date-picker span {
            display: inline-block;
        }
  
        .ui-select {
            display: inline-block;
            background: transparent;
            border: 1px solid #999;
            border-radius: 0;
            font-size: 14px;
            height: 30px;
            position: relative;
        }

        .ui-select select {
            padding: 0 20px 0 10px;
            width: 100%;
            border: none;
            -webkit-appearance: none;
            appearance: none;
        }

        .userexinfo-form .userexinfo-form-section .interest-list {
            font-size: 14px;
            width: 300px;
            padding-left : 55px;
        }

        .userexinfo-form .expand-list {
            height: 110px;
        }

        .userexinfo-form .userexinfo-form-section input[type=checkbox] {
            display: none;
        }

        [type=checkbox],
        [type=radio] {
            box-sizing: border-box;
            padding: 0;
        }

        .userexinfo-form .userexinfo-form-section .ui-checkbox+label {
            padding-left: 20px;
            background: url(source/notcheck.png) 0 no-repeat;
            display: inline-block;
        }

        .userexinfo-form .userexinfo-form-section .ui-checkbox:checked+label {
            padding-left: 20px;
            background: url(source/checked.png) 0 no-repeat;
            display: inline-block;
        }

        .userexinfo-form .userexinfo-form-section .bottom-tips {
            white-space: nowrap;
            color: #ccc;
        }

        .userexinfo-form .userexinfo-form-section input[type=text] {
            width: 240px;
            font-size: 12px;
            height: 30px;
            padding-left: 10px;
        }

        .userexinfo-form .userexinfo-bottom-section {
            color: #666;
            position: relative;
            margin-top: 40px;
            padding-left: 90px;
            line-height: 30px;
            font-size: 14px;
        }

        .userexinfo-form .form-save-btn {
            cursor: pointer;
            border-radius: 5px;
            width: 100px;
            height: 40px;
            color: #fff;
            font-size: 18px;
            line-height: 40px;
            border: none;
            background-color: #00aaee;
            padding: 0;
        }

        .review-icon-image{
            width : 100%;
            height : 100%;
        }
::-webkit-scrollbar {
width:12px;
}
/* 滚动槽 */
::-webkit-scrollbar-track {
-webkit-box-shadow:inset006pxrgba(0,0,0,0.3);
border-radius:10px;
}
/* 滚动条滑块 */
::-webkit-scrollbar-thumb {
border-radius:10px;
background:rgba(0,0,0,0.1);
-webkit-box-shadow:inset006pxrgba(0,0,0,0.5);
}
::-webkit-scrollbar-thumb:window-inactive {
background:rgba(255,0,0,0.4);
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
                    <li id="review"><a href="review.jsp" id="review">热评</a></li>
                    <li id="search"><a href="search.jsp" id="search">搜索</a></li>
                </ul>
            </div>


            <form action="/query" target="_blank" class="search-form">
                <input class="submit" type="submit" value="">
                <input name="kw" class="search" type="search" maxlength="32" placeholder="搜索电影、电视剧、综艺、影人"
                    autocomplete="off">
                <input class="mask" type="text" value="">
            </form>

            <div class="user">
                <div class="img"></div>
                <span class="caret"></span>
                <ul class="menu">
                    <li style="padding-top:60px;"><a href="user.jsp">基本信息</a></li>
                    <li style="padding-top:5px"><a href="exit.jsp">退出登录</a></li>
                    <li style="padding-top:5px;list-style-type: none; margin-left:-40px"><a href="delete_user.jsp">注销账号</a></li>
                </ul>
            </div>

        </div>
    </div>

    <div class="content">

        <div class="user-nav">
            <h3>个人中心</h3>
            <ul>
                <div id="query" onclick="query_click()">
                    <li id="query_li">基本信息</li>
                </div>
                <div id="update" onclick="update_click()">
                    <li id="update_li">修改密码</li>
                </div>
                <div id="delete" onclick="delete_click()">
                    <li id="delete_li">我的评论</li>
                </div>
                <div id="empty">
                    <li id="empty_li"></li>
                </div>
            </ul>
        </div>


        <div class="user-content">
            <div id="user-title" class="user-title">
                基本信息
            </div>
        </div>

        <div class="basic-info">
            <div id="avatar-container" class="avatar-container">
                <div class="avatar-content" tabindex="0">
                    <img id="avatar-image" class="avatar-image" src="source/头像.png">
                    <div class="upload-avatar-image">
                        <input type="button" class="upload-btn" value="更换头像" onclick="file_upload();">
                        <input type="file" id="fileUpload" name="file" onchange="switch_img(this);">
                    </div>
                    <div class="tips">支持JPG,JPEG,PNG格式,且文件需小于1M</div>
                </div>
            </div>

            <form id="userexinfo-form" class="userexinfo-form">
                <div class="userexinfo-form-section">
                <p>昵称：</p>
                <span>
                    <input type="text" name="nickName" id="userexinfo-form-nickname" class="ui-checkbox" placeholder="2-15个字，支持中英文、数字" value="">
                </span>
                </div>
                <div class="userexinfo-form-section">
                    <p>性别：</p>
                    <span>
                    <input type="radio" name="gender" id="userexinfo-form-gender-1" value="1" class="ui-radio radio-first">
                    <label for="userexinfo-form-gender-1">男</label>
                    </span>
                    <span>
                    <input type="radio" name="gender" id="userexinfo-form-gender-2" value="2" class="ui-radio">
                    <label for="userexinfo-form-gender-2">女</label>
                    </span>
                </div>
                <div class="date-picker userexinfo-form-section">
                    <p>生日：</p>
                    <span>
                    <div class="ui-select">
                        <select name="year" class="ui-select">
                        <!-- <option value="">--</option> -->
                        <option value="2019">2019</option>
                        <option value="2018">2018</option>
                        <option value="2017">2017</option>
                        <option value="2016">2016</option>
                        <option value="2015">2015</option>
                        <option value="2014">2014</option>
                        <option value="2013">2013</option>
                        <option value="2012">2012</option>
                        <option value="2011">2011</option>
                        <option value="2010">2010</option>
                        <option value="2009">2009</option>
                        <option value="2008">2008</option>
                        <option value="2007">2007</option>
                        <option value="2006">2006</option>
                        <option value="2005">2005</option>
                        <option value="2004">2004</option>
                        <option value="2003">2003</option>
                        <option value="2002">2002</option>
                        <option value="2001">2001</option>
                        <option value="2000">2000</option>
                        <option value="1999">1999</option>
                        <option value="1998">1998</option>
                        <option value="1997">1997</option>
                        <option value="1996">1996</option>
                        <option value="1995">1995</option>
                        <option value="1994">1994</option>
                        <option value="1993">1993</option>
                        <option value="1992">1992</option>
                        <option value="1991">1991</option>
                        <option value="1990">1990</option>
                        <option value="1989">1989</option>
                        <option value="1988">1988</option>
                        <option value="1987">1987</option>
                        <option value="1986">1986</option>
                        <option value="1985">1985</option>
                        <option value="1984">1984</option>
                        <option value="1983">1983</option>
                        <option value="1982">1982</option>
                        <option value="1981">1981</option>
                        <option value="1980">1980</option>
                        <option value="1979">1979</option>
                        <option value="1978">1978</option>
                        <option value="1977">1977</option>
                        <option value="1976">1976</option>
                        <option value="1975">1975</option>
                        <option value="1974">1974</option>
                        <option value="1973">1973</option>
                        <option value="1972">1972</option>
                        <option value="1971">1971</option>
                        <option value="1970">1970</option>
                        <option value="1969">1969</option>
                        <option value="1968">1968</option>
                        <option value="1967">1967</option>
                        <option value="1966">1966</option>
                        <option value="1965">1965</option>
                        <option value="1964">1964</option>
                        <option value="1963">1963</option>
                        <option value="1962">1962</option>
                        <option value="1961">1961</option>
                        <option value="1960">1960</option>
                        <option value="1959">1959</option>
                        <option value="1958">1958</option>
                        <option value="1957">1957</option>
                        <option value="1956">1956</option>
                        <option value="1955">1955</option>
                        <option value="1954">1954</option>
                        <option value="1953">1953</option>
                        <option value="1952">1952</option>
                        <option value="1951">1951</option>
                        <option value="1950">1950</option>
                        <option value="1949">1949</option>
                        <option value="1948">1948</option>
                        <option value="1947">1947</option>
                        <option value="1946">1946</option>
                        <option value="1945">1945</option>
                        <option value="1944">1944</option>
                        <option value="1943">1943</option>
                        <option value="1942">1942</option>
                        <option value="1941">1941</option>
                        <option value="1940">1940</option>
                        </select>
                    </div>
                    <span class="tip">年</span>
                    </span>
                    <span>
                    <div class="ui-select">
                        <select name="month" class="ui-select">
                        <!-- <option value="">--</option> -->
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select>
                    </div>
                    <span class="tip">月</span>
                    </span>
                    <span>
                    <div class="ui-select">
                        <select name="day" class="ui-select">
                        <!-- <option value="">--</option> -->
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                        </select>
                    </div>
                    <span class="tip">日</span>
                    </span>
                </div>
                <div class="userexinfo-form-section">
                    <p>生活状态：</p>
                    <span>
                    <input type="radio" name="marriage" id="userexinfo-form-merriage-1" value="单身" class="ui-radio radio-first">
                    <label for="userexinfo-form-merriage-1">单身</label>
                    </span>
                    <span>
                    <input type="radio" name="marriage" id="userexinfo-form-merriage-2" value="热恋中" class="ui-radio">
                    <label for="userexinfo-form-merriage-2">热恋中</label>
                    </span>
                    <span>
                    <input type="radio" name="marriage" id="userexinfo-form-merriage-3" value="已婚" class="ui-radio">
                    <label for="userexinfo-form-merriage-3">已婚</label>
                    </span>
                    <span>
                    <input type="radio" name="marriage" id="userexinfo-form-merriage-4" value="为人父母" class="ui-radio">
                    <label for="userexinfo-form-merriage-4">为人父母</label>
                    </span>
                </div>
                <div class="userexinfo-form-section">
                    <p>从事行业：</p>
                    <span>
                    <div class="ui-select">
                        <select id="job" name="job" class="ui-select"><option value="">--</option><option value="信息技术">信息技术</option><option value="金融保险">金融保险</option><option value="商业服务">商业服务</option><option value="建筑地产">建筑地产</option><option value="工程制造">工程制造</option><option value="交通运输">交通运输</option><option value="文化传媒">文化传媒</option><option value="娱乐体育">娱乐体育</option><option value="公共事业">公共事业</option><option value="学生">学生</option><option value="其他">其他</option></select>
                    </div>
                    </span>
                </div>
                <div class="userexinfo-form-section expand-list">
                    <p>兴趣：</p>
                    <div class="interest-list">
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-1" value="美食" class="ui-checkbox">
                        <label for="userexinfo-form-interest-1">美食</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-2" value="动漫" class="ui-checkbox">
                        <label for="userexinfo-form-interest-2">动漫</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-3" value="摄影" class="ui-checkbox">
                        <label for="userexinfo-form-interest-3">摄影</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-4" value="电影" class="ui-checkbox">
                        <label for="userexinfo-form-interest-4">电影</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-5" value="体育" class="ui-checkbox">
                        <label for="userexinfo-form-interest-5">体育</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-6" value="财经" class="ui-checkbox">
                        <label for="userexinfo-form-interest-6">财经</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-7" value="音乐" class="ui-checkbox">
                        <label for="userexinfo-form-interest-7">音乐</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-8" value="游戏" class="ui-checkbox">
                        <label for="userexinfo-form-interest-8">游戏</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-9" value="科技" class="ui-checkbox">
                        <label for="userexinfo-form-interest-9">科技</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-10" value="旅游" class="ui-checkbox">
                        <label for="userexinfo-form-interest-10">旅游</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-11" value="文学" class="ui-checkbox">
                        <label for="userexinfo-form-interest-11">文学</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-12" value="公益" class="ui-checkbox">
                        <label for="userexinfo-form-interest-12">公益</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-13" value="汽车" class="ui-checkbox">
                        <label for="userexinfo-form-interest-13">汽车</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-14" value="时尚" class="ui-checkbox">
                        <label for="userexinfo-form-interest-14">时尚</label>
                    </span>
                    <span>
                        <input type="checkbox" name="interest[]" id="userexinfo-form-interest-15" value="宠物" class="ui-checkbox">
                        <label for="userexinfo-form-interest-15">宠物</label>
                    </span>
                    <span class="bottom-tips">选择你的兴趣使你获得个性化的电影推荐哦</span>
                    </div>
                </div>
                <div class="userexinfo-form-section">
                    <p>个性签名：</p>
                    <span>
                    <input type="text" name="signature" id="userexinfo-form-bio" class="ui-checkbox" placeholder="20个字以内" value="">
                    </span>
                </div>
                <div class="userexinfo-bottom-section clearfix">
                    <input type="button" class="form-save-btn" onclick="update_info();" value="保存">
                </div>
            </form>
        </div>

        <div id="update-container" class="update-container">
            <form action="/register" method="POST">
                <div class="div-account-number">
                    <label>原密码</label> 
                    <input type="password" id="account" name="account" class="account-number" onblur="account_blur()">
                    <span id="span-account-tip" class="span-account-tip"><i class="account-tip"></i><label
                            class="account-error">请输入原密码</label></span>
                </div>

                <div class="div-password-number">
                    <label>新密码</label>
                    <input type="password" id="password" name="password" class="password-number"
                        onblur="password_blur()" oninput="password_input()">
                    <span id="span-password-tip" class="span-password-tip"><i class="password-tip"></i><label
                            class="password-error">请输入新密码</label></span>
                </div>

                <div class="pw-strength" style="left:595px;">
                    <span id="weak" class="pw-strength-label">弱</span>
                    <span id="normal" class="pw-strength-label">中</span>
                    <span id="strong" class="pw-strength-label">强</span>
                </div> 

                <div class="div-confirm-number">
                    <label>确认新密码</label>
                    <input type="password" id="confirm" name="confirm" class="confirm-number" onblur="confirm_blur()">
                    <span id="span-confirm-tip" class="span-confirm-tip"><i class="confirm-tip"></i><label
                            id="confirm-error" class="confirm-error">前后密码不同</label></span>
                </div>

                <div class="div-register">
                    <input type="button" style="left:705px;" class="btn" name="commit" value="修改" onclick="change_password();">
                </div>

            </form>
        </div>
        
        <div id="delete-container" class="delete-container"> 
            <div class="pensonal-review" style="width:880px; overflow:auto; height:540px;">
                <div class="review-list" id="review-list">
                <% for(int i = 0; i < reviews.size(); i++){%>
                    <div class="review-page-user-icon">
                        <img class="review-icon-image" src="<%=reviews.get(i).get("icon")%>">
                    </div>
                    <div class="review-content-body">
                      <div><span class="review-user-name"><%=reviews.get(i).get("user_name")%></span></div>
                      <div>看过<a class="review-movie-name" href="film.jsp?movie_id=<%=reviews.get(i).get("movie_id")%>"><%=reviews.get(i).get("movie_name")%></a><span class="star"></span><span class="movie-rating" style="visibility:hidden;"><%=reviews.get(i).get("rate")%></span></div>
                      <div><span class="review-time"><%=reviews.get(i).get("time")%></span></div>
                      <div class="review-content">
                            <%=reviews.get(i).get("content")%>
                      </div>
                    </div>
                <%}%>
                </div>
            </div>
    
        </div>

        

    </div>
    <script>
        rating_star();
    </script>

</body>

</html>