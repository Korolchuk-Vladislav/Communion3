<%@page import="com.herokuapp.communion.models.User"%>
<%@page import="com.herokuapp.communion.webapp.Database"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ru">
<html>
<%
    int userId = 0;
    for (Cookie cookie: request.getCookies()) {
        if (cookie.getName().equals("uid"))
            userId = Integer.valueOf(cookie.getValue());
    }
    if (userId == 0){
        response.sendRedirect("Error.jsp?message=no userId(uid) cookie taken," +
                " please go to start page and try agean.");
    }
    User user = new User();
    try{
        user = Database.getInstance().getUser(userId);
    }
    catch (Exception e){
        try{
            user = Database.getInstance().getUser(3);
        }catch (Exception ex) {
            response.sendRedirect("Error.jsp?message=userid:" + userId);
            //response.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
        }
    }
%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta http-equiv="Content-Type" content="text/html">
    <title>Communion | Создание Раздела</title>
    <link rel="icon" href="communion_icon.png">

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
    <link rel="icon" href="communion_icon.png">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body style="text-align: center;">
<div
        style="width: 50%; min-width: 250px; margin: 0 auto; margin-top: 0px; margin-bottom: 0px;">
    <div class="panel panel-primary">
        <div class="panel-heading">Создание Раздела</div>
        <div class="panel-body">
            <form class="form-horizontal" action='addsection' method="POST"
                  id="mForm">
                <fieldset>
                    <input type="hidden" id="uid" name="uid" value="<%= userId %>"/>
                    <input type="hidden" id="forumId" name="forumId" value="<%= request.getParameter("forumId") %>"/>
                    <% if (request.getParameter("sectionId") != null){ %>
                    <input type="hidden" id="sectionId" name="sectionId" value="<%= request.getParameter("sectionId") %>"/>
                    <% } %>
                    <div class="control-group">
                        <label><%=user.getFirst_name()%> <%=user.getLast_name()%></label>
                    </div>
                    <hr class="large" />
                    <div class="control-group">
                        <label class="control-label" for="name">Название</label>
                        <div class="controls">
                            <input type="text" id="name" name="name" placeholder=""
                                   class="form-control">
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- continue -->
                        <div class="controls">
                            <button class="btn btn-success" type="submit">Продолжить</button>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="js/jquery.js"></script>

<script type="text/javascript">
    function submitClick(){
        if(document.getElementById('age').value == ""){
            document.getElementById('mForm').submit();
            return;
        }
        if (/^\d+$/.test(document.getElementById('age').value) == true){
            if (document.getElementById('age').value > 0 && document.getElementById('age').value < 100){
                document.getElementById('mForm').submit();
            }
            else{
                $("#invalid_number").modal("show")
            }
        }
        else{
            $("#not_a_number").modal("show")
        }
    }
</script>

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
        $(
            'a[href*=#]:not([href=#],[data-toggle],[data-target],[data-slide])')
            .click(
                function() {
                    if (location.pathname.replace(/^\//, '') == this.pathname
                            .replace(/^\//, '')
                        || location.hostname == this.hostname) {
                        var target = $(this.hash);
                        target = target.length ? target
                            : $('[name=' + this.hash.slice(1)
                                + ']');
                        if (target.length) {
                            $('html,body').animate({
                                scrollTop : target.offset().top
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
                        position : 'fixed',
                        display : 'block'
                    });
                });
            }
        } else {
            if (fixed) {
                fixed = false;
                $('#to-top').hide("slow", function() {
                    $('#to-top').css({
                        display : 'none'
                    });
                });
            }
        }
    });
</script>
</body>
</html>