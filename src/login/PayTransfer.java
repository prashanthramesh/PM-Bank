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
 * Servlet implementation class PayTransfer
 */
public class PayTransfer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
	DbConnection dbcon;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayTransfer() {
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
		
		String accType = request.getParameter("accType");
		String accNo = request.getParameter("accno");
		String balance = request.getParameter("balAmt");
		String billAmt = request.getParameter("billAmt");
		String billaccNo = request.getParameter("BilaccNo");
		String service = request.getParameter("serOption");
		String billType = request.getParameter("payType");
		
		
		System.out.println("accType :"+accType);
		System.out.println("balance :"+balance);
		System.out.println("billAmt :"+billAmt);
		System.out.println("service :"+service);
		System.out.println("billaccNo :"+billaccNo);
		System.out.println("accNo :"+accNo);
		
		try{
			  System.out.println("--------------> balance -------> "+Double.parseDouble(balance));
			  System.out.println("--------------> billAmt -------> "+Double.parseDouble(billAmt)); 
			  
	           if(Double.parseDouble(balance) < Double.parseDouble(billAmt))
	           {
	        	   System.out.println("came here ------->balance less");
	        	   ses.setAttribute("passPayResult", "Payment Amount Entered Exceeds Balance");
			       response.sendRedirect("passPayResult.jsp");
			       
	           }else
	           {
	        	   try{
	        		   
	        	   Double bal = Double.parseDouble(balance)- Double.parseDouble(billAmt);
		           System.out.println("----------> amount ---------->"+bal);
		           query.DetectAcc(accType, bal, String.valueOf(ses.getAttribute("currentUser")));
		           System.out.println("----------> amount ---------->"+String.valueOf(ses.getAttribute("custID")));
		           query.UpdateCard(Double.parseDouble(billAmt), String.valueOf(ses.getAttribute("currentUser")));
		           query.updateTransValues(accNo, accType, billType+" Bill Payment", billAmt, String.valueOf(ses.getAttribute("custID")));
		           ses.setAttribute("passPayResult", "Bill Payment Successfully Done");
			       response.sendRedirect("passPayResult.jsp");
	        	   
	        	   }catch(Exception e)
	        	   {
	        		   e.printStackTrace();
						System.out.println(" -----------> Failed in updation trans --------");
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
			    		      "\n\n Bill Payment is been performed in your"+
			    		      "\n\n Account : "+accType+
			    		      "\n Number : "+accNo+
			    		      "\n Payment Amount : "+billAmt+
			    		       "\n Payee Bill : "+billType+
			    		        "\n Payee Service : "+service+
			    		      "\n\n Note : Please do not reply to this E-Mail Notification";
			    
			mail.sendMail( "Bill Payment", text);
	   				
	   			}catch(Exception e){
	   				e.printStackTrace();
	   				System.out.println(" -----------> Failed in Mail notification --------");
	   			}
	            
	           }
	           
		}catch(Exception e)
		{
			ses.setAttribute("passPayResult", "Amount Payment Failure \n Please Try again");
	        response.sendRedirect("passPayResult.jsp");
			System.out.println("Failed here --------->"+e.getMessage());
	       	e.printStackTrace();
		}
		
		
	}
}
