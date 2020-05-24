<%@page import="com.herokuapp.communion.models.Forum"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.herokuapp.communion.models.User"%>
<%@page import="com.herokuapp.communion.webapp.Database"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%
        ArrayList<Forum> topForums = new ArrayList<Forum>();
        ArrayList<Forum> forums = new ArrayList<Forum>();
        int uid = 3;
        User user = new User();
        Cookie[] cookies = request.getCookies();
        try {
            for (Cookie cookie: cookies){
                if (cookie.getName().equals("uid"))
                    uid = Integer.valueOf(cookie.getValue());
            }
            user = Database.getInstance().getUser(uid);
        } catch (Exception e){
            try{
                user = Database.getInstance().getUser(3);
            }catch (Exception ex) {
                response.sendRedirect("Error.jsp?message=e:" + e.getMessage().replaceAll(" ", "_") + "_" + ex.getMessage().replaceAll(" ", "_"));
                //response.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
            }
        }
        try{
            topForums = (ArrayList<Forum>) Database.getInstance().topForums(5);
            forums = (ArrayList<Forum>) Database.getInstance().userForums(uid);
        }
        catch (Exception e){};
    %>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/stylish-portfolio.css" rel="stylesheet">
    <link href="css/heroic-features.css" rel="stylesheet">
    <link href="css/half-slider.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
          type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
            rel="stylesheet" type="text/css">

    <title>Communion | <%=user.getFirst_name()%></title>
    <link rel="icon" href="communion_icon.png">
</head>
<body>
<% if (user.getUserid() != 3){ %>
<!-- Navigation -->
<a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i
        class="fa fa-bars"></i></a>
<nav id="sidebar-wrapper">
    <ul class="sidebar-nav">
        <a id="menu-close" href="#"
           class="btn btn-light btn-lg pull-right toggle"><i
                class="fa fa-times"></i></a>
        <li class="sidebar-brand"><a onclick=$("#menu-close").click();><%=user.getFirst_name()%></a></li>
        <li><a href="Chat.jsp" onclick=$("#menu-close").click();>Сообщения</a>
        </li>
        <%--<hr class="small"/>--%>
        <li><a href="Profile.jsp" onclick=$("#menu-close").click();>Профиль</a>
        </li>
        <li><a href="index.jsp?quit=ok" onclick=$("#menu-close").click();>Выйти</a>
        </li>
    </ul>
</nav>
<% } %>

<!-- Half Page Image Background Carousel Header -->
<div style="height: 50%; background-image: 'img/sliderbg.jpg';" class="img-responsive">
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <%
                for (int i = 0; i < topForums.size(); i++) {
            %>
            <li data-target="#myCarousel" data-slide-to="<%=i%>"
                    <%=(i == 0) ? " class=\"active\"" : ""%>></li>
            <%
                }
            %>
        </ol>

        <!-- Wrapper for Slides -->
        <div class="carousel-inner">
            <%
                if (topForums.isEmpty()) {
            %>
            <div class="item active">
                <!-- Set the first background image using inline CSS below. -->
                <div class="fill" style="background-image: url('img/sliderbg.jpg');"></div>
            </div>
            <%
                }
            %>
            <%
                for (int i = 0; i < topForums.size(); i++) {
            %>
            <div class="item<%=(i == 0) ? " active" : ""%>">
                <!-- Set the first background image using inline CSS below. -->
                <div class="fill"
                     style="background-image:url('<%=topForums.get(i).getImg()%>');"></div>
                <div class="carousel-caption">
                    <a class="btn btn-dark" href="Forum.jsp?forumId=<%= topForums.get(i).getForumid() %>&userId=<%= uid %>"><h2><%=topForums.get(i).getTitle()%></h2></a>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a> <a class="right carousel-control" href="#myCarousel"
                data-slide="next"> <span class="icon-next"></span>
    </a>

    </header>
</div>
<hr class="large" />
<style>
    .input[type=text] {
        width: 130px;
        -webkit-transition: width 0.4s ease-in-out;
        transition: width 0.4s ease-in-out;
    }

    /* When the input field gets focus, change its width to 100% */
    input[type=text]:focus {
        width: 100%;
    }
</style>
<input type="hidden" id="hidden_uid" value="<%= uid %>" />
<script type="text/javascript">

    var all = false;

    function search() {
        if (all) {
            var searchString = document.getElementById("sss").value;
            console.log('req to https://communionweb.herokuapp.com/search?type=forums&key=' + searchString);
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("forumslist").innerHTML = null;
                    var jsonData = JSON.parse(this.responseText);
                    for (var i = 0; i < jsonData.length; i++) {
                        var forum = jsonData[i];
                        console.log(forum.title);
                        var a = document.createElement("a");
                        a.setAttribute("href", "Forum.jsp?forumId=" + forum.forumid);
                        a.setAttribute("class", "list-group-item");
                        var img = document.createElement("img");
                        var title = document.createElement("strong");
                        img.setAttribute("src", forum.img);
                        img.setAttribute("class", "img-circle");
                        title.setAttribute("class", "text-uppercase");
                        title.innerHTML = forum.title;
                        a.appendChild(img);
                        a.appendChild(title);
                        document.getElementById("forumslist").appendChild(a);
                    }
                }
            };
            xhttp.open("GET", "https://communionweb.herokuapp.com/search?type=forums&key=" + searchString, true);
            xhttp.send();
        }
        else{
            var forumName = document.getElementById("sss").value;
            var userId = <%= uid %>;
            console.log('req to https://communionweb.herokuapp.com/search?type=userforums&key=' + forumName + '&uid=' + userId);
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("forumslist").innerHTML = null;
                    var jsonData = JSON.parse(this.responseText);
                    for (var i = 0; i < jsonData.length; i++) {
                        var forum = jsonData[i];
                        console.log(forum.title);
                        var a = document.createElement("a");
                        a.setAttribute("href", "Forum.jsp?forumId=" + forum.forumid);
                        a.setAttribute("class", "list-group-item");
                        var img = document.createElement("img");
                        var title = document.createElement("strong");
                        img.setAttribute("src", forum.img);
                        img.setAttribute("class", "img-circle");
                        title.setAttribute("class", "text-uppercase");
                        title.innerHTML = forum.title;
                        a.appendChild(img);
                        a.appendChild(title);
                        document.getElementById("forumslist").appendChild(a);
                    }
                }
            };
            xhttp.open("GET", "https://communionweb.herokuapp.com/search?type=userforums&key=" + forumName + "&uid=" + userId, true);
            xhttp.send();
        }
    }

    function searchgo() {
        if (all) {
            var searchString = document.getElementById("sss").value;
            console.log('req to https://communionweb.herokuapp.com/search?type=forums&key=' + searchString);
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("forumslist").innerHTML = null;
                    var jsonData = JSON.parse(this.responseText);
                    for (var i = 0; i < jsonData.length; i++) {
                        var forum = jsonData[i];
                        console.log(forum.title);
                        var a = document.createElement("a");
                        a.setAttribute("href", "Forum.jsp?forumId=" + forum.forumid);
                        a.setAttribute("class", "list-group-item");
                        var img = document.createElement("img");
                        var title = document.createElement("strong");
                        img.setAttribute("src", forum.img);
                        img.setAttribute("class", "img-circle");
                        title.setAttribute("class", "text-uppercase");
                        title.innerHTML = forum.title;
                        a.appendChild(img);
                        a.appendChild(title);
                        document.getElementById("forumslist").appendChild(a);
                    }
                    window.scrollTo(0,window.innerHeight/2);
                }
            };
            xhttp.open("GET", "https://communionweb.herokuapp.com/search?type=forums&key=" + searchString, true);
            xhttp.send();
        }
        else {
            var forumName = document.getElementById("sss").value;
            var userId = <%= uid %>;
            console.log('req to https://communionweb.herokuapp.com/search?type=userforums&key=' + forumName + '&uid=' + userId);
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("forumslist").innerHTML = null;
                    var jsonData = JSON.parse(this.responseText);
                    for (var i = 0; i < jsonData.length; i++) {
                        var forum = jsonData[i];
                        console.log(forum.title);
                        var a = document.createElement("a");
                        a.setAttribute("href", "Forum.jsp?forumId=" + forum.forumid);
                        a.setAttribute("class", "list-group-item");
                        var img = document.createElement("img");
                        var title = document.createElement("strong");
                        img.setAttribute("src", forum.img);
                        img.setAttribute("class", "img-circle");
                        title.setAttribute("class", "text-uppercase");
                        title.innerHTML = forum.title;
                        a.appendChild(img);
                        a.appendChild(title);
                        document.getElementById("forumslist").appendChild(a);
                    }
                    window.scrollTo(0,window.innerHeight/2);
                }
            };
            xhttp.open("GET", "https://communionweb.herokuapp.com/search?type=userforums&key=" + forumName + "&uid=" + userId, true);
            xhttp.send();
        }
    }

    function set(status) {
        all = status;
        searchgo();
    }
</script>
<div class="center-block" style="max-width: 250px;">
    <div class="input-group" style="max-width: 300px;">
        <input type="text" class="form-control" style="max-width: 300px; text-align: center;"  id="sss" onkeyup="search();" placeholder="Search for...">
        <span class="input-group-btn">
        <button class="btn btn-secondary" style="max-width: 300px; text-align: center;"  type="button" onclick="searchgo();">Go!</button>
      </span>
    </div>
</div>
<br/>
<hr class="center-block small"/>
<a class="center-block btn btn-default" style="max-width: 300px;" href="createforum.jsp">Создать</a>
<hr class="center-block small"/>
<div class="list-group center-block">
    <a href="#" class="list-group-item list-group-item-action small" onclick="set(false);">мои</a>
    <a href="#" class="list-group-item list-group-item-action small" onclick="set(true);">все</a>
</div>
</div>
<hr/>
<h2 class="center-block">Форумы:</h2>
<hr class="center-block small" />
<ul class="list-group" id="forumslist">
    <%
        if (forums.size() > 0) {
    %>
    <%
        for (int i = 0; i < forums.size(); i++) {
    %>
    <a class="list-group-item" href="Forum.jsp?forumId=<%= forums.get(i).getForumid() %>">
        <img class="img-circle" src="<%= forums.get(i).getImg() %>" />
        <strong class="text-uppercase"><%= forums.get(i).getTitle() %></strong>
        <span class="badge">
            <%= Database.getInstance().forumUsers(forums.get(i).getForumid()).size() %>
		</span></a>
    <%
        }
    %>
    <%
        }
    %>
</ul>
<style>
    #forumslist{
    .list-group;
    }
    #forumslist>a{
    .list-group-item;
    }
    #forumslist>a>img{
    .img-circle;
        width: 150px;
        height: 75px;
    }
    #forumslist>a>strong{
        padding-left: 25px;
    .text-uppercase;
    }
    #forumslist>a>span {
    .badge;
    }
</style>

<a id="to-top" href="#top" class="btn btn-dark btn-lg"><i
        class="fa fa-chevron-up fa-fw fa-1x"></i></a>

<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

<!-- Script to Activate the Carousel -->
<script>
    $('.carousel').carousel({
        interval: 5000 //changes the speed
    })
</script>

<!-- Custom Theme JavaScript -->
<script>
    // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    // Scrolls to the selected menu item on the page
    $(function() {
        $('a[href*=#]:not([href=#],[data-toggle],[data-target],[data-slide])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });
    });
    //#to-top button appears after scrolling
    var fixed = false;
    $(document).scroll(function() {
        if ($(this).scrollTop() > 250) {
            if (!fixed) {
                fixed = true;
                // $('#to-top').css({position:'fixed', display:'block'});
                $('#to-top').show("slow", function() {
                    $('#to-top').css({
                        position: 'fixed',
                        display: 'block'
                    });
                });
            }
        } else {
            if (fixed) {
                fixed = false;
                $('#to-top').hide("slow", function() {
                    $('#to-top').css({
                        display: 'none'
                    });
                });
            }
        }
    });
</script>
</body>
</html>