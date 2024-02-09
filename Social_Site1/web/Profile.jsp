
<%@page import="action.KMeans"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.ArrayList"%>
<%@page import="action.SimilarityCalculationDemo"%>
<%@page import="java.util.Random"%>
<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>

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
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/newjavascript.js" type="text/javascript"></script>
        <script>

        </script>
    </head>
    <body>
        <%
            String str = "";
            if (request.getParameter("message") != null) {
                if (request.getParameter("message").contains("Success")) {
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
                    <li>
                        <a href="Post.jsp">Post</a>
                    </li>
                    <li>
                        <a href="Request.jsp">Request</a>
                    </li>
                    <li>
                        <a href="Friend.jsp">Friend</a>
                    </li>
                    <li class="selected">
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

                    <%
                        if (str.equals("success")) {
                            out.println("<div class='req'><h5>Profile Updated Successfully </h5></div>");
                        }
                        if (str.equals("failed")) {
                            out.println("<div class='req'><h5>Error, Failed to Update Profile plz try again </h5></div>");
                        }
                    %>

                    <h1><center>Update Profile</center></h1>          
                    <div class="req">
                        <%
                            String[] args = {};
                            datalib.DataLib.main(args);
                            String query = "select * from user where email='" + email + "'";
                            DB db = new DB();
                            ResultSet rs = db.Select(query);
                            rs.next();
                            String dp = rs.getString("dp");
                            System.out.println(dp);
                            String fname = rs.getString("fname");
                            String lname = rs.getString("lname");
                            String phone = rs.getString("phone");
                            String bday = rs.getString("bday");
                            String gender = rs.getString("gender");
                            String profession = rs.getString("profession");
                            String h1 = rs.getString("h1");
                            String h2 = rs.getString("h2");
                            String h3 = rs.getString("h3");
                            String h4 = rs.getString("h4");
                            String h5 = rs.getString("h5");
                            if (dp == null) {
                                dp = "profile/default.jpg";
                            }
                            if (phone == null) {
                                phone = "";
                            }
                            if (profession == null) {
                                profession = "";
                            }
                            if (h1 == null) {
                                h1 = "";
                            }
                            if (h2 == null) {
                                h2 = "";
                            }
                            if (h3 == null) {
                                h3 = "";
                            }
                            if (h4 == null) {
                                h4 = "";
                            }
                            if (h5 == null) {
                                h5 = "";
                            }

                            out.println("<form action='Profile_1.jsp' method='post' enctype='multipart/form-data'>");
                            out.println("<img src='" + dp + "' width='200px' height='200px'><br/>");
                            out.println("<table style='font-size:20px'>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("First Name ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(fname);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Last Name  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(lname);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Email id  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(email);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Contact No  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(phone);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Birth Date  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(bday);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Gender  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(gender);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Profession  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(profession);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td>");
                            out.println("Hobbies  ");
                            out.println("</td>");
                            out.println("<td>");
                            out.println(h1 + "," + h2 + "," + h3 + "," + h4 + "," + h5);
                            out.println("</td>");
                            out.println("</tr>");
                            out.println("</table>");
                            out.println("<br/><input type='submit' value='Click to Update Profile' class='btn'>");
                            out.println("</form>");
                            out.println("    <a href='posts.jsp'> <input type='button' value=' Posts ' class='btn'/></a>");
                        %>
                    </div>
                </div>

                <div id="sidebar">
                    <h1>Advertisement</h1>
                    <%
                        int id = 0;
                        //Randomly Images Selected  by Advertisement.....
                        try {

                            DB db2 = new DB();
                            ResultSet rs3 = db2.Select("select * from user where email='" + email + "'");
                            rs3.next();

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
