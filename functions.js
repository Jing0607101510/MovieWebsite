function rating_star(){
    var ratings = document.querySelectorAll("span.movie-rating");
    var stars = document.querySelectorAll("span.star");
    for(var i = 0; i < ratings.length; i++){
        var rating = parseFloat(ratings[i].innerHTML);
        if(rating==0){
            stars[i].classList.add("star0");
        }
        else if(rating<=1){
            stars[i].classList.add("star5");
        }
        else if(rating<=2){
            stars[i].classList.add("star10");
        }
        else if(rating<=3){
            stars[i].classList.add("star15");
        }
        else if(rating<=4){
            stars[i].classList.add("star20");
        }
        else if(rating<=5){
            stars[i].classList.add("star25");
        }
        else if(rating<=6){
            stars[i].classList.add("star30");
        }
        else if(rating<=7){
            stars[i].classList.add("star35");
        }
        else if(rating<=8){
            stars[i].classList.add("star40");
        }
        else if(rating<=9){
            stars[i].classList.add("star45");
        }
        else{
            stars[i].classList.add("star50");
        }
    }
}

function show_shadow(id){
    var input_div = document.getElementById(id);
    input_div.classList.add("shadow");
}

function hide_shadow(id){
    var input_div = document.getElementById(id);
    input_div.classList.remove("shadow");
}

function post_review(movie_id, user_id){
    if(user_id<0){
        alert("请先登录！");
        return;
    }
    var textarea = document.getElementById("textarea-inner");
    var content = textarea.value;
    var score = document.getElementById("rate-score").innerHTML;
    if(content.length==0){
        alert("发表内容不能为空");
    }else{
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function(){
            if(xmlhttp.readyState==4){
                if(xmlhttp.status>=200 && xmlhttp.status<300 || xmlhttp.status>=304){
                    var new_review = xmlhttp.responseText
                    var review_list = document.getElementById("review-list");
                    review_list.innerHTML = new_review + review_list.innerHTML;
                    rating_star();
                }else{
                    alert("抱歉，由于某些原因出错了！");
                }
            }
        };
        var param = "user_id=" + encodeURIComponent(user_id) + "&content=" + encodeURIComponent(content) + "&score=" + encodeURIComponent(score) + "&movie_id=" + encodeURIComponent(movie_id);
        xmlhttp.open("post", "post_review.jsp", true);
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.send(param);
        textarea.value="";
        for(var i = 0; i < 5; i++){
            var img_star = document.getElementById("star"+(i+1)).firstElementChild;
            img_star.setAttribute("src", "source/star_dark.png");
            img_star.setAttribute("hsrc", "source/star_light.png");
        }
    }
}

function update_info(){
    var form = document.getElementById("userexinfo-form");
    var nickname = form.nickName.value;
    var gender = "";
    var birthday = "";
    var status = "";
    var career = "";
    var interest = "";
    var signature="";
    if(nickname=="")
        alert("昵称不能为空");
    else{
        var radios = document.getElementsByName("gender");
        for(var i = 0; i < radios.length; i++){
            if(radios[i].checked){
                gender = radios[i].nextElementSibling.innerHTML;
            }
        }
        var year_select = document.getElementsByName("year")[0];
        var year_index = year_select.selectedIndex;
        var year = year_select.options[year_index].value;
        var month_select = document.getElementsByName("month")[0];
        var month_index = month_select.selectedIndex;
        var month = month_select.options[month_index].value;
        var day_select = document.getElementsByName("day")[0];
        var day_index = day_select.selectedIndex;
        var day = day_select.options[day_index].value;
        birthday = year + "-" + month + "-" + day;
        if(year=="" || month=="" || day=="") birthday = "";
        var status_radios = document.getElementsByName("marriage");
        for(var i = 0; i < status_radios.length; i++){
            if(status_radios[i].checked){
                status = status_radios[i].nextElementSibling.innerHTML;
            }
        }
        var career_select = document.getElementsByName("job")[0];
        var career_index = career_select.selectedIndex;
        career = career_select.options[career_index].value;

        var checks = document.getElementsByName("interest[]");
        var interest_array = new Array();
        for(var i = 0; i < checks.length; i++){
            if(checks[i].checked)
                interest_array.push(checks[i].nextElementSibling.innerHTML);
        }
        interest = interest_array.toString();
        signature = document.getElementById("userexinfo-form-bio").value;
        if(signature.length>20){
            alert("个性签名不能超过20字！");
            return;
        }

        var file = document.getElementById("fileUpload").files[0];

        var formData = new FormData();
        if(file!=null) formData.append("icon", file);
        formData.append("nickname", nickname);
        formData.append("gender", gender);
        formData.append("birthday", birthday);
        formData.append("status", status);
        formData.append("career", career);
        formData.append("interest", interest);
        formData.append("signature", signature);

        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function(){
            if(xmlhttp.readyState==4){
                if(xmlhttp.status>=200 && xmlhttp.status<300 || xmlhttp.status>=304){
                    alert(xmlhttp.responseText);
                }else{
                    alert("抱歉，由于某些原因出错了！");
                }
            }
        };
        xmlhttp.open("post", "update_info.jsp", true);
        xmlhttp.send(formData);
        // var param = "nickname=" + encodeURIComponent(nickname) +
        // "&gender=" + encodeURIComponent(gender) + 
        // "&birthday=" + encodeURIComponent(birthday) + 
        // "&status=" + encodeURIComponent(status) + 
        // "&career=" + encodeURIComponent(career) + 
        // "&interest=" + encodeURIComponent(interest) +
        // "&signature=" + encodeURIComponent(signature) + 
        // "&icon=" + encodeURIComponent(file);
        
        // xmlhttp.setRequestHeader("Content-type","multipart/form-data");
        
    }
}

function light_star(star_no){
    for(var i = 0; i < 5; i++){
        var img_star = document.getElementById("star"+(i+1)).firstElementChild;
        img_star.setAttribute("src", "source/star_dark.png");
        img_star.setAttribute("hsrc", "source/star_light.png");
    }
    for(var i = 0; i < star_no; i++){
        var img_star = document.getElementById("star"+(i+1)).firstElementChild;
        img_star.setAttribute("src", "source/star_light.png");
    }
    var score = document.getElementById("rate-score");
    score.innerHTML = star_no * 2;
}

function star1_dark(){
    var img_star = document.getElementById("star1").firstElementChild;
    img_star.setAttribute("src", "source/star_dark.png");
    var score = document.getElementById("rate-score");
    score.innerHTML = 0;
}

//头像按钮点击
function file_upload(){
    var upload_bt = document.getElementById("fileUpload");
    upload_bt.click();
}

//选中文件监听
function switch_img(fileDom){
        //判断是否支持FileReader
        if(window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if(!imageType.test(file.type)) {
            alert("请选择图片！");
            return;
        }
        //读取完成
        reader.onload = function(e) {
            //获取图片dom
            var img = document.getElementById("avatar-image");
            //图片路径设置为读取的图片
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
}

function test(){
    var file = document.getElementById("file").files[0];
    if(file==null) alert("文件为空");
    var formData = new FormData();
    formData.append("icon", file);
    formData.append("other", "中文");

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function(){
        if(xmlhttp.readyState==4){
            if(xmlhttp.status>=200 && xmlhttp.status<300 || xmlhttp.status>=304){
                document.getElementById("show").innerHTML = xmlhttp.responseText;
            }else{
                alert("抱歉，由于某些原因出错了！");
            }
        }
    };
    // var param = "other=10"+"&icon=" + encodeURIComponent(file);
    xmlhttp.open("post", "test3.jsp", true);
    // xmlhttp.setRequestHeader("Content-type","multipart/form-data");
    xmlhttp.send(formData);
}

function change_password(){
    var cur_pd = document.getElementById("account").value;
    var new_pd = document.getElementById("password").value;
    var repeat_pd = document.getElementById("confirm").value;
    if(new_pd!=repeat_pd){
        return;
    }
    
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function(){
        if(xmlhttp.readyState==4){
            if(xmlhttp.status>=200 && xmlhttp.status<300 || xmlhttp.status>=304){
                if(xmlhttp.responseText.indexOf("success")!=-1)
                    alert("修改成功！");
                else
                    alert("修改失败，原密码不正确！");
            }else{
                alert("抱歉，由于某些原因出错了！");
            }
        }
    };
    var param = "password=" + encodeURIComponent(cur_pd) + "&new_password=" + encodeURIComponent(new_pd);
    xmlhttp.open("post", "change_password.jsp", true);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send(param);
}