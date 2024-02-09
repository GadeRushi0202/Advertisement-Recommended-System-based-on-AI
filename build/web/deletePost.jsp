<%-- 
    Document   : deletePost
    Created on : 2 Apr, 2018, 4:24:56 PM
    Author     : shri
--%>

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
            HttpSession hs = request.getSession();
            String email = hs.getAttribute("email").toString();
            if (email == null) {
                response.sendRedirect("login.jsp?message='expired'");
            }
            hs.setAttribute("email", email);
            String id = request.getQueryString();
            DB db = new DB();
            String sql = "DELETE FROM post WHERE id='" + id + "' AND email='" + email + "'";
            int r = db.Delete(sql);
            if (r > 0) {
                hs.setAttribute("username", email);           //create session
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Post is deleted!');");
                out.println("location='posts.jsp';");
                out.println("</script>");
            } else {
                hs.setAttribute("username", email);           //create session
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Post not found!');");
                out.println("location='posts.jsp';");
                out.println("</script>");
            }
        %>
    </body>
</html>
