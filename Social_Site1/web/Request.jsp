<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>

<%@page import="action.KMeans"%>
<%@page import="java.util.ArrayList"%>
<%@page import="action.SimilarityCalculationDemo"%>
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
    </head>
    <body>
        <%
            String str1 = "", str = "";
            if (request.getParameter("message") != null) {
                if (request.getParameter("message").contains("Delete")) {
                    str = "delete";
                    str1 = request.getParameter("name");
                }
                if (request.getParameter("message").contains("Accept")) {
                    str = "accept";
                    str1 = request.getParameter("name");
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
                    <li class="selected">
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
                    <h1>Accept or Reject Friend Request</h1> 
                    <%                
                        if (str.equals("accept")) {
                            out.println("<div class='req'><h5>You are now friend of " + str1 + "</h5></div>");
                        }
                        if (str.equals("delete")) {
                            out.println("<div class='req'><h5>Friend request sent by " + str1 + " is deleted" + str1 + "</h5></div>");
                        }
                    %>   
                    <div class="req">    
                        <%        
                            String query = "select * from friendreq where receiver='" + email + "'";
                            DB db = new DB();
                            ResultSet rs = db.Select(query);
                            int count = 0;
                            while (rs.next()) {
                                String sender = rs.getString("sender");
                                DB db1 = new DB();
                                String q = "select * from user where email='" + sender + "'";
                                ResultSet rs1 = db1.Select(q);
                                while (rs1.next()) {
                                    String email1 = rs1.getString("email");
                                    String name1 = rs1.getString("fname") + " " + rs1.getString("lname");
                                    out.println("<br/><img src='" + rs1.getString("dp") + "' class='fdp'>");
                                    out.println("<span class='name'>" + name1 + "</span><a href='Accept.jsp?" + email1 + "'><input type='submit' value='Accept' class='btn'></a><a href='Reject.jsp?" + email1 + "'><input type='submit' value='Reject' class='btn'></a><br/><hr/>");
                                }
                                count++;
                            }
                            if (count == 0) {
                                out.println("<div class='req'><h5>You don't have any friend request</h5></div>");
                            }
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
                                int count2 = 0;
                                String tags = rs4.getString("tags");
                                String tags1[] = tags.split("#");
                                for (int i = 0; i < hobbies.size(); i++) {
                                    for (int j = 0; j < tags1.length; j++) {
                                        SimilarityCalculationDemo scd = new SimilarityCalculationDemo();
                                        String hobbie = hobbies.get(i);
                                        String tags3 = tags1[j];
                                        double d = scd.compute(hobbie, tags3);
                                        if (d >= 0.3) {
                                            count2++;
                                            
                                        }
                                        
                                    }
                                }
                                if (count2 > 1) {
                                    
                                    id = rs4.getInt("id");

                                    //Blob image = rs.getBlob("pimage");
                                    out.println(" <a href='http://localhost:8080/OnlinePayment/single_1.jsp?id=" + id + "&email=" + email + "'><img src='imageServlet?id=" + id + "' alt='0' class='slide'></a><br>");
                                    
                                }
                            }
                            
                            KMeans kmeans = new KMeans(email);
                            ArrayList ids = kmeans.getId();
                            int count1 = 0;
                            for (int i = 0; i < ids.size(); i++) {
                                if (count1 > 5) {
                                    break;
                                }
                                id = Integer.parseInt(ids.get(i).toString());
                                out.println(" <a href='http://localhost:8080/OnlinePayment/single_1.jsp?id=" + ids.get(i) + "&email=" + email + "'><img src='imageServlet?id=" + ids.get(i) + "' alt='0' class='slide'></a><br>");
                                count1++;
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
