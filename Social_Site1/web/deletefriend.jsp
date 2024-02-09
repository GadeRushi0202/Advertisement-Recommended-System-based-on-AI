<%-- 
    Document   : deletefriend
    Created on : 9 Feb, 2018, 4:15:07 PM
    Author     : shri
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete friend</title>
    </head>
    <body>
        <%
            HttpSession hs = request.getSession();
            String email = hs.getAttribute("email").toString();
            if (email == null) {
                response.sendRedirect("login.jsp?message='expired'");
            }
            hs.setAttribute("email", email);
            String str = "";
            str = request.getQueryString();
            String sql = "Select * from friends where user1='" + email + "' and user2='" + str + "'";
            String sql1 = "Select * from friends where user1='" + str + "' and user2='" + email + "'";
            DB db = new DB();
            DB db1 = new DB();
            ResultSet rs = db.Select(sql);
            ResultSet rs1 = db1.Select(sql1);
            if (rs.next()) {
                String qry = "Delete from friends  where user1='" + email + "'and user2='" + str + "'";
                int r = db.Update(qry);
                hs.setAttribute("email", email);           //create session
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Friend is deleted!');");
                out.println("location='friendlist.jsp';");
                out.println("</script>");

            } else if (rs1.next()) {
                String qry = "Delete from friends  where user1='" + str + "'and user2='" + email + "'";
                int r = db.Update(qry);
                hs.setAttribute("email", email);           //create session
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Friend is deleted!');");
                out.println("location='friendlist.jsp';");
                out.println("</script>");
            }else{
                hs.setAttribute("email", email);           //create session
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Friend is not found!');");
                out.println("location='friendlist.jsp';");
                out.println("</script>");
            }
        %>
    </body>
</html>
