
<%@page import="action.KMeans"%>
<%@page import="action.SimilarityCalculationDemo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
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
            String[] args = {};
            datalib.DataLib.main(args);
            if (request.getParameter("message") != null) {
                if (request.getParameter("message").contains("success")) {
                    out.println("<script>");
                    out.println("alert('Login Successfully');");
                    out.println("</script>");
                }
            }
            HttpSession hs = request.getSession();
            String d1 = request.getRequestURL().toString();
            String email = hs.getAttribute("email").toString();
            if (email == null) {
                response.sendRedirect("login.jsp?message='expired'");
            }
            hs.setAttribute("email", email);
            hs.setAttribute("d", d1);
        %>
        <div id="header">
            <div>
                <div id="logo">
                    <a href="index.html"><span><img src="images/logo.png" height="55"></span></a>
                </div>
                <ul id="navigation">
                    <li class="selected">
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
            <div id="adbox">
                <%
                    String profession;
                    String dp = "profile/default.jpg";
                    DB db1 = new DB();
                    ResultSet rs = db1.Select("Select dp,profession from user where email='" + email + "'");
                    rs.next();
                    dp = rs.getString("dp");
                    profession = rs.getString("profession");

                    out.println("<img class='dp' src='" + dp + "'x alt='Img'>");
                %>
                <h4>Hello! <br><% out.println(hs.getAttribute("fname"));
                    out.println(hs.getAttribute("lname"));
                    %>
                    <p>
                        <%
                            if (profession != null) {
                                out.println(profession);
                            }
                        %>
                    </p></h4>
            </div>
            <div id="featured" class="body">
                <div id="main">
                    <h1>Post Status</h1>
                    <form action='PostMessage' method='post' enctype='multipart/form-data' style="border-bottom: 1px #000 solid">
                        <textarea rows="4" cols="70" name="message"></textarea>
                        <input type="file" class="btn" name="pic" accept="image/*"><br/><br/>
                        <input type="submit" value=" Post " class="btn">
                        <a href="friendlist.jsp"> <input type="button" value=" Friend " class="btn"/></a>
                        <br/><br/>
                    </form>
                    <div class="homepost">

                        <%
                            try {
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
                                ResultSet rs2 = db.Select(q);
                                int c = 0;
                                if (rs2.next()) {

                                    rs2.last();
                                    do {
                                        out.println("<h4><u>" + rs2.getString("fname") + " " + rs2.getString("lname") + "</u></h4>");
                                        out.println(rs2.getString("message"));
                                        String img = rs2.getString("img");
                                        if (!img.equals("post/")) {
                                            out.println("<img width=200px, height=200px src=" + img + ">");
                                        }

                                        out.println("<br/>");
                                        out.println("<div>");

                                        out.println("</div>");
                                        out.println("<hr/>");
                                        c++;
                                        if (c == 2) {
                                            break;
                                        }
                                    } while (rs2.previous());
                                    String sql = "SELECT * from liketable_ join items on liketable_.id=items.id where liketable_.email='" + email + "'";   //////like table and items data fetch
                                    ResultSet rs5 = db.Select(sql);
                                    int c1 = 0;
                                    if (rs5.next()) {

                                        rs5.last();
                                        do {
                                            out.println("<h4><u>" + rs5.getString("name") + "</u></h4><h5>This product like </h5>");
                                            // out.println(rs2.getString("message"));
                                            String img1 = rs5.getString("path");
                                            String path1 = "http://8080/OnlinePayment/images/";
                                            String path = path1 + img1;
                                            System.out.println(path);
                                            if (!path.equals("post/")) {
                                                out.println("<img width=200px, height=200px src=" + path + ">");
                                            }
                                            out.println("<br/>");
                                            String sql1 = "";
                                            out.println("<div>");

                                            out.println("</div>");
                                            out.println("<hr/>");
                                            c1++;
                                            if (c1 == 2) {
                                                break;
                                            }
                                        } while (rs5.previous());
                                        String sql1 = "SELECT * from orders join items on orders.items=items.id where orders.email='" + email + "'";   //////like table and items data fetch
                                        ResultSet rs6 = db.Select(sql);
                                        int c11 = 0;
                                        if (rs6.next()) {
                                            rs6.last();
                                            do {
                                                out.println("<h4><u>" + rs6.getString("name") + "</u></h4><h5>This product purchase </h5>");
                                                String img1 = rs6.getString("path");
                                                String path1 = "http://localhost:8080/OnlinePayment/images/";
                                                String path = path1 + img1;
                                                System.out.println(path);
                                                if (!path.equals("post/")) {
                                                    out.println("<img width=200px, height=200px src=" + path + ">");
                                                }
                                                out.println("<br/>");
                                                out.println("<div>");

                                                out.println("</table>");
                                                out.println("</div>");
                                                out.println("<hr/>");
                                                c11++;
                                                if (c11 == 1) {
                                                    break;
                                                }
                                            } while (rs6.previous());
                                        }
                                        rs6.close();
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>

                    </div>
                    <a href="Post.jsp"><input type="button" class="btn" value="Click to view all Post"></a>
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
