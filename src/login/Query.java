package login;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;

public class Query
{
  DbConnection dbcon;
  OnlineUser onUser;
  NewUser newUser;
  String customerId;
  String customerName;
	
    public boolean checkUser(String fname, String password) 
    {
     boolean st =false;
     try{
    	dbcon = new DbConnection();
        PreparedStatement ps =dbcon.getConnect().prepareStatement("select * from Account_details where cust_ID=? and pwd=?");
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
customerId = newUser.createUserID();
	 //creating connection with the database 
        Connection con=DriverManager.getConnection
                       ("jdbc:mysql://localhost:3306/bank","root","password123");
        PreparedStatement state =con.prepareStatement("insert into pending_request set first_name=?,last_name=?,gender=?,dob=?,email=?,phone_no=?");
		    state.setString(1,user.getFirstName());
		    state.setString(2,user.getLastName());
		    state.setString(3,user.getGender());
		    state.setString(4,user.getDob());
		    state.setString(5,user.getEmail());
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
	
	public OnlineUser fetchUserInfoCustID(String cust_ID) {
		try
		{
			dbcon = new DbConnection();
			onUser = new OnlineUser();
			PreparedStatement state = dbcon.getConnect().prepareStatement("SELECT * FROM Account_details WHERE cust_ID=?");
			state.setString(1,cust_ID);
			ResultSet result=state.executeQuery();			
			while(result.next()){				
				onUser.setFirstName(result.getString("first_name"));
				onUser.setLastName(result.getString("last_name"));
				onUser.setGender(result.getString("gender"));
				onUser.setDob(result.getString("dob"));
				onUser.setEmail(result.getString("email"));
				onUser.setPhoneNumber(result.getString("phone_no"));
				onUser.setAddress(result.getString("address"));
				onUser.setCustomerID(result.getString("cust_ID"));
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
	
	public void dropMortgage(String email) {
	       try{
	    	    dbcon = new DbConnection();
				PreparedStatement state=dbcon.getConnect().prepareStatement("DELETE FROM mortgage WHERE email=?");
				state.setString(1,email);
				state.executeUpdate();	
				state.close();
				dbcon.clsConnect();
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
			
		}
	
	public void UpdateAcc(String accType,Double bal, String mail) {
		try{
			System.out.println("Find me here +++");
			System.out.println("new balance +++"+bal);
			dbcon = new DbConnection();
			PreparedStatement state;
			
			  if(accType.equals("Savings")){				  
				  state=dbcon.getConnect().prepareStatement( "UPDATE SAVACC SET intialVal=? WHERE email=?");            
			  }else
			  {				  
				   state=dbcon.getConnect().prepareStatement( "UPDATE CHCKACC SET intialVal=? WHERE email=?");	           
			  }
			  
			state.setString(1,String.valueOf(bal));
			state.setString(2,String.valueOf(mail));			
	   	    state.executeUpdate();
	   	    state.close();
	   	 dbcon.clsConnect();
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	public void UpdateCard(Double billAmt, String mail) {
		try{
			System.out.println("Find me here +++");
			System.out.println("new balance +++"+billAmt);
			dbcon = new DbConnection();
			PreparedStatement state;
						  
		    state=dbcon.getConnect().prepareStatement( "UPDATE creditcard SET DEBIT_AMT=? WHERE email=?");            
			state.setString(1,String.valueOf(billAmt));
			state.setString(2,String.valueOf(mail));			
	   	    state.executeUpdate();
	   	    state.close();
	   	 dbcon.clsConnect();
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

	public void UpdateCreCard(Double creAmt,Double debAmt, String mail) {
		try{
			System.out.println("Find me here +++");
			System.out.println("new balance +++"+creAmt);
			System.out.println("new balance +++"+debAmt);
			dbcon = new DbConnection();
			PreparedStatement state;
						  
		    state=dbcon.getConnect().prepareStatement( "UPDATE creditcard SET CRED_AMT=?,DEBIT_AMT=? WHERE email=?");  
		    state.setString(1,String.valueOf(creAmt));
			state.setString(2,String.valueOf(debAmt));
			state.setString(3,String.valueOf(mail));			
	   	    state.executeUpdate();
	   	    state.close();
	   	 dbcon.clsConnect();
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	public void DetectAcc(String accType, Double bal, String mail) {
		try{
			System.out.println("Find me here +++");
			System.out.println("new balance +++"+bal);
			dbcon = new DbConnection();
			PreparedStatement state;
			System.out.println("Find me here anme +++"+mail);
			  if(accType.equals("Savings")){				  
				  state=dbcon.getConnect().prepareStatement( "UPDATE SAVACC SET intialVal=? WHERE email=?");            
			  }else if(accType.equals("Chequing"))
			  {				  
				   state=dbcon.getConnect().prepareStatement( "UPDATE CHCKACC SET intialVal=? WHERE email=?");	           
			  }else
			  {
				  state=dbcon.getConnect().prepareStatement( "UPDATE creditcard SET CRED_AMT=? WHERE email=?");	      
			  }
			  
			state.setString(1,String.valueOf(bal));
			state.setString(2,String.valueOf(mail));			
	   	    state.executeUpdate();
	   	    state.close();
	   	 dbcon.clsConnect();
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
   public void updateTransValues(String accNo,String accType,String transType,String amount,String custID){
		
		try{
			System.out.println("++++++ custID +++"+custID);
			dbcon = new DbConnection();
			PreparedStatement state1;
			   
		    state1= dbcon.getConnect().prepareStatement("INSERT INTO TRANS VALUES(?,?,?,?,?,?)");   
		    state1.setString(1,accNo);
		    state1.setString(2,accType);
		    state1.setString(3,new java.text.SimpleDateFormat("yyyy:mm:dd hh:mm:ss").format(new Date()));
		    state1.setString(4,transType);
		    state1.setString(5,amount);
		    state1.setString(6,custID);
		    
		    state1.executeUpdate();	
		    state1.close();		    
		    dbcon.clsConnect();
	}catch(Exception e){
		System.out.println("Failed here update amount --------->");
		e.printStackTrace();
	}
   }
   
   public void reqCreditCard(String custID,String email){
		
		try{
			System.out.println("++++++ custID credit card +++"+custID);
			System.out.println("++++++ email credit card +++"+email);
			dbcon = new DbConnection();
			PreparedStatement state1;
			   
		    state1= dbcon.getConnect().prepareStatement("INSERT INTO CREDITCARDREQ VALUES(?,?,?)");   
		    state1.setString(1,email);
		    state1.setString(2,custID);
		    state1.setString(3,new java.text.SimpleDateFormat("yyyy:mm:dd hh:mm:ss").format(new Date()));
		    state1.executeUpdate();	
		    state1.close();		    
		    dbcon.clsConnect();
	}catch(Exception e)
	{
		e.printStackTrace();
	}
  }
	
   public void reqMortgage(String custID,String email,String amount,String interest,String year){
		
		try{
			System.out.println("++++++ custID credit card +++"+custID);
			System.out.println("++++++ email credit card +++"+email);
			dbcon = new DbConnection();
			PreparedStatement state1;
			   
		    state1= dbcon.getConnect().prepareStatement("INSERT INTO mortgagereq VALUES(?,?,?,?,?)");   
		    state1.setString(1,email);
		    state1.setString(2,custID);
		    state1.setString(3,amount);
		    state1.setString(4,interest);
		    state1.setString(5,year);
		    state1.executeUpdate();	
		    state1.close();		    
		    dbcon.clsConnect();
	}catch(Exception e)
	{
		e.printStackTrace();
	}
 }
   
   public String getBalance(String type, String accNo){
	   
	    dbcon = new DbConnection();
	    String Balance = null;
		
		PreparedStatement state;
		ResultSet result;
		
		try
		{
			
			if(type.startsWith("'sav'"))
			{
				state =dbcon.getConnect().prepareStatement("SELECT * FROM savacc WHERE savAcc=?");	
				state.setString(1,accNo);
				result=state.executeQuery();
				
				while(result.next()){			
					Balance=result.getString("intialVal");
				}
			
			}else{

				state =dbcon.getConnect().prepareStatement("SELECT * FROM CHCKACC WHERE chkAcc=?");	
				state.setString(1,accNo);
				result=state.executeQuery();
				
				while(result.next()){			
					Balance=result.getString("intialVal");
				}
				
			}
		 
		  result.close();
		  state.close();
		  dbcon.clsConnect();		  
		  
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return Balance;
   }
	
}



