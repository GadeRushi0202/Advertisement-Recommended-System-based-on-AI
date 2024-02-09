/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pack;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
/**
 *
 * @author Dell
 */
public class DBConnection {
   public Connection con;
   public Statement st;
    public DBConnection()
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con= DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinepayment", "root", "");
            st=con.createStatement();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}
