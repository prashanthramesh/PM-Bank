package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;

import java.sql.*;

/**
 * Servlet implementation class CashDeposit
 */
public class CashDeposit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CashDeposit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DbConnection dbcon;
HttpSession ses = request.getSession();
		
		String accType = request.getParameter("accType");
		String accNo = request.getParameter("accno");
		String balance = request.getParameter("balance");
		String deposit = request.getParameter("depamt");
		
		System.out.println("accType :"+accType);
		System.out.println("balance :"+balance);
		System.out.println("deposit :"+deposit);
		
		 try{

  			 //loading drivers for mysql
  		        Class.forName("com.mysql.jdbc.Driver");

  			 //creating connection with the database 
  		        Connection con=DriverManager.getConnection
  		                       ("jdbc:mysql://localhost:3306/bank","root","password123");
  		      Double bal = Double.parseDouble(balance)+Double.parseDouble(deposit);
	           System.out.println("----------> amount ---------->"+bal);
	           UpdateAcc(con,accType,accNo,bal,ses);
	           
	           ses.setAttribute("cashresult", "Amount Successfully Deposited");
		       response.sendRedirect("passDeposit.jsp");
	          
	          
  		     }catch(Exception e)
  		     {
  		         e.printStackTrace();
  		     }
  	  
		 try{
			 Connection con=DriverManager.getConnection
                       ("jdbc:mysql://localhost:3306/bank","root","password123");	
			 UpdateTrans trans = new UpdateTrans(con,accNo,accType,"Deposit",deposit,String.valueOf(ses.getAttribute("currentID")));
			 trans.updateTransValues();
			 
		}catch(Exception e)
		{
			e.printStackTrace();
			System.out.println(" -----------> Failed in updation trans --------");
		}
		 
		 try{
				
				String email = "";
				String lname = "";
				 Connection con=DriverManager.getConnection
	            ("jdbc:mysql://localhost:3306/bank","root","password123");
				PreparedStatement state=con.prepareStatement("SELECT * FROM account_details WHERE "+"cust_ID="+ses.getAttribute("currentUser"));
				ResultSet result=state.executeQuery();
				
				while(result.next()){
					
				      email=result.getString("EMAIL");
				      lname=result.getString("LAST_NAME");
				}
				
				state.close();
				
				MailNotification mail = new MailNotification(email);
			    
			    String text = "Hello "+ lname + 
				    		      "\n\n Deposit transaction is been performed in your"+
				    		      "\n\n Account : "+accType+
				    		      "\n Number : "+accNo+
				    		      "\n Deposit Amount : "+deposit+
				    		      "\n\n Note : Please do not reply to this E-Mail Notification";
				    
				mail.sendMail( "Cash Deposited", text);
				con.close();
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println(" -----------> Failed in Mail notification --------");
			}
		doGet(request, response);
	}

	private void UpdateAcc(Connection con, String accType, String accNo, Double bal, HttpSession ses) {
		// TODO Auto-generated method stub
		try{
			PreparedStatement state;
			
			  if(accType.equals("Savings")){				  
				  state=con.prepareStatement( "UPDATE SAVACC SET intialVal=? WHERE "+"custID="+ses.getAttribute("currentUser"));            
			  }else
			  {				  
				   state=con.prepareStatement( "UPDATE CHCKACC SET intialVal=? WHERE "+"custID="+ses.getAttribute("currentUser"));	           
			  }
			  
			state.setString(1,String.valueOf(bal));
	   	    state.executeUpdate();
	   	    state.close();
	  		
			
		}catch(Exception e)
		{
			System.out.println("Failed here update amount --------->");
			e.printStackTrace();
		}
		
	}
	}


