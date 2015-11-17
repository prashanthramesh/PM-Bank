package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;
/**
 * Servlet implementation class WithdrawMny
 */
public class WithdrawMny extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WithdrawMny() {
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
		query = new Query();
		
		String accType = request.getParameter("accType");
		String accNo = request.getParameter("accno");
		String balance = request.getParameter("balance");
		String withdraw = request.getParameter("withamt");
		
		System.out.println("accType :"+accType);
		System.out.println("balance :"+balance);
		System.out.println("deposit :"+withdraw);
		
			try{
		           if(Double.parseDouble(balance) < Double.parseDouble(withdraw))
		           {
		        	   ses.setAttribute("withdrawresult", "Withdraw Amount Entered Exceeds Account Balance");
				       response.sendRedirect("passWihdraw.jsp");
				       
		           }else
		           {
			           Double bal = Double.parseDouble(balance)-Double.parseDouble(withdraw);
			           System.out.println("----------> amount ---------->"+bal);
			           
			           query.DetectAcc(accType,bal,String.valueOf(ses.getAttribute("currentUser")));
			           query.updateTransValues(accNo, accType, "Withdraw", withdraw, String.valueOf(ses.getAttribute("custID")));
			           
			           ses.setAttribute("withdrawresult", "Amount Successfully Withdrawn from Account");
				       response.sendRedirect("passWihdraw.jsp");
		           }
		          
			}
			catch(Exception e)
			{ 
				ses.setAttribute("withdrawresult", "Amount Withdraw Failure \n Please Try again");
		        response.sendRedirect("passWihdraw.jsp");
		       	e.printStackTrace();
			}
			
			try{
				
				String email = "";
				String lname = "";
				 dbcon = new DbConnection();
				 PreparedStatement state=dbcon.getConnect().prepareStatement("SELECT * FROM account_details WHERE "+"cust_ID="+ses.getAttribute("custID"));
					ResultSet result=state.executeQuery();
				
				while(result.next()){
					
				      email=result.getString("EMAIL");
				      lname=result.getString("LAST_NAME");
				}
				
				state.close();
				
				MailNotification mail = new MailNotification(email);
			    
			    String text = "Hello "+ lname + 
				    		      "\n\n Withdraw transaction is been performed in your"+
				    		      "\n\n Account : "+accType+
				    		      "\n Number : "+accNo+
				    		      "\n Withdraw Amount : "+withdraw+
				    		      "\n\n Note : Please do not reply to this E-Mail Notification";
				    
				mail.sendMail( "Withdraw", text);
				dbcon.clsConnect();
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println(" -----------> Failed in Mail notification --------");
			}
	}

	/*private void UpdateMnyCard(Connection connect, String withdraw, HttpSession ses) {
		// TODO Auto-generated method stub
		
		try{
			PreparedStatement state;
			 			  
			state=connect.prepareStatement( "UPDATE MNYCARD SET MNYAMT=? WHERE "+"CUSTOMERID="+ses.getAttribute("currentID"));            
			 
			state.setString(1,withdraw);
	   	    state.executeUpdate();
	   	    state.close();
	  		System.out.println("---------> connect value ------"+connect);
			
		}catch(Exception e)
		{
			System.out.println("Failed here update amount --------->");
			e.printStackTrace();
		}
		
	}*/

		
	}
