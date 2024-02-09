<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>

<%@page import="action.KMeans"%>
<%@page import="action.SimilarityCalculationDemo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Social Network</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link href="css/profile.css" rel="stylesheet" type="text/css"/>
        <link href="css/newcss.css" rel="stylesheet" type="text/css"/>
        <script src="js/newjavascript.js" type="text/javascript"></script>
        <script>
            var cnt = 0;
            function CountFun() {
                cnt = parseInt(cnt) + parseInt(1);
                var divData = document.getElementById("showCount");
                divData.innerHTML = "Number of Downloads: (" + cnt + ")"; //this part has been edited

            }
        </script>
    </head>
    <body>
        <%
            String str = "";
            if (request.getParameter("message") != null) {
                if (request.getParameter("message").contains("success")) {
                    str = "success";
                }
                if (request.getParameter("message").contains("failed")) {
                    str = "failed";
                }
            }
            HttpSession hs = request.getSession();
            String email = hs.getAttribute("email").toString();
            if (email == null) {
                response.sendRedirect("login.jsp?message='expired'");
            }
            hs.setAttribute("email", email);
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
                    <li class="selected">
                        <a href="Post.jsp">Post</a>
                    </li>
                    <li>
                        <a href="Request.jsp">Request</a>
                    </li>
                    <li>
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
                    <h1>Post's</h1>
                    <%
                        if (str.equals("success")) {
                            out.println("<div class='req'><h5>Message poseted..... </h5></div>");
                        }
                        if (str.equals("failed")) {
                            out.println("<div class='req'><h5>Failed to post message</h5></div>");
                        }
                    %>

                    <div class="homepost">
                        <%
                            DB db = new DB();

                            String q = "", qq = "";
                            String inq = "'" + email + "'";
                            qq = "select * from friends where user1='" + email + "' or user2='" + email + "'";
                            ResultSet rs1 = db.Select(qq);
                            while (rs1.next()) {
                                String temp1 = rs1.getString("user2"), temp = rs1.getString("user1");
                                if (!temp.equals(email)) {
                                    inq = inq + ",'" + temp + "'";
                                }
                                if (!temp1.equals(email)) {
                                    inq = inq + ",'" + temp1 + "'";
                                }
                            }
                            System.out.println(" Friends 1 " + inq);
                            q = "select * from post where email IN(" + inq + ")";
                            ResultSet rs = db.Select(q);
                            DB db1 = new DB();
                            if (rs.next()) {
                                rs.last();
                                do {
                                    out.println("<h4><u>" + rs.getString("fname") + " " + rs.getString("lname") + "</u></h4>");
                                    out.println(rs.getString("message"));
                                    String img = rs.getString("img");
                                    if (!img.equals("post/")) {
                                        out.println("<img height=200px, width=200px src=" + img + ">");
                                    }
                                    out.println("<br/>");
                        %>
                        <div id="showCount"></div>
                        <%
                                    String likes = "0";
                                    String dislikes = "0";
                                    String sql = "select count(id) as total,status_ from postlike where id='" + rs.getString("id") + "' group by status_";
                                    ResultSet rr = db1.Select(sql);

                                    while (rr.next()) {
                                        if (rr.getString("status_").equals("like")) {
                                            likes = rr.getString("total");
                                        } else {
                                            dislikes = rr.getString("total");
                                        }
                                    }

                                    out.println("<div>");
                                    out.println("<table>");
                                    out.println("<th td colspan='4' style='width: 15em; text-align: left'></th>");
                                    out.println("<tr>");
                                    out.println("<td><a href='LikePage?" + rs.getString("id") + "'>" + likes + "<img src='images/ll1.png' height='35' width='35'></a></td> ");
                                    out.println("<td><a href='DislikePage?" + rs.getString("id") + "'>" + dislikes + "<img src='images/d1.png' height='35' width='35'></a></td> ");
                                    out.println("</tr>");
                                    out.println("</table>");
                                    out.println("</div>");
                                    out.println("<hr/>");
                                } while (rs.previous());
                            }

                            String sql = "SELECT * from liketable_ join items on liketable_.id=items.id where liketable_.email IN(" + inq + ")";   //////like table and items data fetch
                            ResultSet rs5 = db.Select(sql);
                            int c1 = 0;
                            if (rs5.next()) {
                                rs5.last();
                                do {
                                    String id = rs5.getString("id");
                                    String likes = "0";
                                    String dislikes = "0";
                                    String sql1 = "select count(id) as total,status from liketable_ where id='" + id + "' group by status";
                                    ResultSet rr = db1.Select(sql1);

                                    while (rr.next()) {
                                        if (rr.getString("status").equals("like")) {
                                            likes = rr.getString("total");
                                        } else {
                                            dislikes = rr.getString("total");
                                        }
                                    }

                                    out.println("<h4><u>" + rs5.getString("name") + "</u></h4><h5>This product like </h5>");
                                    String img1 = rs5.getString("path");
                                    String path1 = "http://localhost:8084/OnlinePayment/images/";
                                    String path = path1 + img1;
                                    System.out.println(path);
                                    if (!path.equals("post/")) {
                                        out.println("<img height=200px, width=200px src=" + path + ">");
                                    }
                                    out.println("<br/>");
                                    out.println("<div>");
                                    out.println("<table>");
                                    out.println("<th td colspan='4' style='width: 15em; text-align: left'></th>");
                                    out.println("<tr>");
                                    out.println("<td>" + likes + "<a href='LikeItems?" + id + "'><img src='images/ll1.png' height='35' width='35'></a></td> ");
                                    out.println("<td>" + dislikes + "<a href='LikeItems?" + id + "'><img src='images/d1.png' height='35' width='35'></a></td> ");
                                    out.println("</tr>");
                                    out.println("</table>");
                                    out.println("</div>");
                                    out.println("<hr/>");
                                    c1++;
                                    if (c1 == 4) {
                                        break;
                                    }
                                } while (rs5.previous());
                            }
                            rs5.close();

                            String sql1 = "SELECT * from orders join items on orders.items=items.id where orders.email IN(" + inq + ")";   //////like table and items data fetch
                            ResultSet rs6 = db.Select(sql1);
                            int c11 = 0;
                            if (rs6.next()) {
                                rs6.last();
                                do {
                                    String id = rs6.getString("id");

                                    String likes = "0";
                                    String dislikes = "0";
                                    String sql2 = "select count(id) as total,status from liketable_ where id='" + id + "' group by status";
                                    ResultSet rr = db1.Select(sql2);

                                    while (rr.next()) {
                                        if (rr.getString("status").equals("like")) {
                                            likes = rr.getString("total");
                                        } else {
                                            dislikes = rr.getString("total");
                                        }
                                    }

                                    out.println("<h4><u>" + rs6.getString("name") + "</u></h4><h5>This product purchase </h5>");
                                    String img1 = rs6.getString("path");
                                    String path1 = "http://localhost:8084/OnlinePayment/images/";
                                    String path = path1 + img1;
                                    System.out.println(path);
                                    if (!path.equals("post/")) {
                                        out.println("<img height=200px, width=200px src=" + path + ">");
                                    }
                                    out.println("<br/>");
                                    out.println("<div>");
                                    out.println("<table>");
                                    out.println("<th td colspan='4' style='width: 15em; text-align: left'></th>");
                                    out.println("<tr>");
                                    out.println("<td>" + likes + "<a href='LikeItems?" + id + "'><img src='images/ll1.png' height='35' width='35'></a></td> ");
                                    out.println("<td>" + dislikes + "<a href='LikeItems?" + id + "'><img src='images/d1.png' height='35' width='35'></a></td> ");
                                    out.println("</tr>");
                                    out.println("</table>");
                                    out.println("</div>");
                                    out.println("<hr/>");
                                    c11++;

                                } while (rs6.previous());
                            }
                            rs6.close();
                        %>

                    </div>

                </div>

                <div id="sidebar">
                    <h1>Advertisement</h1>
                    <%
                        int id = 0;
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
                            ResultSet rs4 = db3.Select("select * from items order by rand() limit 2");
                            out.println("<div class='slider' id='main-slider'>");
                            out.println("<div class='slider-wrapper'>");
                            while (rs4.next()) {
                                int count1 = 0;
                                String tags = rs4.getString("tags");
                                String tags1[] = tags.split("#");
                                for (int i = 0; i < hobbies.size(); i++) {
                                    for (int j = 0; j < tags1.length; j++) {
                                        SimilarityCalculationDemo scd = new SimilarityCalculationDemo();
                                        String hobbie = hobbies.get(i);
                                        String tags3 = tags1[j];
                                        double d = scd.compute(hobbie, tags3);
                                        if (d >= 0.3) {
                                            count1++;

                                        }

                                    }
                                }
                                if (count1 > 1) {

                                    id = rs4.getInt("id");

                                    //Blob image = rs.getBlob("pimage");
                                    out.println(" <a href='http://localhost:8080/OnlinePayment/single_1.jsp?id=" + id + "&email=" + email + "'><img src='imageServlet?id=" + id + "' alt='0' class='slide'></a><br>");

                                }

                            }
                            KMeans kmeans = new KMeans(email);
                            ArrayList ids = kmeans.getId();
                            int count = 0;
                            for (int i = 0; i < ids.size(); i++) {
                                if (count > 5) {
                                    break;
                                }
                                id = Integer.parseInt(ids.get(i).toString());
                                out.println(" <a href='http://localhost:8080/OnlinePayment/single_1.jsp?id=" + ids.get(i) + "&email=" + email + "'><img src='imageServlet?id=" + ids.get(i) + "' alt='0' class='slide'></a><br>");
                                count++;
                            }
                            out.println(" </div>");
                            out.println(" </div>");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>

                    <!--    <h5>Lotto Zion Running Sports Shoes Lotto Zion Running Sports</h5>
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
