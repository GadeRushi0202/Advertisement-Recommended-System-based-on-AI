<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession();
    String email = hs.getAttribute("email").toString();
    if (email == null) {
        response.sendRedirect("login.jsp?message='expired'");
    }
    hs.setAttribute("email", email);
    String str = "";
    DB db = new DB();
    if (request.getQueryString() != null) {
        str = request.getQueryString();
        String qq = "Delete from friendreq where (sender='" + email + "' and receiver='" + str + "') or (sender='" + str + "' and receiver='" + email + "')";
        int rows = db.Delete(qq);
        if (rows > 0) {
            response.sendRedirect("Request.jsp?message='Delete'&name='" + str + "'");
        }
        System.out.println("Request Delete R- " + str + " S- " + email);
    }
%>