/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import connection.DB;
import java.util.ArrayList;
import java.sql.ResultSet;

/**
 *
 * @author Dell
 */
public class KMeans {

    String username;

    public KMeans(String username) {
        this.username = username;
    }

    public ArrayList getId() {
        try {
            ArrayList id = new ArrayList();
            DB db = new DB();
            DB db1 = new DB();
            String sql = "select * from post where email='" + this.username + "'";
            ResultSet rs = db.Select(sql);
            if (rs.next()) {
                rs.last();
                String post = rs.getString("message").trim();
                if (post.contains(" ")) {
                    String str[] = post.split(" ");
                    ResultSet rs1 = db1.Select("select * from items");
                    while (rs1.next()) {
                        int count = 0;
                        String str1[] = rs1.getString("description").split(" ");
                        for (int i = 0; i < str.length; i++) {
                            for (int j = 0; j < str1.length; j++) {
                                if (str[i].equals(str1[j])) {
                                    count++;
                                }
                            }
                        }
                        if (count > 1) {
                            id.add(rs1.getString("id"));
                        }
                    }
                } else {
                    ResultSet rs1 = db1.Select("select * from items");
                    while (rs1.next()) {
                        int count = 0;
                        String str1[] = rs1.getString("description").split(" ");

                        for (int j = 0; j < str1.length; j++) {
                            if (post.equals(str1[j])) {
                                count++;
                            }

                        }
                        if (count > 1) {
                            id.add(rs1.getString("id"));
                        }
                    }
                }
            }
            return id;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
