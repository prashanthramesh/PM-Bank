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
 * Servlet implementation class TransferAcc
 */
public class TransferAcc extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransferAcc() {
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
        
        String frmAccBalance = " ";
        String frmAccType = " ";
        String toAccBalance = "";
        String toAccType = " ";
        String accNo = "";

        
		String entAmount = request.getParameter("tranamt");
		String frmAcc = request.getParameter("frmOption");
		String toAcc = request.getParameter("toOption");
		
		if(frmAcc.startsWith("'sav'"))
		 {	
			frmAccBalance = request.getParameter("savBal");
			frmAccType = "Savings";
		 }else{
			 frmAccBalance = request.getParameter("chkBal");
			 frmAccType = "Chequeing";
		 } 
		
		if(toAcc.startsWith("'sav'"))
		 {	
			toAccBalance = request.getParameter("savBal");
			toAccType = "Savings";
			accNo = request.getParameter("savAcc");
		 }else{
			 toAccBalance = request.getParameter("chkBal");
			 toAccType = "Chequeing";
			 accNo = request.getParameter("chkAcc");
		 } 
		
		 try{
			 
			 System.out.println("----------->frmAccBalance-- "+frmAccBalance);
			 System.out.println("----------->entAmount-- "+entAmount);
		
		if(Double.parseDouble(frmAccBalance) < Double.parseDouble(entAmount))
		{
			 System.out.println("came here ------->balance less");
      	   ses.setAttribute("passTranResult", "Payment Amount Entered Exceeds Balance");
		   response.sendRedirect("passTranResult.jsp");
		}else
		{
			Double newbal = Double.parseDouble(toAccBalance)+Double.parseDouble(entAmount);
			Double oldbal = Double.parseDouble(frmAccBalance)-Double.parseDouble(entAmount);
			
			query.UpdateAcc(toAccType,newbal,String.valueOf(ses.getAttribute("currentUser")));
			query.UpdateAcc(frmAccType,oldbal,String.valueOf(ses.getAttribute("currentUser")));
	        query.updateTransValues(accNo, toAccType, "Transfer", entAmount, String.valueOf(ses.getAttribute("custID")));
	           
	        ses.setAttribute("passTranResult", "Payment Transferred Successfully");
			   response.sendRedirect("passTranResult.jsp");
		}
		 }catch(Exception e)
		     {
			 ses.setAttribute("passTranResult", "Transfer Failed");
			   response.sendRedirect("passTranResult.jsp");
		    	 
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
				    		      "\n\n Transfer is been performed in your"+
				    		      "\n\n Account : "+toAccType+
				    		      "\n Number : "+accNo+
				    		      "\n Deposit Amount : "+entAmount+
				    		      "\n\n Note : Please do not reply to this E-Mail Notification";
				    
				mail.sendMail( "Transfer Cash", text);
				dbcon.clsConnect();
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println(" -----------> Failed in Mail notification --------");
			}

	}

}
