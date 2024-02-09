<%-- 
    Document   : edit
    Created on : 8 Feb, 2018, 5:23:23 PM
    Author     : shri
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession httpSession = request.getSession(false);
            try {
                if (httpSession.getAttribute("username") == null) {
                    response.sendRedirect("index.html?message='expired'");
                }
            } catch (Exception e) {
                response.sendRedirect("index.html?message='expired'");
            }
            String username = httpSession.getAttribute("username").toString();
            httpSession.setAttribute("username", username);
            String email = request.getParameter("id");
            DB db = new DB();
            String sql = "Select * from user where email='" + email + "'";
            ResultSet rs = db.Select(sql);
            if (rs.next()) {
                String status = rs.getString("status");
                if (status.equals("1")) {
                    String str = "Update user set status='0' where email='" + email + "'";
                    int r = db.Update(str);
                    httpSession.setAttribute("username", username);           //create session
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('User is Blocked!');");
                    out.println("location='showUser.jsp';");
                    out.println("</script>");
                }
                if (status.equals("0")) {
                    String str = "Update user set status='1' where email='" + email + "'";
                    int r = db.Update(str);
                    httpSession.setAttribute("username", username);           //create session
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('User is Active!');");
                    out.println("location='showUser.jsp';");
                    out.println("</script>");
                }
            }
        %>
    </body>
</html>
