package action;
import connection.DB;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import java.util.Date;
/**
 *
 * @author sluser
 */
public class PostMessage extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession hs = request.getSession(true);
        
        try {
            DB Db = new DB();
            String plan = request.getParameter("plan");
            System.out.println("Plan Type " + plan);
            String saveFile = "", fn = "", ln = "";
            String email = "";
            String dp="",message="";
            int fileidnum = 0, downloadcount = 0;
            
            
            email=hs.getAttribute("email").toString();
            hs.setAttribute("email",email);
            String contentType = request.getContentType();
            // Create a factory for disk-based file items
            DiskFileItemFactory factory = new DiskFileItemFactory();

// Set factory constraints
            factory.setSizeThreshold(4012);
//factory.setRepository("c:");

// Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);

// Set overall request size constraint
            //upload.setSizeMax(10024);

// Parse the request
            List items = null;
            try {
                items = upload.parseRequest(request);
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
            byte[] data = null;
            String fileName = null;
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (item.isFormField()) {
                    //processFormField(item);

                    String name = item.getFieldName();
                    String value = item.getString();

                    if (name.equalsIgnoreCase("message")) {
                        message = value;
                        System.out.println("Message " +message);
                    }  
                     } 
                else {
                        data = item.get();
                        fileName = item.getName();
                    }
                }


                saveFile = fileName;
                        dp="post/"+saveFile;
                        System.out.println("dp " + dp);
                String path = request.getSession().getServletContext().getRealPath("/");
                path=path.replaceAll("build", "");
                path=path+"post/";
                System.out.println(path);
                try
                {
                File ff = new File(path+ saveFile);
                FileOutputStream fileOut = new FileOutputStream(ff);
                fileOut.write(data, 0, data.length);
                fileOut.flush();
                fileOut.close();
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
                System.out.println(path + saveFile);
                System.out.println("Thrid");
                Connection con = null;
                PreparedStatement psmnt = null;
                FileInputStream fis;
                InputStream sImage;
                System.out.println("Thrid1");
            
            
                DB db=new DB();
                
                DB db1=new DB();
                String qqq="Select fname,lname from user where email='"+email+"'";
                ResultSet rs=db1.Select(qqq);

                rs.next();
                fn=rs.getString("fname");
                ln=rs.getString("lname");
                
                           System.out.println("Thrid2");
                           
            Date myDate = new Date();
        String d = new SimpleDateFormat("MM-dd-yyyy").format(myDate);
                           String q="insert into post values('"+fn+"','"+ln+"','"+d+"','"+dp+"','"+message+"','"+email+"',0)";
            int rows=db.Insert(q);
            if(rows>0)
            {                
                out.println("done");
                response.sendRedirect("Post.jsp?message='success'");
            }
            else
            {
                out.println("Error");
                response.sendRedirect("Post.jsp?message='failed'");
            }
            }
         finally {

            out.close();
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreatecardCheck.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreatecardCheck.class.getName()).log(Level.SEVERE, null, ex);
        }
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
