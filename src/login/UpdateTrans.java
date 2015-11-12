package login;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Date;

public class UpdateTrans {
	
	String accNo;
	String accType;
	String transType;
	String amount;
	String custID;
	Connection con =null;
	
	UpdateTrans(Connection con, String No, String Type, String transType, String balance,String custID){
		
		this.accNo = No;
		this.accType = Type;
		this.transType = transType;
		this.amount = balance;
		this.custID = custID;
	}
	
	void updateTransValues(){
		
		try{
			
			 //loading drivers for mysql
		        Class.forName("com.mysql.jdbc.Driver");

			 //creating connection with the database 
		        Connection con=DriverManager.getConnection
		                       ("jdbc:mysql://localhost:3306/bank","root","password123");
			  
		    PreparedStatement state1=con.prepareStatement("INSERT INTO TRANS VALUES(?,?,?,?,?,?)");   
		    state1.setString(1,accNo);
		    state1.setString(2,accType);
		    state1.setString(3,new java.text.SimpleDateFormat("yyyy:mm:dd hh:mm:ss").format(new Date()));
		    state1.setString(4,transType);
		    state1.setString(5,amount);
		    state1.setString(6,custID);
		    
		    state1.executeUpdate();	
		    state1.close();
		    
		    con.close();
		  
	}catch(Exception e)
	{
		System.out.println("Failed here update amount --------->");
		e.printStackTrace();
	}
		
	}

}