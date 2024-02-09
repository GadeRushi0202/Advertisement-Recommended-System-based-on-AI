<%-- 
    Document   : Forgot
    Created on : 29 Mar, 2017, 4:56:47 PM
    Author     : SCUBETT-1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Social Network</title>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

        <script type="text/javascript">

            function checkForm1()
            {
                var email = document.form2.email.value;
                if (email == 0) {
                    alert("Email Cannot be blank");
                    document.form2.email.focus();
                    return false;
                }
                return true;
            }

        </script>
    </head>
    <body>
        <div id="header">
            <div>
                <div id="logo">
                    <a href="index.jsp"><span><img src="images/logo.png"></span></a>
                </div>
            </div>
        </div>
        <div id="contents">
            <div id="featured" class="body">
                <div id="sidebar">
                    <h3>Forgot Password</h3>
                    <form  name="form2" id="form2" onsubmit="return checkForm1();" action="Forgot" method="post">
                        <table style="font-family:Comic sans MS ">
                            <tr>
                                <td>E-mail<input type="email" class="edittxt"  name="email" id="email"></td>
                            </tr>
                            <tr>

                            </tr>
                        </table>
                        <input type="submit" value="Send Me" style="font-family: Comic sans MS " class="btn">
                        <input type="reset" style="font-family: Comic sans MS " class="btn"><br/>
                    </form>         
                </div>
            </div>
        </div>
        <div id="footer">
            <div>
                <p>
                    © Copyright. All rights reserved.
                </p>
            </div>
        </div>
    </body>
</html>
