package dbConnection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
	
	Connection connect;
	
	public DbConnection()
	{
		try{
			  Class.forName("com.mysql.jdbc.Driver");
			  this.connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root", "password123");
		      System.out.println("DB Connection created here :"+connect);
			}
			catch(Exception e)
			{ 
			e.printStackTrace();
			}
	}

	public Connection getConnect()
	{
		System.out.println("DB Connection got here ");
		return this.connect;
	}
	
	public void clsConnect()
	{
		try {
			this.connect.close();
			 System.out.println("DB Connection closed here ");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}