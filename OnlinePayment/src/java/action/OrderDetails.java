/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pack.DBConnection;

/**
 *
 * @author SCUBETT-1
 */
public class OrderDetails extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
            HttpSession hs = request.getSession(true);
            String orderid = hs.getAttribute("orderid").toString();
            String email = hs.getAttribute("email").toString();
            String id = hs.getAttribute("id").toString();
            String cnt1 = hs.getAttribute("cnt1").toString();
            String price = hs.getAttribute("price").toString();
            String total1 = hs.getAttribute("total1").toString();
            String d1 = hs.getAttribute("d1").toString();

            String cardnumber = request.getParameter("cardnumber");
            String ctype = request.getParameter("cardtype");
            String cvv = request.getParameter("cvv");
            DBConnection db = new DBConnection();

            Statement st = db.con.createStatement();
            String sql = "insert into orders (orderid,email,items,date_,status,amount,itemcount) values('" + orderid + "','" + email + "','" + id + "','" + d1 + "','Received','" + total1 + "','" + cnt1 + "')";
            int i = st.executeUpdate(sql);
            // ResultSet r=st.executeQuery(sql);
            if (i > 0) {
//                String qry = "INSERT INTO bankdetails(emailid,cardtype,cardnumber,cvv) VALUES ('" + email + "','" + ctype + "','" + cardnumber + "','" + cvv + "')";
//                st.executeUpdate(qry);
                String[] mail = new String[]{email};
                String msg = "Your OrderID:\t"+orderid+"\n Item Price:\t"+price+"\n Cardnumber:\t"+cardnumber+"";
                new MailUtil().sendMail(mail, mail, "Your Payment Details", msg);
                response.sendRedirect("payment.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
