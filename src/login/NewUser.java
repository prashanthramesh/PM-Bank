package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class register
 */
public class NewUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String email;
	Query query;
	OnlineUser userObj;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewUser() {
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
	    
	
	
	   query = new Query();
	   email = request.getParameter("email").trim();
	   
	   try{
		   
		   if(request.getParameter("approve")!=null)
		   {
			   String cust = createUserID();
			   String pass = createPassword();			   
			   userObj = query.fetchUserInfo(email);			   
			   userObj.setPassword(pass);
			   userObj.setCustomerID(cust);
			   if(userObj.getEmail()!=null)
			   {
				   userObj.setCheckAccNo(accountDet());
				   userObj.setSavAccNo(accountDet());
				   userObj.setMnyCard(accountDet());
				   
				   query.createNewUser(userObj);
				   query.createCheckAcc(userObj);
				   query.createSavAcc(userObj);
				   query.createMnyCard(userObj);
				   query.dropUserReq(userObj.getEmail());
				   response.sendRedirect("pendAccReq.jsp"); 
			   }
		   }else
		   {				 
			   query.dropUserReq(email);
		       response.sendRedirect("pendAccReq.jsp"); 
		   }
		   
	   }catch(Exception e)
	   {
		   System.out.println(e.getMessage());
	   }
			
	}

	private String createPassword() {
		
		char[] pat = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
		Random ran = new Random();

		StringBuilder builder = new StringBuilder((100000 + ran.nextInt(900000)));
		for (int i = 0; i < 7; i++)
		{
			builder.append(pat[ran.nextInt(pat.length)]);
		}
		String id = builder.toString();

		System.out.println("-----pass ---->"+id);
		return id;
	}

	public String createUserID() {
		
		Random ran = new Random();			
		String id = String.format("%08d", ran.nextInt(100000000));
		System.out.println("-----cust ---->"+id);
		return id;
	}
	
	public String accountDet() {
		
		Random random = new Random();			
		String acc = String.format("%010d", random.nextInt(1000000000));
		return acc;
	}

}
