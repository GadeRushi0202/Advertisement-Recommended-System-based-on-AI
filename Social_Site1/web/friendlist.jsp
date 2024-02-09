<%-- 
    Document   : friendlist
    Created on : 9 Feb, 2018, 11:50:53 AM
    Author     : shri
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
        <title>Friend list</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link href="css/profile.css" rel="stylesheet" type="text/css"/>
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
                    <h1>Friend List</h1>                      
                    <div class="req">    
                        <%
                            int count = 0;
                            String query = "select * from friends where user1='" + email + "'or user2='" + email + "'";
                            DB d1 = new DB();
                            ResultSet r = d1.Select(query);
                            if (r.next()) {
                                String query1 = "Select * from friends where user1='" + email + "'";
                                DB db = new DB();
                                ResultSet rs = db.Select(query1);
                                while (rs.next()) {
                                    String email1 = rs.getString("user2");
                                    String s = "Select * from user where email='" + email1 + "'";
                                    DB d2 = new DB();
                                    ResultSet r1 = d2.Select(s);
                                    if (r1.next()) {
                                        String name1 = r1.getString("fname") + " " + r1.getString("lname");
                                        out.println("<span class='name'>" + name1 + "</span><br/>");
                                        out.println("<img src='" + r1.getString("dp") + "' class='fdp'>");
                                        out.println("<a href='#'><input type='submit' value='Message' class='btn'></a><a href='blockfriend.jsp?" + email1 + "'><input type='submit' value='Block' class='btn'></a><a href='deletefriend.jsp?" + email1 + "'><input type='submit' value='Delete' class='btn'></a><br/><hr/>");
                                    }
                                    count++;
                                }
                                DB db1 = new DB();
                                String q = "select * from friends where user2='" + email + "'";
                                ResultSet rs1 = db1.Select(q);
                                while (rs1.next()) {
                                    String email1 = rs1.getString("user1");
                                    String s = "Select * from user where email='" + email1 + "'";
                                    DB d2 = new DB();
                                    ResultSet r1 = d2.Select(s);
                                    if (r1.next()) {
                                        String name1 = r1.getString("fname") + " " + r1.getString("lname");
                                        out.println("<span class='name'>" + name1 + "</span><br/>");
                                        out.println("<img src='" + r1.getString("dp") + "' class='fdp'>");
                                        out.println("<a href='#'><input type='submit' value='Message' class='btn'></a><a href='blockfriend.jsp?" + email1 + "'><input type='submit' value='Block' class='btn'></a><a href='deletefriend.jsp?" + email1 + "'><input type='submit' value='Delete' class='btn'></a><br/><hr/>");
                                    }
                                    count++;
                                }
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
                            ArrayList<String> hobbies = new ArrayList<String>();
                            hobbies.add(h1);
                            hobbies.add(h2);
                            hobbies.add(h3);
                            hobbies.add(h4);
                            hobbies.add(h5);

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
