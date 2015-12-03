package login;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;

/**
 * Servlet implementation class ReqCreditCard
 */
public class ReqCreditCard extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
	DbConnection dbcon;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReqCreditCard() {
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

        HttpSession ses = request.getSession();
        query = new Query();
        String custID = String.valueOf(ses.getAttribute("custID"));
        String option = request.getParameter("buttonVal");
				
		System.out.println("currentUser :"+ses.getAttribute("currentUser"));
		System.out.println("custID :"+ses.getAttribute("custID"));

		if(option.equalsIgnoreCase("req"))
		{
			try
			{
				System.out.println("Came here ------------>1");
			dbcon = new DbConnection();
			PreparedStatement state=dbcon.getConnect().prepareStatement("SELECT * FROM CREDITCARDREQ WHERE cust_ID=?");
			state.setString(1,custID);
			ResultSet result=state.executeQuery();
			
			if(result.next()){
				System.out.println("Came here ------------>2");
				ses.setAttribute("creditcardStatus", "Credit Card Application is already Sent for Bank Approval");
		        response.sendRedirect("resultCredit.jsp");
			}else
			{
			 try{
				 
				 query.reqCreditCard(String.valueOf(ses.getAttribute("custID")), String.valueOf(ses.getAttribute("currentUser")));
				 ses.setAttribute("creditcardStatus", "Credit Card Application is sent for Bank Approval");
			     response.sendRedirect("resultCredit.jsp");
			 }catch(Exception e)
			 {
				 System.out.println(e.getMessage());
				 e.printStackTrace();

			 }
			}
			}catch(Exception e)
			{
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
			
			 
			 try{
					
					String email = "";
					String lname = "";
					dbcon = new DbConnection();
					PreparedStatement state1=dbcon.getConnect().prepareStatement("SELECT * FROM account_details WHERE "+"cust_ID="+ses.getAttribute("custID"));
					ResultSet result1=state1.executeQuery();
					
					while(result1.next()){
						
					      email=result1.getString("EMAIL");
					      lname=result1.getString("LAST_NAME");
					}
					
					state1.close();
					
					MailNotification mail = new MailNotification(email);
				    
				    String text = "Hello "+ lname + 
					    		      "\n\n Application for Credit card is done for your account"+
					    		      "\n\n Customer ID : "+custID+
					    		      "\n\n Note : Please do not reply to this E-Mail Notification";
					    
					mail.sendMail( "Credit Card Request", text);
					dbcon.clsConnect();
					
				}catch(Exception e){
					e.printStackTrace();
					System.out.println(" -----------> Failed in Mail notification --------");
				}
		}else
		{
			String type = request.getParameter("accOption");
		    String accNo = request.getParameter("accOption").substring(6);
		    String existingAmount = request.getParameter("intbalance"); //debt amount
		    String payAmount = request.getParameter("payamt"); // entered amount
		    String crebalance = request.getParameter("crebalance");
		    String AccountType; 
		    
		    System.out.println("+++++++ debt amount +++"+existingAmount);
		    System.out.println("+++++++ amount entered +++"+payAmount);
		    
		    
		    if(type.startsWith("'sav'"))
			{
				AccountType = "Savings";
			}else
			{
				AccountType = "Chequeing";
			}
		    
		    String balance = query.getBalance(type,accNo);
		    System.out.println("+++++++ balance amount in account +++"+balance);
		    
		    try{
		    	   if(Double.parseDouble(existingAmount) <= 0)
		    	   {
		    		   ses.setAttribute("creditcardStatus", "Debt Amount Should be greather than Zero");
				       response.sendRedirect("resultCredit.jsp");
		    	   }else if(Double.parseDouble(existingAmount) < Double.parseDouble(payAmount))
		    	   {
		    		   ses.setAttribute("creditcardStatus", "Pay Amount is higher than the Credit Card Debit");
				       response.sendRedirect("resultCredit.jsp");
		    	   }else if(Double.parseDouble(balance) < Double.parseDouble(payAmount))
		    	   {
		    	
		              ses.setAttribute("creditcardStatus", "Credit Card Debit cannot be paid due to insufficient balance");
				       response.sendRedirect("resultCredit.jsp");
				       
		           }else
		           {
			           Double bal = Double.parseDouble(balance)-Double.parseDouble(payAmount);
			           Double debt = Double.parseDouble(existingAmount)-Double.parseDouble(payAmount);
			           Double credit = Double.parseDouble(crebalance)+Double.parseDouble(payAmount);
			           System.out.println("----------> debt ---------->"+debt);
			           System.out.println("----------> credit ---------->"+credit);
			           
			           query.DetectAcc(AccountType,bal,String.valueOf(ses.getAttribute("currentUser")));
			           query.UpdateCreCard(credit,debt,String.valueOf(ses.getAttribute("currentUser")));
			           query.updateTransValues(accNo, AccountType, "Credit card bill Paid", existingAmount, String.valueOf(ses.getAttribute("custID")));
			           
			           ses.setAttribute("creditcardStatus", "Credit Card Debit is successfully Paid");
				       response.sendRedirect("resultCredit.jsp");
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
						    		      "\n\n Credit card debt is paid from"+
						    		      "\n\n Account : "+AccountType+
						    		      "\n Number : "+accNo+
						    		      "\n Withdraw Amount : "+existingAmount+
						    		      "\n\n Note : Please do not reply to this E-Mail Notification";
						    
						mail.sendMail( "Credit card Payment", text);
						dbcon.clsConnect();
						
					}catch(Exception e){
						e.printStackTrace();
						System.out.println(" -----------> Failed in Mail notification --------");
					}
		          
			}
			catch(Exception e)
			{ 
				ses.setAttribute("creditcardStatus", "Amount Withdraw Failure \n Please Try again");
		        response.sendRedirect("resultCredit.jsp");
		       	e.printStackTrace();
			}
		}		
		
	}

}
