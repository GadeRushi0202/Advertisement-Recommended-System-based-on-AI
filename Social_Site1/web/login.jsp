
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

        <script>
            $(document).ready(function () {
                $("#bdays").datepicker();
            });
        </script>
        <script type="text/javascript">

            function checkForm()
            {
                var fname = document.form1.fname.value;
                var lname = document.form1.lname.value;
                var email = document.form1.email.value;
                var password = document.form1.password.value;
                var bday = document.form1.bday.value;
                var letters = /^[A-Za-z]+$/;
                if (fname == 0) {
                    alert("First name Cannot be blank");
                    document.form1.fname.focus();
                    return false;
                }
                if (!isNaN(fname)) {
                    alert("Enter Only Characters first name");
                    document.form1.fname.focus();
                    return false;
                }
                if (lname == 0) {
                    alert("Last name Cannot be blank");
                    document.form1.lname.focus();
                    return false;
                }
                if (!isNaN(lname)) {
                    alert("Enter Only Characters last name");
                    document.form1.lname.focus();
                    return false;
                }
                if (email == 0) {
                    alert("EMail Cannot be blank");
                    document.form1.email.focus();
                    return false;
                }
                if (password == 0) {
                    alert("Password Cannot be blank");
                    document.form1.password.focus();
                    return false;
                }
                if (document.form1.password.value !== "") {
                    if (document.form1.password.value.length < 6) {
                        alert("Error: Password must contain at least six characters!");
                        document.form1.password.focus();
                        return false;
                    }
                    re = /[@./#&+-]*$/;
                    if (!re.test(document.form1.password.value)) {
                        alert("Error: Password must contain at least one special symbol!");
                        document.form1.password.focus();
                        return false;
                    }
                    re = /[0-9]/;
                    if (!re.test(document.form1.password.value)) {
                        alert("Error: password must contain at least one number (0-9)!");
                        document.form1.password.focus();
                        return false;
                    }
                    re = /[a-z]/;
                    if (!re.test(document.form1.password.value)) {
                        alert("Error: password must contain at least one lowercase letter (a-z)!");
                        document.form1.password.focus();
                        return false;
                    }
                    re = /[A-Z]/;
                    if (!re.test(document.form1.password.value)) {
                        alert("Error: password must contain at least one uppercase letter (A-Z)!");
                        document.form1.password.focus();
                        return false;
                    }

                }
                if (bday == 0) {
                    alert("DOB Cannot be blank");
                    document.form1.bday.focus();
                    return false;
                }

                return true;
            }
            function checkForm1()
            {
                var email = document.form2.email1.value;
                if (email == 0) {
                    alert("Email Cannot be blank");
                    document.form2.email1.focus();
                    return false;
                }
                return true;
                return true;
            }

        </script>
        <%
            String[] args = {};
            datalib.DataLib.main(args);
        %>
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
                <div id="main">
                    <span id="regform">
                        <img src="images/register.png" class="log">
                        <form action="Register" name="form1" id="form1" onsubmit="return checkForm();">
                            <table style="font-family:Comic sans MS ">
                                <tr>
                                    <td>First Name</td>
                                    <td> <input type="text" class="edittxt" id="fname"  name="fname"></td>
                                </tr>
                                <tr>
                                    <td>Last Name</td> 
                                    <td><input type="text" id="lname" class="edittxt" name="lname"></td>
                                </tr>
                                <tr>
                                    <td>Email id</td>
                                    <td><input type="email" id="email"  class="edittxt" name="email"></td>
                                </tr>
                                <tr>
                                    <td>Password</td>
                                    <td><input type="password" id="password" class="edittxt" name="password"></td>
                                </tr>
                                <tr>
                                    <td>Birth Date </td>
                                    <td><input type="text" class="edittxt" id="bdays" name="bday"></td>
                                </tr>
                                <br>
                            </table>
                            <br>
                            <input type="submit" value="Register" style="font-family: Comic sans MS " class="btn">
                            <input type="reset" style="font-family: Comic sans MS " class="btn">
                        </form>
                    </span>
                    <h1 id="rmsg" style="visibility:hidden">User Register Successfully</h1>
                    <h1 id="rmsg1" style="visibility:hidden">User Session Expired please login again</h1>

                </div>
                <div id="sidebar">
                    <img src="images/login.png" class="log">
                    <form action="Login" name="form2" id="form2" onsubmit="return checkForm1();" method="post">
                        <table style="font-family:Comic sans MS ">
                            <tr>
                                <td>E-mail<input type="email" class="edittxt"  name="email1" id="email1" required=""></td>
                            </tr>
                            <tr>
                                <td>Password<input type="password" class="edittxt" name="password1" id="password1" required=""></td>
                            </tr>
                        </table>
                        <input type="submit" value="Login" style="font-family: Comic sans MS " class="btn">
                        <input type="reset" style="font-family: Comic sans MS " class="btn"><br/>
                        <a href="Forgot.jsp">forgot password</a>
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
