<%@page import="com.herokuapp.communion.webapp.Database"%>
<%@page import="com.herokuapp.communion.models.User"%>
<%@page import="com.herokuapp.communion.models.Forum"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.herokuapp.communion.models.Section" %>
<%@ page import="com.herokuapp.communion.models.Topic" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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

        ArrayList<Section> sections = new ArrayList<>();
        ArrayList<Topic> topics = new ArrayList<>();
        try {
            if (request.getParameter("sectionId") != null){
                sections = Database.getInstance().getSubsections(forumId, Integer.valueOf(request.getParameter("sectionId")));
                topics = Database.getInstance().getSecitonTopics(Integer.valueOf(request.getParameter("sectionId")));
            } else {
                sections = Database.getInstance().getForumSections(forumId);
            }
        }
        catch(Exception e){
            response.sendRedirect("/Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
        }
    %>
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
    <title>Communion | <%= forum.getTitle() %></title>
</head>
<body>
<a id="top"/>
<% if (user.getUserid() != 3){ %>
<!-- Navigation -->
<a id="menu-toggle" href="#top" class="btn btn-dark btn-lg toggle"><i
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
            <img src="<%=forum.getImg()%>" class="img-rounded" style="height: 55px; width: auto;">
            <a class="navbar-brand" href="#"><%= forum.getTitle() %></a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="Forum.jsp?forumId=<%= forumId %>">Список разделов</a></li>
            <li><a onclick="about()">О форуме</a></li>
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
            <li><a href="Main.jsp" onclick=$("#menu-close").click();>Выйти</a>
        </ul>
    </div>
</nav>

<div id="dAbout" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">О форуме.</h4>
            </div>
            <div class="modal-body">
                <p><%= (forum.getAbout() != null) ? forum.getAbout().replaceAll("\n","<br/>") : ""%></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<div id="dOwner" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Владелец.</h4>
            </div>
            <div class="modal-body">
                <p><%= Database.getInstance().getUser(forum.getUserid()).aboutOwner().replaceAll("\n","<br/>") %></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<script>
    function owner() {
        $("#dOwner").modal("show")
    }
    function about() {
        $("#dAbout").modal("show")
    }
</script>

<% if (request.getParameter("sectionId") == null) { %>
<h2 class="center-block">Разделы:</h2>
<% } else {%>
<ul class="pager">
    <li class="previous"><a href="Forum.jsp?forumId=<%= forumId %><%= (Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId"))) != null
    && Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId"))).getParent() > 0)
    ? "&sectionId=" + Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId"))).getParent()
     : "" %>"><span aria-hidden="true">&larr;</span>
        <%= (Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId"))).getParent() > 0) ?
                Database.getInstance().getSection(Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId"))).getParent()).getName()
        : Database.getInstance().getForum(Database.getInstance().getSection(Integer.valueOf(request.getParameter("sectionId"))).getForumid()).getTitle()%></a></li>
</ul>
<hr class="small center-block"/>
<h2 class="center-block">Подразделы:</h2>
<% } %>
<hr class="small center-block"/>
<ul class="list-group" id="sectionslist">
    <%
        for (int i = 0; i < sections.size(); i++) {
    %>
    <a class="list-group-item" href="Forum.jsp?forumId=<%= sections.get(i).getForumid() %>&sectionId=<%= sections.get(i).getSectionid() %>">
        <strong><%= sections.get(i).getName() %></strong>
        <span class="badge">
            <%= Database.getInstance().sectionTopicsCount(sections.get(i).getSectionid()) %>
		</span></a>
    <%
        }
    %>
    <a class="list-group-item" href="createsection.jsp?forumId=<%=forumId%><%=
    (request.getParameter("sectionId") != null)? "&sectionId=" + request.getParameter("sectionId") : ""%>">
        <strong>Создать раздел</strong></a>
</ul>
<% if (request.getParameter("sectionId") != null) { %>
<hr/>
<h2 class="center-block">Темы:</h2>
<hr class="center-block small"/>
<ul class="list-group" id="topicslist">
    <%
        for (int i = 0; i < topics.size(); i++) {
    %>
    <a class="list-group-item"
       href="<%= "Theme.jsp?forumId=" + forum.getForumid() + "&sectionId=" + request.getParameter("sectionId")
            + "&topicId=" + topics.get(i).getTopicid()%>">
        <strong><%= topics.get(i).getTitle() %></strong>
        <span class="badge">
            <%= Database.getInstance().topicUsersCount(topics.get(i).getTopicid()) %>
		</span></a>
    <%
        }
    %>
    <a class="list-group-item" href="createtheme.jsp?forumId=<%=forumId%><%=
    (request.getParameter("sectionId") != null)? "&sectionId=" + request.getParameter("sectionId") : ""%>">
        <strong>Создать тему</strong></a>
</ul>
<% } %>
<!-- CONTENT END -->

<a id="to-top" href="#top" class="btn btn-dark btn-lg"><i
        class="fa fa-chevron-up fa-fw fa-1x"></i></a>

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