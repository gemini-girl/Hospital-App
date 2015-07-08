package hospitalApp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class dbConn {
	Connection c;
	Statement s;
	ResultSet r;
	
	public void connect(){
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			c=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "one", "two");
			s = c.createStatement();
			r = s.executeQuery("select * from login");
			while(r.next()){
				System.out.println(r.getString("username") +" "+ r.getString("password"));
			}
			} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) throws SQLException {
		dbConn db = new dbConn();
		db.connect();
		}
}
