package login;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;

/**
 * Servlet implementation class ReqApproval
 */
public class ReqApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
	DbConnection dbcon;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReqApproval() {
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
		dbcon = new DbConnection();
		query = new Query();	
		
		if(request.getParameter("approveBut")!=null)
		{			
			String CardNo = createCreditCard();
			String ccvNo = createCCV();
			String email = request.getParameter("email");
		    String expiry =request.getParameter("expiry");
		    String custID =request.getParameter("id");
		    
		    query.createCreditCard(email, custID, CardNo, ccvNo, expiry);
		    query.dropCreditReq(email);
		    response.sendRedirect("pendCreditReq.jsp"); 
		}else
		{
			try
			{
				query.dropCreditReq(request.getParameter("email"));
				MailNotification mail = new MailNotification(request.getParameter("email"));
			    
			    String text = "Hello "+ 
			    		      "\n\n Sorry your Credit card request is be Declined"+
			    		      "\n\n Please log into portal for more details: "+	
			    		      "\n\n Note : Please do not reply to this E-Mail Notification";
			    
			    mail.sendMail( "Credit Card Declined", text);
			}catch(Exception e)
			{
				e.getMessage();
				response.sendRedirect("pendCreditReq.jsp"); 
			}
			response.sendRedirect("pendCreditReq.jsp"); 
		}
	}
	
	
    public String createCreditCard() {
		
		Random random = new Random();			
		String acc = String.format("%010d", random.nextInt(1000000000));
		return acc;
	}
    
public String createCCV() {
		
		Random random = new Random();			
		String acc = String.format("%03d", random.nextInt(1000));
		return acc;
	}

}