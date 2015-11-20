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
	Query query;
       
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

		DbConnection dbcon;
        HttpSession ses = request.getSession();
        query = new Query();
		
        String accNo = request.getParameter("accno");
		String accType = request.getParameter("accType");
		String balance = request.getParameter("balance");
		String deposit = request.getParameter("depamt");
		
		System.out.println("accType :"+accType);
		System.out.println("balance :"+balance);
		System.out.println("deposit :"+deposit);
		
		 try{

  		       Double bal = Double.parseDouble(balance)+Double.parseDouble(deposit);
	           query.UpdateAcc(accType,bal,String.valueOf(ses.getAttribute("currentUser")));
	           query.updateTransValues(accNo, accType, "Deposit", deposit, String.valueOf(ses.getAttribute("custID")));
	           
	           ses.setAttribute("cashresult", "Amount Successfully Deposited");
		       response.sendRedirect("passDeposit.jsp");
	          
	          
  		     }catch(Exception e)
  		     {
  		    	 ses.setAttribute("cashresult", "Amount  Deposited Failed due to "+e.getMessage());
  		         response.sendRedirect("passDeposit.jsp");
  		    	 
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
				    		      "\n\n Deposit transaction is been performed in your"+
				    		      "\n\n Account : "+accType+
				    		      "\n Number : "+accNo+
				    		      "\n Deposit Amount : "+deposit+
				    		      "\n\n Note : Please do not reply to this E-Mail Notification";
				    
				mail.sendMail( "Cash Deposited", text);
				dbcon.clsConnect();
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println(" -----------> Failed in Mail notification --------");
			}
	}

}


