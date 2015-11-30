package login;

import java.io.IOException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;

/**
 * Servlet implementation class UserOpr
 */
public class UserOpr extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
	DbConnection dbcon;
	OnlineUser user;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserOpr() {
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
		System.out.println("came here 1  +++++++++++++Came here User Operation");
		HttpSession ses = request.getSession();
		dbcon = new DbConnection();
		query = new Query();
		String option = request.getParameter("buttonVal");
		System.out.println("came here 2  +++++++++++++"+option);
		System.out.println("came here 3  +++++++++++++"+(request.getParameter("email")));
		
		
		if(option.equalsIgnoreCase("create"))
		{
			if(query.checkUserEmail(request.getParameter("email")))
			{
				ses.setAttribute("userStatus", "Customer with same Information already Exist ! Please change Customer Info");
			    response.sendRedirect("resultUserOpr.jsp");
			    
			}else
			{
				user = new OnlineUser();
				
				user.setFirstName(request.getParameter("fname"));
				user.setLastName(request.getParameter("lname"));
				user.setGender(request.getParameter("gen"));
				user.setDob(request.getParameter("dob"));
				user.setEmail(request.getParameter("email"));
				user.setPhoneNumber(request.getParameter("pnumber"));	
				
				 String cust = createUserID();
				 String pass = createPassword();
				 
				 user.setPassword(pass);
				 user.setCustomerID(cust);
				 user.setCheckAccNo(accountDet());
				 user.setSavAccNo(accountDet());
				 user.setMnyCard(accountDet());
				   
				   query.createNewUser(user);
				   query.createCheckAcc(user);
				   query.createSavAcc(user);
				   query.createMnyCard(user);
				   
				   ses.setAttribute("userStatus", "New Customer Successfully Created");
				   response.sendRedirect("resultUserOpr.jsp");
			}
			
		}else if(option.equalsIgnoreCase("fetch"))
		{
			if(query.checkUserCustID(request.getParameter("custid")))
			{
				RequestDispatcher rs = request.getRequestDispatcher("updatePer.jsp");
	            rs.forward(request, response);
			    
			}else
			{
				ses.setAttribute("userStatus", "Customer ID entered doesnt Exist ! Please enter correct Customer ID");
			    response.sendRedirect("resultUserOpr.jsp");
			}
		}else if(option.equalsIgnoreCase("update"))
		{
			user = new OnlineUser();
			
			user.setFirstName(request.getParameter("fname"));
			user.setLastName(request.getParameter("lname"));
			user.setGender(request.getParameter("gen"));
			user.setDob(request.getParameter("dob"));
			user.setEmail(request.getParameter("email"));
			user.setPhoneNumber(request.getParameter("pnumber"));
			
			query.updateUserInfo(user, request.getParameter("custID"));
			ses.setAttribute("userStatus", "Customer Information Updated Successfully");
		    response.sendRedirect("resultUserOpr.jsp");
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
