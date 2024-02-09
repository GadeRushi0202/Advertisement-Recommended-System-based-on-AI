<%-- 
    Document   : Home
    Created on : Dec 15, 2016, 11:51:32 AM
    Author     : Mayur
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
            HttpSession hs = request.getSession();
            String email=hs.getAttribute("email").toString();
            if (email == null) {
                response.sendRedirect("login.jsp?message='expired'");
            }
            hs.setAttribute("email",email);
                String str = "";
                DB db=new DB();
    if (request.getQueryString() != null) {
        str = request.getQueryString();
        Date myDate = new Date();
        System.out.println("Request Accept in process");
        String d = new SimpleDateFormat("MM-dd-yyyy").format(myDate);
        String query="Insert into friends values('"+email+"','"+str+"','"+d+"')";
        int rows = db.Insert(query);
        System.out.println("Request inserted in friend");
        String qq="Delete from friendreq where (sender='"+email+"' and receiver='"+str+"') or (sender='"+str+"' and receiver='"+email+"')";
        int rows1 = db.Delete(qq);
        System.out.println("Request deleted in req table");
        if ((rows==rows1)) {
            response.sendRedirect("Request.jsp?message='Accept'&name='"+str+"'");
        }
        System.out.println("error");
        
        System.out.println("Request Accepted R- " + str + " S- "+email);
    }
            %>