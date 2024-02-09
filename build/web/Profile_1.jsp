<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>

<%@page import="action.KMeans"%>
<%@page import="java.util.ArrayList"%>
<%@page import="action.SimilarityCalculationDemo"%>
<%@page import="java.util.Random"%>
<%@page import="action.CreatecardCheck"%>
<%@page import="java.util.Date"%>
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
    <script>
        function check() {
            var uname = document.getElementById("uname");
            var lname = document.getElementById("lname");
            var mail = document.getElementById("email");
            var phone = document.getElementById("phone");
            var bday = document.getElementById("bday");
            if (uname == "") {
                valid = 0;
                uname.innerHTML = "Field Required";
                uname.style.display = "block";
                uname.parentNode.style.backgroundColor = "#FFDFDF";
            }
            if (lname == "") {
                valid = 0;
                lname.innerHTML = "Field Required";
                lname.style.display = "block";
                lname.parentNode.style.backgroundColor = "#FFDFDF";
            }
            if (mail == "") {
                valid = 0;
                mail.innerHTML = "Field Required";
                mail.style.display = "block";
                mail.parentNode.style.backgroundColor = "#FFDFDF";
            }

            if (phone == "") {
                valid = 0;
                phone.innerHTML = "Field Required";
                phone.style.display = "block";
                phone.parentNode.style.backgroundColor = "#FFDFDF";
            }
            if (isNaN(phone)) {
                alert("Invalid phoneno");
                document.ureg.phone.focus();
                return  false;
            }
            if (!valid)
                return false;
        }
    </script>

    <script>


    </script>

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
                    <h1>Update profile</h1>          
                    <div class="req">
                        <%
                            String query = "select * from user where email='" + email + "'";
                            DB db = new DB();
                            ResultSet rs = db.Select(query);
                            rs.next();
                            String dp = rs.getString("dp");
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
                                dp = "profile/default";
                            }
                            if (gender == null) {
                                gender = "";
                            }
                            if (phone == null) {
                                phone = "";
                            }
                            if (profession == null) {
                                profession = "";
                            }
                            if (h1 == null) {
                                h1 = " ";
                            }
                            if (h2 == null) {
                                h2 = " ";
                            }
                            if (h3 == null) {
                                h3 = " ";
                            }
                            if (h4 == null) {
                                h4 = " ";
                            }
                            if (h5 == null) {
                                h5 = " ";
                            }

                            out.println("<form action='CreatecardCheck' id='ureg' name='ureg' method='post' enctype='multipart/form-data' onsubmit='return check()'>");
                            out.println("<table>");

                            out.println("<tr>");
                            out.println("<td class='text'>Profile Picture</td>  <td><input type='file' class='btn' name='profilepic' value='" + dp + "' accept='image/*'><td/>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>First Name</td> <td><input type='text' value='" + fname + "' class='edittxt' name='fname'></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>Last Name</td> <td><input type='text' class='edittxt' value='" + lname + "' name='lname'></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>Email id</td> <td><input type='email' class='edittxt' value='" + email + "' name='email'></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>Contact No</td><td> <input type='text' class='edittxt' value='" + phone + "' name='phone'></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>Birth Date</td><td> <input type='date' class='edittxt' value='" + bday + "' name='bday'></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>Gender</td> <td><select class='edittxt' name=\"gender\" id=\"select\">");
                            out.println("    <option value='' >Select Gender</option>");
                            if (gender.equals("male")) {
                                out.println("    <option value='male' selected='selected' >MALE</option>");
                            } else {
                                out.println("    <option value='male' >MALE</option>");
                            }
                            if (gender.equals("female")) {
                                out.println("    <option value='female' selected='selected' >FEMALE</option>");
                            } else {
                                out.println("    <option value='female' >FEMALE</option>");
                            }

                            out.println("  </select></td>");
                            out.println("</tr>");
                            out.println("<tr>");

                            out.println("<td class='text'>Profession</td><td><select class='edittxt' name=\"profession\" id=\"select\">");
                            out.println("    <option value='' >Select Profession</option>");
                            if (profession.equals("Student")) {
                                out.println("    <option value='Student' selected='selected' >Student</option>");
                            } else {
                                out.println("    <option value='Student' >Student</option>");
                            }
                            if (profession.equals("Business")) {
                                out.println("    <option value='Business' selected='selected' >Business</option>");
                            } else {
                                out.println("    <option value='Business' >Business</option>");
                            }
                            if (profession.equals("Software Engineer")) {
                                out.println("    <option value='Software Engineer' selected='selected'>Software Engineer</option>");
                            } else {
                                out.println("    <option value='Software Engineer' >Software Engineer</option>");
                            }
                            if (profession.equals("Transport")) {
                                out.println("    <option value='Transport' selected='selected'>Transport</option>");
                            } else {
                                out.println("    <option value='Transport' >Transport</option>");
                            }
                            if (profession.equals("Medical")) {
                                out.println("    <option value='Medical' selected='selected'>Medical</option>");
                            } else {
                                out.println("    <option value='Medical' >Medical</option>");
                            }
                            if (profession.equals("Public services")) {
                                out.println("    <option value='Public services' selected='selected'>Public services</option>");
                            } else {
                                out.println("    <option value='Public services' >Public services</option>");
                            }
                            if (profession.equals("Other")) {
                                out.println("    <option value='Other' selected='selected'>Other</option>");
                            } else {
                                out.println("    <option value='Other' >Other</option>");
                            }
                            out.println("  </select></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>Hobbies</td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>1st Hobby</td> <td> <select class='edittxt' name=\"hobby1\" id=\"select\">");
                            out.println("   <option value=''>Select Hobbies</option>");
                            if (h1.equals("Internet Surfing")) {
                                out.println("<option value='Internet Surfing' selected='selected'>Internet Surfing</option>");
                            } else {
                                out.println("<option value='Internet Surfing'>Internet Surfing</option>");
                            }
                            if (h1.equals("Video Games")) {
                                out.println("    <option value='Video Games' selected='selected'>Video Games</option>");
                            } else {
                                out.println("    <option value='Video Games'>Video Games</option>");
                            }
                            if (h1.equals("Reading")) {
                                out.println("    <option value='Reading' selected='selected'>Reading</option>");
                            } else {
                                out.println("    <option value='Reading'>Reading</option>");
                            }
                            if (h1.equals("Swimming")) {
                                out.println("    <option value='Swimming' selected='selected'>Swimming</option>");
                            } else {
                                out.println("    <option value='Swimming'>Swimming</option>");
                            }
                            if (h1.equals("Coocking")) {
                                out.println("    <option value='Coocking' selected='selected'>Cooking</option>");
                            } else {
                                out.println("    <option value='Coocking'>Cooking</option>");
                            }
                            if (h1.equals("Fashion")) {
                                out.println("    <option value='Fashion' selected='selected'>Fashion</option>");
                            } else {
                                out.println("    <option value='Fashion'>Fashion</option>");
                            }
                            if (h1.equals("other")) {
                                out.println("    <option value='other' selected='selected'>Other</option>");
                            } else {
                                out.println("    <option value='other'>Other</option>");
                            }
                            out.println("  </select></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>2nd Hobby</td> <td> <select class='edittxt' name=\"hobby2\" id=\"select\">");
                            out.println("   <option value=''>Select Hobbies</option>");
                            if (h2.equals("Internet Surfing")) {
                                out.println("<option value='Internet Surfing' selected='selected'>Internet Surfing</option>");
                            } else {
                                out.println("<option value='Internet Surfing'>Internet Surfing</option>");
                            }
                            if (h2.equals("Video Games")) {
                                out.println("    <option value='Video Games' selected='selected'>Video Games</option>");
                            } else {
                                out.println("    <option value='Video Games'>Video Games</option>");
                            }
                            if (h2.equals("Reading")) {
                                out.println("    <option value='Reading' selected='selected'>Reading</option>");
                            } else {
                                out.println("    <option value='Reading'>Reading</option>");
                            }
                            if (h2.equals("Swimming")) {
                                out.println("    <option value='Swimming' selected='selected'>Swimming</option>");
                            } else {
                                out.println("    <option value='Swimming'>Swimming</option>");
                            }
                            if (h2.equals("Coocking")) {
                                out.println("    <option value='Coocking' selected='selected'>Cooking</option>");
                            } else {
                                out.println("    <option value='Coocking'>Cooking</option>");
                            }
                            if (h2.equals("Fashion")) {
                                out.println("    <option value='Fashion' selected='selected'>Fashion</option>");
                            } else {
                                out.println("    <option value='Fashion'>Fashion</option>");
                            }
                            if (h2.equals("other")) {
                                out.println("    <option value='other' selected='selected'>Other</option>");
                            } else {
                                out.println("    <option value='other'>Other</option>");
                            }
                            out.println("  </select></td>");
                            out.println("</tr>");
                            out.println("<tr>");

                            out.println("<td class='text'>3rd Hobby </td> <td><select class='edittxt' name=\"hobby3\" id=\"select\">");
                            out.println("    <option value=''>Select Hobbies</option>");
                            if (h3.equals("Internet Surfing")) {
                                out.println("<option value='Internet Surfing' selected='selected'>Internet Surfing</option>");
                            } else {
                                out.println("<option value='Internet Surfing'>Internet Surfing</option>");
                            }
                            if (h3.equals("Video Games")) {
                                out.println("    <option value='Video Games' selected='selected'>Video Games</option>");
                            } else {
                                out.println("    <option value='Video Games'>Video Games</option>");
                            }
                            if (h3.equals("Reading")) {
                                out.println("    <option value='Reading' selected='selected'>Reading</option>");
                            } else {
                                out.println("    <option value='Reading'>Reading</option>");
                            }
                            if (h3.equals("Swimming")) {
                                out.println("    <option value='Swimming' selected='selected'>Swimming</option>");
                            } else {
                                out.println("    <option value='Swimming'>Swimming</option>");
                            }
                            if (h3.equals("Coocking")) {
                                out.println("    <option value='Coocking' selected='selected'>Cooking</option>");
                            } else {
                                out.println("    <option value='Coocking'>Cooking</option>");
                            }
                            if (h3.equals("Fashion")) {
                                out.println("    <option value='Fashion' selected='selected'>Fashion</option>");
                            } else {
                                out.println("    <option value='Fashion'>Fashion</option>");
                            }
                            if (h3.equals("other")) {
                                out.println("    <option value='other' selected='selected'>Other</option>");
                            } else {
                                out.println("    <option value='other'>Other</option>");
                            }
                            out.println("  </select></td>");
                            out.println("</tr>");
                            out.println("<tr>");

                            out.println("<td class='text'>4th Hobby</td><td>  <select class='edittxt' name=\"hobby4\" id=\"select\">");
                            out.println("   <option value=''>Select Hobbies</option>");
                            if (h4.equals("Internet Surfing")) {
                                out.println("<option value='Internet Surfing' selected='selected'>Internet Surfing</option>");
                            } else {
                                out.println("<option value='Internet Surfing'>Internet Surfing</option>");
                            }
                            if (h4.equals("Video Games")) {
                                out.println("    <option value='Video Games' selected='selected'>Video Games</option>");
                            } else {
                                out.println("    <option value='Video Games'>Video Games</option>");
                            }
                            if (h4.equals("Reading")) {
                                out.println("    <option value='Reading' selected='selected'>Reading</option>");
                            } else {
                                out.println("    <option value='Reading'>Reading</option>");
                            }
                            if (h4.equals("Swimming")) {
                                out.println("    <option value='Swimming' selected='selected'>Swimming</option>");
                            } else {
                                out.println("    <option value='Swimming'>Swimming</option>");
                            }
                            if (h4.equals("Coocking")) {
                                out.println("    <option value='Coocking' selected='selected'>Cooking</option>");
                            } else {
                                out.println("    <option value='Coocking'>Cooking</option>");
                            }
                            if (h4.equals("Fashion")) {
                                out.println("    <option value='Fashion' selected='selected'>Fashion</option>");
                            } else {
                                out.println("    <option value='Fashion'>Fashion</option>");
                            }
                            if (h4.equals("other")) {
                                out.println("    <option value='other' selected='selected'>Other</option>");
                            } else {
                                out.println("    <option value='other'>Other</option>");
                            }
                            out.println("  </select></td>");
                            out.println("</tr>");
                            out.println("<tr>");
                            out.println("<td class='text'>5th Hobby</td><td> <select class='edittxt' name=\"hobby5\" id=\"select\">");
                            out.println("    <option value=''>Select Hobbies</option>");
                            if (h5.equals("Internet Surfing")) {
                                out.println("<option value='Internet Surfing' selected='selected'>Internet Surfing</option>");
                            } else {
                                out.println("<option value='Internet Surfing'>Internet Surfing</option>");
                            }
                            if (h5.equals("Video Games")) {
                                out.println("    <option value='Video Games' selected='selected'>Video Games</option>");
                            } else {
                                out.println("    <option value='Video Games'>Video Games</option>");
                            }
                            if (h5.equals("Reading")) {
                                out.println("    <option value='Reading' selected='selected'>Reading</option>");
                            } else {
                                out.println("    <option value='Reading'>Reading</option>");
                            }
                            if (h5.equals("Swimming")) {
                                out.println("    <option value='Swimming' selected='selected'>Swimming</option>");
                            } else {
                                out.println("    <option value='Swimming'>Swimming</option>");
                            }
                            if (h5.equals("Coocking")) {
                                out.println("    <option value='Coocking' selected='selected'>Cooking</option>");
                            } else {
                                out.println("    <option value='Coocking'>Cooking</option>");
                            }
                            if (h5.equals("Fashion")) {
                                out.println("    <option value='Fashion' selected='selected'>Fashion</option>");
                            } else {
                                out.println("    <option value='Fashion'>Fashion</option>");
                            }
                            if (h5.equals("other")) {
                                out.println("    <option value='other' selected='selected'>Other</option>");
                            } else {
                                out.println("    <option value='other'>Other</option>");
                            }
                            out.println("  </select></td>");
                            out.println("</tr>");

                            out.println("</table>");

                            out.println("<input type='submit' value='Save Changes' class='btn'>");
                            out.println("</form>");
                        %>
                    </div>
                </div>

                <div id="sidebar">
                    <h1>Advertisement</h1>
                    <%
                        //Randomly Images Selected  by Advertisement.....
                        try {
                            // Random random = new Random();
                            //int r = random.nextInt(100);

                            ArrayList<String> hobbies = new ArrayList<String>();
                            hobbies.add(h1);
                            hobbies.add(h2);
                            hobbies.add(h3);
                            hobbies.add(h4);
                            hobbies.add(h5);
                            hobbies.add(gender);
                            rs = db.Select("select * from items order by rand() limit 10");
                            out.println("<div class='slider' id='main-slider'>");
                            out.println("<div class='slider-wrapper'>");
                            while (rs.next()) {
                                int count = 0;
                                String tags = rs.getString("tags");
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
                                    dp = rs.getString("name");
                                    int id = rs.getInt("id");
                                    String price = rs.getString("price");
                                    String dprice = rs.getString("dprice");
                                    String path = rs.getString("Path");
                                    String name = rs.getString("name");

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
                </div>
            </div>
        </div>
        <div id="footer">
            <div>
                <p>
                    ©Copyright. All rights reserved.
                </p>
            </div>
        </div>
    </body>
</html>
