<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>

<%@page import="action.KMeans"%>
<%@page import="action.SimilarityCalculationDemo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Social Network</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link href="css/newcss.css" rel="stylesheet" type="text/css"/>
        <script src="js/newjavascript.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession hs = request.getSession();
            String email = hs.getAttribute("email").toString();
            if (email == null) {
                response.sendRedirect("login.jsp?message='expired'");
            }
            DB db = new DB();
            hs.setAttribute("email", email);

            String name = request.getParameter("searchuser");

        %>
        <div id="header">
            <div>
                <div id="logo">
                    <a href="index.html"><span><img src="images/logo.png" height="55"></span></a>
                </div>
                <ul id="navigation">
                    <li>
                        <a href="Home.jsp">Home</a>
                    </li>
                    <li>
                        <a href="Post.jsp">Post</a>
                    </li>
                    <li>
                        <a href="Request.jsp">Request</a>
                    </li>
                    <li class="selected">
                        <a href="Friend.jsp">Friend</a>
                    </li>
                    <li>
                        <a href="Profile.jsp">Profile</a>
                    </li>
                    <li>
                        <a href="login.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
        <div id="contents">
            <div id="featured" class="body">
                <div id="main">
                    <h1>Search <img src="images/search.png" class="fdp"> Friend</h1>

                    <form action="Friend_1.jsp">
                        <input type="text" class="txtfield" name="searchuser">
                        <input type="submit" value="Search User" class="btn">
                    </form>
                    <div class="req">
                        <%                            String query = "select * from user where email like '%" + name + "%' or ( fname like '%" + name + "%' or lname like '%" + name + "%')";
                            ResultSet rs = db.Select(query);
                            int flag = 0;
                            while (rs.next()) {

                                String fname = rs.getString("fname");
                                String lname = rs.getString("lname");
                                String email1 = rs.getString("email");
                                String dp = rs.getString("dp");
                                DB db2 = new DB();

                                String str2 = "select * from friends where (user1='" + email1 + "' and user2='" + email + "') or (user1='" + email + "' and user2='" + email1 + "')";
                                ResultSet rs1 = db2.Select(str2);
                                if (rs1.next()) {
                                }
                                DB db1 = new DB();
                                String str3 = "select * from friendreq where (sender='" + email1 + "' and receiver='" + email + "') or (sender='" + email + "' and receiver='" + email1 + "')";
                                ResultSet rs2 = db1.Select(str3);
                                out.println("<img src='" + dp + "' class='fdp'>");
                                if (!rs2.next()) {
                                    out.println("<input type='text' class='name' value='" + fname + " " + lname + "'><input type='text' class='name' value='" + email1 + "'><a href='Friend_2.jsp?" + email1 + "'><input type='submit' value='Send Friend Request' class='btn'></a><br/>");
                                } else {
                                    out.println("<input type='text' class='name' value='" + fname + " " + lname + "'><input type='text' class='name' value='" + email1 + "'><input type='button' value='Friend Request Allready Sent' class='btn'><br/>");
                                }
                                flag++;
                            }
                            if (flag < 1) {
                                out.println("<h5>No Result found for ' " + name + " ' plz try agaiin</h5>");
                            }

                        %>
                    </div>
                </div>
                <div id="sidebar">
                    <h1>Advertisement</h1>
                    <%                        //Randomly Images Selected  by Advertisement.....
                        try {

                            DB db2 = new DB();
                            ResultSet rs3 = db2.Select("select * from user where email='" + email + "'");
                            rs3.next();
                            String h1 = rs3.getString("h1");
                            String h2 = rs3.getString("h2");
                            String h3 = rs3.getString("h3");
                            String h4 = rs3.getString("h4");
                            String h5 = rs3.getString("h5");
                            String gender = rs3.getString("gender");
                            ArrayList<String> hobbies = new ArrayList<String>();
                            hobbies.add(h1);
                            hobbies.add(h2);
                            hobbies.add(h3);
                            hobbies.add(h4);
                            hobbies.add(h5);
                            hobbies.add(gender);
                            DB db3 = new DB();
                            ResultSet rs4 = db3.Select("select * from items order by rand() limit 10");
                            out.println("<div class='slider' id='main-slider'>");
                            out.println("<div class='slider-wrapper'>");
                            while (rs4.next()) {
                                int count = 0;
                                String tags = rs4.getString("tags");
                                String tags1[] = tags.split("#");
                                for (int i = 0; i < hobbies.size(); i++) {
                                    for (int j = 0; j < tags1.length; j++) {
                                        SimilarityCalculationDemo scd = new SimilarityCalculationDemo();
                                        String hobbie = hobbies.get(i);
                                        String tags3 = tags1[j];
                                        double d = scd.compute(hobbie, tags3);
                                        if (d >= 0.3) {
                                            count++;

                                        }

                                    }
                                }
                                if (count > 1) {

                                    int id = rs4.getInt("id");

                                    //Blob image = rs.getBlob("pimage");
                                    out.println(" <a href='http://localhost:8080/OnlinePayment/login.jsp'><img src='imageServlet?id=" + id + "' alt='0' class='slide'></a><br>");

                                }

                            }
                            KMeans kmeans = new KMeans(email);
                            ArrayList ids = kmeans.getId();
                            int count = 0;
                            for (int i = 0; i < ids.size(); i++) {
                                if (count > 5) {
                                    break;
                                }
                                out.println(" <a href='http://localhost:8084/OnlinePayment/login.jsp'><img src='imageServlet?id=" + ids.get(i) + "' alt='0' class='slide'></a><br>");
                                count++;
                            }
                            out.println(" </div>");
                            out.println(" </div>");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>


                    <!--
                    <h5>Lotto Zion Running Sports Shoes Lotto Zion Running Sports</h5>
                    <img src="images/lotto.jpg">
                    <a href="#" class="s2"><img class="smallimg" src="images/like.png"> 12 </a>
                    <span class="s1"><img class="smallimg" src="images/rs.png"> 400/-</span> 
                    <a href="#" class="s2"><img class="smallimg" src="images/cart.png"> Buy </a>
                    <br>
                    <h5>Watches - Men's & Women's</h5>
                    <img src="images/watch.bmp">
                    <a href="#" class="s2"><img class="smallimg" src="images/like.png"> 12 </a>
                    <span class="s1"><img class="smallimg" src="images/rs.png"> 99/-</span> 
                    <a href="#" class="s2"><img class="smallimg" src="images/cart.png"> Buy </a>
                    -->

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
