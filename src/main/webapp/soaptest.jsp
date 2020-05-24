<%--
  Created by IntelliJ IDEA.
  User: Александр
  Date: 18.05.2017
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Communion | SOAP Test Page</title>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <form>
        <script>
            function submit() {
                var body = document.getElementById("inputbody").value;
                console.log("submit");
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("reqres").innerHTML = new XMLSerializer().serializeToString(this.responseXML);
                        console.log(new XMLSerializer().serializeToString(this.responseXML));
                    }
                    else
                    {
                        console.log("ready state = " + this.readyState + "\nstatus = " + this.status);
                        document.getElementById("reqres").innerHTML = this.responseText +
                            "\n\nready state = " + this.readyState + "\nstatus = " + this.status;
                    }
                };
                xhttp.open("POST", "https://communion.herokuapp.com/api/updateservice", true);
                xhttp.body = document.getElementById("inputbody").value;
                xhttp.send();
            }
        </script>
        <textarea class="form-control" rows="5" id="inputbody"></textarea>
        <br/>
        <a class="btn btn-dark" onclick="submit();">submit</a>
    </form>
    <br/>
    <hr class="center-block small"/>
    <textarea class="label-default" id="reqres" style="background-color: #d6e9c6; min-width: 600px; min-height: 300px; border: none;"></textarea>
</div>
</body>
</html>
