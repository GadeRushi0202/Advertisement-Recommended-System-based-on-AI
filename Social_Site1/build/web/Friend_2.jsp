<%-- 
    Document   : Friend_2
    Created on : Dec 20, 2016, 12:51:55 PM
    Author     : Mayur
--%>

<%@page import="connection.DB"%>
<%
    DB db = new DB();
    HttpSession hs = request.getSession();
    String email = hs.getAttribute("email").toString();
    if (email == null) {
        response.sendRedirect("login.jsp?message='expired'");
    }
    String str = "";
    if (request.getQueryString() != null) {
        str = request.getQueryString();
        String sql = "insert into friendreq(sender,receiver,status) values('" + email + "','" + str + "','pending')";
        int rows = db.Insert(sql);
        if (rows > 0) {
            hs.setAttribute("email", email);           //create session
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Friend request send!');");
            out.println("location='Friend.jsp';");
            out.println("</script>");
        } else {
            hs.setAttribute("email", email);           //create session
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Friend request cannot send!');");
            out.println("location='Friend_1.jsp';");
            out.println("</script>");
        }
    }
%>
