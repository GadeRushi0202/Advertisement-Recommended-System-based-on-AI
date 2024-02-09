/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import connection.DB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dell
 */
public class DislikePage extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession user = request.getSession(true);
            String email = "";
            String total = "0.00";
            String count = "0";
            String id = "";
            String d = "";
            id = request.getQueryString();
            if (user.getAttribute("email") == null) {
                user.setAttribute("login", "failed");
                response.sendRedirect("index.jsp");
            } else {

                email = user.getAttribute("email").toString();
                d = user.getAttribute("d").toString();
            }
            DB db = new DB();
            Connection con = null;

            String like = "like";
            String unlike = "unlike";
            String status = "";
            String query = "Select * from postlike where email='" + email + "' and id='" + id + "'";
            ResultSet rs = db.Select(query);
            if (rs.next()) {
                status = rs.getString("status_");


                String s3 = "update postlike set status_='" + unlike + "' where email='" + email + "' and id='" + id + "'";
                PreparedStatement ps = db.con.prepareStatement(s3);
                int i = ps.executeUpdate();
                if (i > 0) {
                    response.sendRedirect(d);
                }

            } else {
                String sql = "insert postlike values('" + email + "','" + like + "','" + id + "')";
                PreparedStatement ps = db.con.prepareStatement(sql);
                int i = ps.executeUpdate();
                if (i > 0) {
                    response.sendRedirect(d);
                }
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
