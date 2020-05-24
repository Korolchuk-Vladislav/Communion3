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
    <link rel="icon" href="communion_icon.png">

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
        } catch (Exception e) {
            response.sendRedirect("/Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
        }
    %>

</head>
<body>
<% if (user.getUserid() == 3){ %>
<!-- Navigation -->
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

<div
        style="width: 50%; min-width: 250px; margin: 0 auto; margin-top: 0px; margin-bottom: 0px;">
    <div class="panel panel-primary">
        <div class="panel-heading">Профиль</div>
        <div class="panel-body">
            <form class="form-horizontal" action='Registrate' method="POST"
                  id="mForm">
                <fieldset>
                    <div class="control-group">
                        <!-- first_name -->
                        <label><%=user.getFirst_name()%> <%=user.getLast_name()%></label>
                    </div>
                    <hr class="large" />
                    <div class="control-group">
                        <!-- age-->
                        <label class="control-label" for="age">Возраст</label>
                        <div class="controls">
                            <input type="text" id="age" name="age" placeholder=""
                                   class="form-control" <%= (user.getAge() > 0) ? "value=\""+ user.getAge() + "\"" : ""%>>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- country -->
                        <label class="control-label" for="country">Страна</label>
                        <div class="controls">
                            <input type="text" id="country" name="country" placeholder=""
                                   class="form-control" <%= (user.getCountry() != null) ? "value=\""+ user.getCountry() + "\"" : ""%>>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- region -->
                        <label class="control-label" for="region">Область</label>
                        <div class="controls">
                            <input type="text" id="region" name="region" placeholder=""
                                   class="form-control" <%= (user.getRegion() != null) ? "value=\""+ user.getRegion() + "\"" : ""%>>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- city -->
                        <label class="control-label" for="city">Город</label>
                        <div class="controls">
                            <input type="text" id="city" name="city" placeholder=""
                                   class="form-control" <%= (user.getCity() != null) ? "value=\""+ user.getCity() + "\"" : ""%>>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- about -->
                        <label class="control-label" for="about">О себе</label>
                        <div class="controls">
                            <input type="text" id="about" name="about" class="form-control" row="10"
                                    <%= (user.getAbout() != null) ? "value=\""+ user.getAbout() + "\"" : ""%>></input>
                        </div>
                    </div>
                    <hr class="large" />
                </fieldset>
            </form>
            <div class="control-group">
                <!-- continue -->
                <div class="controls">
                    <button class="btn btn-success" onClick='submitClick()'>Сохранить</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="invalid_number" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Ошибка.</h4>
            </div>
            <div class="modal-body">
                <p>Значение возраста должно быть между 0 и 100.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<div id="not_a_number" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Ошибка.</h4>
            </div>
            <div class="modal-body">
                <p>Возраст должен содержать числовое значение.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>


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
