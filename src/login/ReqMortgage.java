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
 * Servlet implementation class ReqMortgage
 */
public class ReqMortgage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
	DbConnection dbcon;
	String[] val;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReqMortgage() {
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
		dbcon = new DbConnection();
		String option = request.getParameter("buttonVal");
		
		
		if(option.equalsIgnoreCase("req"))
		{
			String mortamt = request.getParameter("mortamt");
			String mortyr = request.getParameter("mortyr");
			String mortReason = request.getParameter("mortReason");
			
			val = mortyr.split(" ");
			String year = val[0];
			String interest = val[2];
			
			System.out.println("mortamt :"+mortamt);
			System.out.println("mortReason :"+mortReason);

			System.out.println("mortyr :"+mortyr);
			System.out.println("val :"+val[0]);
			System.out.println("option :"+option);
			System.out.println("val :"+val[2]);
			
			try
			{
			dbcon = new DbConnection();
			PreparedStatement state=dbcon.getConnect().prepareStatement("SELECT * FROM mortgagereq WHERE cust_ID=?");
			state.setString(1,String.valueOf(ses.getAttribute("custID")));
			ResultSet result=state.executeQuery();
			
			if(result.next()){
				ses.setAttribute("mortgageStatus", "Mortgage Application is already Sent for Bank Approval");
		        response.sendRedirect("resultMortgage.jsp");
			}else
			{
				try{
			           query.reqMortgage(String.valueOf(ses.getAttribute("custID")),String.valueOf(ses.getAttribute("currentUser")),
			        		   mortamt,interest,year);
			           ses.setAttribute("mortgageStatus", "Mortgage Application is Sent for Bank Approval");
				       response.sendRedirect("resultMortgage.jsp");
			          
			          
				     }catch(Exception e)
				     {
				         ses.setAttribute("mortgageStatus", "Mortgage Application Failed due to "+e.getMessage());
					     response.sendRedirect("resultMortgage.jsp");
				    	 
				    	 e.printStackTrace();
				     }	
			}
			dbcon.clsConnect();
			}catch(Exception e)
			{
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}else
		{
			    String type = request.getParameter("accOption");
			    String accNo = request.getParameter("accOption").substring(6);
			    String existingAmount = request.getParameter("intbalance");
			    String AccountType;
			    
			    if(type.startsWith("'sav'"))
				{
					AccountType = "Savings";
				}else
				{
					AccountType = "Chequeing";
				}
			    
			    String balance = query.getBalance(type,accNo);
			    
			    try{
			           if(Double.parseDouble(balance) < Double.parseDouble(existingAmount))
			           {
			        	   ses.setAttribute("mortgageStatus", "Mortgage Amount cannot be paid due to insufficient balance");
					       response.sendRedirect("resultMortgage.jsp");
					       
			           }else
			           {
				           Double bal = Double.parseDouble(balance)-Double.parseDouble(existingAmount);
				           System.out.println("----------> amount ---------->"+bal);
				           
				           query.DetectAcc(AccountType,bal,String.valueOf(ses.getAttribute("currentUser")));
				           query.dropMortgage(String.valueOf(ses.getAttribute("currentUser")));
				           query.updateTransValues(accNo, AccountType, "Mortgage Paid", existingAmount, String.valueOf(ses.getAttribute("custID")));
				           
				           ses.setAttribute("mortgageStatus", "Amount Successfully Withdrawn from Account and paid for mortgage");
					       response.sendRedirect("resultMortgage.jsp");
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
							    		      "\n\n Mortgage Amount is paid back from"+
							    		      "\n\n Account : "+AccountType+
							    		      "\n Number : "+accNo+
							    		      "\n Withdraw Amount : "+existingAmount+
							    		      "\n\n Note : Please do not reply to this E-Mail Notification";
							    
							mail.sendMail( "Mortgage Payback", text);
							dbcon.clsConnect();
							
						}catch(Exception e){
							e.printStackTrace();
							System.out.println(" -----------> Failed in Mail notification --------");
						}
			          
				}
				catch(Exception e)
				{ 
					ses.setAttribute("mortgageStatus", "Amount Withdraw Failure \n Please Try again");
			        response.sendRedirect("resultMortgage.jsp");
			       	e.printStackTrace();
				}
			
		}
				
	}

}
