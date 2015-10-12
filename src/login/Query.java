package login;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import dbConnection.DbConnection;

public class Query
{
  DbConnection dbcon;
  OnlineUser onUser;
  NewUser newUser;
	
    public static boolean checkUser(String fname, String password) 
    {
     boolean st =false;
     try{

	 //loading drivers for mysql
        Class.forName("com.mysql.jdbc.Driver");

	 //creating connection with the database 
        Connection con=DriverManager.getConnection
                       ("jdbc:mysql://localhost:3306/bank","root","password123");
        PreparedStatement ps =con.prepareStatement
                            ("select * from Account_details where first_name=? and pwd=?");
        ps.setString(1, fname);
        ps.setString(2, Encryption.encrypt(password));
        ResultSet rs =ps.executeQuery();
        st = rs.next();
        
        
       
     }catch(Exception e)
     {
         e.printStackTrace();
     }
        return st;                 
 }   
   
    
    public boolean registerUser(OnlineUser user){
    	 boolean st =false;
    	 newUser =  new NewUser();
    	try{//loading drivers for mysql
        Class.forName("com.mysql.jdbc.Driver");
String customerId = newUser.createUserID();
	 //creating connection with the database 
        Connection con=DriverManager.getConnection
                       ("jdbc:mysql://localhost:3306/bank","root","password123");
        PreparedStatement state =con.prepareStatement("insert into pending_request set first_name=?,last_name=?,email=?,dob=?,gender=?,phone_no=?");
		    state.setString(1,user.getFirstName());
		    state.setString(2,user.getLastName());
		    state.setString(3,user.getEmail());
		    state.setString(4,user.getDob());
		    state.setString(5,user.getGender());
		    state.setString(6,user.getPhoneNumber());
		    
		    

		    state.executeUpdate();	
		    state.close();
		    
	           
	        		   
		    
		   
			
		}
    
    catch(Exception e){
			System.out.println(e.getMessage());
		}
 return st;   
}
    	  
    	
    	
    
    
    public static boolean newUser(OnlineUser user){
    	int result=0;
  	  try{

  			 //loading drivers for mysql
  		        Class.forName("com.mysql.jdbc.Driver");

  			 //creating connection with the database 
  		        Connection con=DriverManager.getConnection
  		                       ("jdbc:mysql://localhost:3306/bank","root","password123");
  		        PreparedStatement ps =con.prepareStatement
  		                            ("insert into Account_details set first_name=?,last_name=?,phone_no=?,dob=?,email=?,gender=?");
  		        ps.setString(1, user.getFirstName());
  		        ps.setString(2, user.getLastName());
  		        ps.setString(3, user.getPhoneNumber());
  		        ps.setString(4, user.getDob());
  		        ps.setString(5, user.getEmail());
  		        ps.setString(6, user.getGender()); 
  		        
  		        result =ps.executeUpdate();
  		     }catch(Exception e)
  		     {
  		         e.printStackTrace();
  		     }
  	  
  	  if(result==1)
	        	return true;
	        else
	        	return false;   
  	
    }
    
    public void createCheckAcc(OnlineUser userObj) {

		String intialVal = "0";		
		
       try{
			
    	    Calendar cal= Calendar.getInstance(); 
   	        cal.add(Calendar.YEAR, 10);   	    
   	        Date date = cal.getTime();   	        
   	        SimpleDateFormat form = new SimpleDateFormat("MM/dd/yyyy");
   		    String day = form.format(date);
   		    
    	    dbcon = new DbConnection();
			PreparedStatement state = dbcon.getConnect().prepareStatement("INSERT INTO CHCKACC VALUES(?,?,?,?,?,?,?)");
			state.setString(1,userObj.getEmail());
		    state.setString(2,userObj.getCheckAccNo());
		    state.setString(3,intialVal);		    
		    state.setString(4,day);
		    state.setString(5,userObj.getFirstName());
		    state.setString(6,userObj.getLastName());
		    state.setString(7,userObj.getCustomerID());		
			state.executeUpdate();	
			state.close();
			
		}catch(Exception e){
			e.getMessage();
		}
		
	}
    
    public void createSavAcc(OnlineUser userObj) {

		String intialVal = "0";		
		
       try{
			
    	    Calendar cal= Calendar.getInstance(); 
   	        cal.add(Calendar.YEAR, 10);   	    
   	        Date date = cal.getTime();   	        
   	        SimpleDateFormat form = new SimpleDateFormat("MM/dd/yyyy");
   		    String day = form.format(date);
   		    
    	    dbcon = new DbConnection();
			PreparedStatement state = dbcon.getConnect().prepareStatement("INSERT INTO SAVACC VALUES(?,?,?,?,?,?,?)");
			state.setString(1,userObj.getEmail());
		    state.setString(2,userObj.getSavAccNo());
		    state.setString(3,intialVal);		    
		    state.setString(4,day);
		    state.setString(5,userObj.getFirstName());
		    state.setString(6,userObj.getLastName());
		    state.setString(7,userObj.getCustomerID());		
			state.executeUpdate();	
			state.close();
			
		}catch(Exception e){
			e.getMessage();
		}
		
	}
    
    public void createMnyCard(OnlineUser userObj) {

		String intialVal = "0";		
		
       try{
    	    dbcon = new DbConnection();
			PreparedStatement state = dbcon.getConnect().prepareStatement("INSERT INTO MNYCARD VALUES(?,?,?,?)");
			state.setString(1,userObj.getEmail());
		    state.setString(2,userObj.getCustomerID());
		    state.setString(3,userObj.getMnyCard());
		    state.setString(4,intialVal);		   		
			state.executeUpdate();	
			state.close();
			
		}catch(Exception e){
			e.getMessage();
		}
		
	}

    
    public boolean forgotUser(OnlineUser user){
    	  try{
    				dbcon = new DbConnection();
    				System.out.println("email here++++++++++"+user.getEmail());
    				PreparedStatement state = dbcon.getConnect().prepareStatement("SELECT * FROM Account_details WHERE email=?");
    				state.setString(1,user.getEmail());
    				ResultSet result = state.executeQuery();    		       
    		        if (!result.next())
    		        {
    		        	System.out.println("wrong data");
    		        	return false;
    		        }
    		        else
    		        { 
    		        	System.out.println("pwd should be updated");
    		        	if(result.getString("last_name").equalsIgnoreCase(user.getLastName()) &&
    		        		result.getString("dob").equalsIgnoreCase(user.getDob())	)
    		        	{		
    		        	return true;
    		        	}
    		        	else
    		        	{
    		            return false;
    		        	}    		            
    		        }		        
    		            		        
    		     }catch(Exception e)
    		     {
    		         e.printStackTrace();
    		         return false;
    		     }		    	
    }
    
    public void updateForgotUser(OnlineUser user){
  	  try{
  		
  				dbcon = new DbConnection();
  				PreparedStatement state = dbcon.getConnect().prepareStatement("UPDATE Account_details SET pwd=? WHERE email=?");
  				state.setString(1,Encryption.encrypt(user.getPassword()));
  				state.setString(2,user.getEmail());
  				state.executeUpdate();	
  		        state.close();
  		        dbcon.clsConnect();
  		     }catch(Exception e)
  		     {
  		         e.printStackTrace();
  		     }		    	
  }


	public OnlineUser fetchUserInfo(String email) {
		try
		{
			dbcon = new DbConnection();
			onUser = new OnlineUser();
			PreparedStatement state = dbcon.getConnect().prepareStatement("SELECT * FROM pending_request WHERE email=?");
			state.setString(1,email);
			ResultSet result=state.executeQuery();			
			while(result.next()){				
				onUser.setFirstName(result.getString("first_name"));
				onUser.setLastName(result.getString("last_name"));
				onUser.setGender(result.getString("gender"));
				onUser.setDob(result.getString("dob"));
				onUser.setEmail(result.getString("email"));
				onUser.setPhoneNumber(result.getString("phone_no"));
				onUser.setAddress("");	
			}
			state.close();
			dbcon.clsConnect();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return onUser;
	}


	public void createNewUser(OnlineUser userObj) {
		try
		{
			dbcon = new DbConnection();
			PreparedStatement state = dbcon.getConnect().prepareStatement("INSERT INTO Account_details VALUES(?,?,?,?,?,?,?,?,?)");
		    state.setString(1,userObj.getFirstName());
		    state.setString(2,userObj.getLastName());
		    state.setString(3,userObj.getEmail());
		    state.setString(4,userObj.getDob());
		    state.setString(5,userObj.getGender());
		    state.setString(6,userObj.getPhoneNumber());
		    state.setString(7,Encryption.encrypt(userObj.getPassword()));
		    state.setString(8,userObj.getCustomerID());
		    state.setString(9,userObj.getAddress());

		    state.executeUpdate();	
		    state.close();
			dbcon.clsConnect();
MailNotification mail = new MailNotification(userObj.getEmail());
		    
		    String text = "Welcome "+userObj.getFirstName()+ 
		    		      "\n\n Please find your login credenials below for accessing PM "+
		    		      "\n\n CustomerID : "+userObj.getCustomerID()+
		    		      "\n Password : "+userObj.getPassword()+
		    		      "\n\n Note : Please do not reply to this E-Mail Notification";
		    
		    mail.sendMail( "Login Credentials", text);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
	}


	public void dropUserReq(String email) {
       try{
    	    dbcon = new DbConnection();
			PreparedStatement state=dbcon.getConnect().prepareStatement("DELETE FROM pending_request WHERE email=?");
			state.setString(1,email);
			state.executeUpdate();	
			state.close();
			dbcon.clsConnect();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
	}
}



