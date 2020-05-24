<%@ page import="com.herokuapp.communion.webapp.Database" %>
<%@ page import="com.herokuapp.communion.models.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Communion</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/stylish-portfolio.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
          type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
            rel="stylesheet" type="text/css">

    <%
        int forumId = 0;
        Forum forum = new Forum();
        int uid = 3;
        User user = new User();
        Cookie[] cookies = request.getCookies();
        try {
            for (Cookie cookie: cookies){
                if (cookie.getName().equals("uid"))
                    uid = Integer.valueOf(cookie.getValue());
            }
            user = Database.getInstance().getUser(uid);
            forumId = Integer.valueOf(request.getParameter("forumId"));
            forum = Database.getInstance().getForum(forumId);
        }catch (Exception e){
            try{
                user = Database.getInstance().getUser(3);
            }catch (Exception ex) {
                response.sendRedirect("Error.jsp?message=e:" + e.getMessage().replaceAll(" ", "_") + "_" + ex.getMessage().replaceAll(" ", "_"));
                //response.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
            }
        }

        Section section;
        try{
             section = Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId")));
        }
        catch (Exception e){
            response.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
        }

        Topic topic;
        int topicId = Integer.valueOf(request.getParameter("topicId"));
        ArrayList<Post> posts = new ArrayList<Post>();
        try{
            topic = Database.getInstance().getTopic(Integer.valueOf(request.getParameter("topicId")));
            posts = Database.getInstance().getTopicPosts(topic.getTopicid());
        }
        catch (Exception e){
            response.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
        }
    %>
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

<!-- CONTENT: -->

<nav class="navbar navbar-inverse" style="padding-right: 100px;">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><%= forum.getTitle() %></a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="Forum.jsp?forumId=<%= forumId %>">Список разделов</a></li>
            <% if (forum.getAbout() != null) { %><li><a onclick="about()">О форуме</a></li><% } %>
            <li><a onclick="owner()">Владелец</a></li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <% if ((forum.getIsPublic() != 1)
                    && ((Database.getInstance().userRole(forumId, uid) < 1)
                    || (Database.getInstance().userRole(forumId, uid) > 3))
                    && forum.getForumid() != 4
                    && user.getUserid() != 3
                    && user.getUserid() != forum.getUserid()) { %>
            <li><a href="#"><span class="glyphicon glyphicon-user"></span>
                Войти</a></li>
            <% } %>
            <li><a href="Main.jsp"><span class="glyphicon glyphicon-log-in"></span>
                Выйти</a></li>
        </ul>
    </div>
</nav>

<% if (request.getParameter("sectionId") != null) { %>
<ul class="list-group" id="postslist" name="postslist">
    <% for (Post post : posts) { %>
    <li class="list-group-item">
        <h4><%= post.getPostName()%></h4>
        <hr class="small center-block"/>
        <%= post.getPost().replaceAll("\n","<br/>") %>
        <span class="badge"><%= post.getPostDate()%></span>

    </li>
    <% } %>
    <% if (user.getUserid() != 3){ %>
        <li class="list-group-item">
            <form action="addpost" method="post">
                <input type="hidden" id="forumId" name="forumId" value="<%= forumId %>"/>
                <input type="hidden" id="topicId" name="topicId" value="<%= topicId %>"/>
                <input type="hidden" id="uid" name="uid" value="<%=uid%>">
                <input type="text" id="postName" name="postName"/>
                <hr class="center-block small"/>
                <input type="text" name="post" id="post">
                <button class="btn btn-default" type="submit">Отправить</button>
            </form>
        </li>
    <% } %>
</ul>
<% } %>

<a id="to-top" href="#top" class="btn btn-dark btn-lg"><i
        class="fa fa-chevron-up fa-fw fa-1x"></i></a>

<!-- CONTENT END -->
<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

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
