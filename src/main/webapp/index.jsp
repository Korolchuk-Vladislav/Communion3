<%@ page import="com.herokuapp.communion.models.Forum" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.herokuapp.communion.webapp.Database" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ru">

<head>

    <%
        ArrayList<Forum> topForums = new ArrayList<Forum>();
        int uid = 3;
        Cookie[] cookies = request.getCookies();
        try {
            if (request.getParameter("quit") == null) {
                for (Cookie cookie: cookies){
                    if (cookie.getName().equals("uid"))
                        uid = Integer.valueOf(cookie.getValue());
                }
            }
            if (uid == 3) {
                Cookie cookie = new Cookie("uid",String.valueOf(uid));
                cookie.setMaxAge(365 * 24 * 60 * 60);
                response.addCookie(cookie);
            } else{
                try {
                    if (Database.getInstance().getUser(uid) != null) {
                        response.sendRedirect("Main.jsp");
                    }
                }
                catch (Exception ex){}
            }
            topForums = (ArrayList<Forum>) Database.getInstance().topForums(5);
        } catch (Exception e) {
            response.sendRedirect("/Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
        }
    %>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Communion</title>
    <link rel="icon" href="communion_icon.png">

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/stylish-portfolio.css" rel="stylesheet">
    <link href="css/half-slider.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
          type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
            rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Put this script tag to the <head> of your page -->
    <script type="text/javascript" src="//vk.com/js/api/openapi.js?146"></script>

    <script type="text/javascript">
        VK.init({apiId: 7481249});
    </script>

</head>

<body>

<!-- Navigation -->
<a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i
        class="fa fa-bars"></i></a>
<nav id="sidebar-wrapper">
    <ul class="sidebar-nav">
        <a id="menu-close" href="#"
           class="btn btn-light btn-lg pull-right toggle"><i
                class="fa fa-times"></i></a>
        <li class="sidebar-brand"><a href="#top" onclick=$("#menu-close").click();>Communion</a>
        </li>
        <li><a href="#signin" onclick=$("#menu-close").click();>Авторизация</a></li>
        <li><a href="#topforums" onclick=$("#menu-close").click();>Лучшие
            форумы</a></li>
        <li><a href="#mobapp" onclick=$("#menu-close").click();>Мобильное
            приложение</a></li>
        <li><a href="#contact" onclick=$("#menu-close").click();>Контакты</a>
        </li>
    </ul>
</nav>

<!-- Header -->
<header id="top" class="header">
    <div class="text-vertical-center">
        <h1>Communion</h1>
        <h3>Это приложение позволит вам с лёгкостью создать свой
            собственный форум</h3>
        <br> <a href="#signin" class="btn btn-dark btn-lg">Продолжить</a>
    </div>
</header>

<!-- Авторизация -->
<section id="signin" class="about">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2>Создавай форумы с лёкостью!</h2>
                <p class="lead">А также, посещай и общайся на многих других
                    форумах.</p>
                <div id="vk_auth" class="btn btn-dark btn-sm"></div>
                <script type="text/javascript">
                    VK.Widgets.Auth("vk_auth", {authUrl: '/Login'});
                </script>
                <hr class="small center-block"/>
                <a class="btn btn-default" href="Main.jsp">Войти</a>
            </div>
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
</section>

<!-- TopForums -->
<aside id="topforums" class="callout">
    <!-- Half Page Image Background Carousel Header -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <%
                for (int i = 0; i < topForums.size(); i++) {
            %>
            <li data-target="#myCarousel" data-slide-to="<%=i%>" <%= (i == 0) ? " class=\"active\"" : ""%>></li>
            <%
                }
            %>
        </ol>

        <!-- Wrapper for Slides -->
        <div class="carousel-inner">
            <%
                for (int i = 0; i < topForums.size(); i++) {
            %>
            <div class="item<%=(i == 0) ? " active" : ""%>">
                <!-- Set the first background image using inline CSS below. -->
                <div class="fill"
                     style="background-image:url('<%=topForums.get(i).getImg()%>');"></div>
                <div class="carousel-caption">
                    <h2><%=topForums.get(i).getTitle()%></h2>
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
</aside>

<!-- Mobile Apps -->
<aside id="mobapp" class="call-to-action bg-primary">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <a href="img/android.png"><img src="img/android.png"
                                               style="display: block; margin: auto; height: auto; max-height: 100%; width: auto; max-width: 100%;"></a>
            </div>
        </div>
    </div>
</aside>

<!-- Contact -->
<section id="contact"></section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1 text-center">
                <h4>
                    <strong>Korolchuk Vladislav</strong>
                </h4>
                <p>
                    Minsk <br>Belarus
                </p>
                <ul class="list-unstyled">
                    <li><i class="fa fa-phone fa-fw"></i> +375 (29) 548 93 71</li>
                    <li><i class="fa fa-envelope-o fa-fw"></i> <a
                            href="mailto:alexander.butgusaim@gmail.com">korolchuk.vladislav@gmail.com</a>
                    </li>
                </ul>
                <br>
                <hr class="small">
                <p class="text-muted">&copy; Communion 2020</p>
            </div>
        </div>
    </div>
    <a id="to-top" href="#top" class="btn btn-dark btn-lg"><i
            class="fa fa-chevron-up fa-fw fa-1x"></i></a>
</footer>

<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

<script>
    $('.carousel').carousel({
        interval: 2500 //changes the speed
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
