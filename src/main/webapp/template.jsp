<%@ page import="com.herokuapp.communion.models.User" %>
<%@ page import="com.herokuapp.communion.webapp.Database" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Communion</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
          type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
            rel="stylesheet" type="text/css">

    <%
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
    %>
    <link rel="icon" href="communion_icon.png">
</head>
<body>
<% if (user.getUserid() == 3){ %>
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
