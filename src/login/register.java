package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;

/**
 * Servlet implementation class register
 */
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Query query;
	DbConnection dbcon;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register() {
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
	    response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
		OnlineUser user = new OnlineUser();
		query = new Query();
		HttpSession ses = request.getSession();
		
		user.setFirstName(request.getParameter("fname"));
		user.setLastName(request.getParameter("lname"));
		user.setGender(request.getParameter("gen"));
		user.setDob(request.getParameter("dob"));
		user.setEmail(request.getParameter("email"));
		user.setPhoneNumber(request.getParameter("pnumber"));		
		
		try{
			
			dbcon = new DbConnection();
			PreparedStatement state=dbcon.getConnect().prepareStatement("SELECT * FROM pending_request WHERE email=?");
			state.setString(1,String.valueOf(request.getParameter("email")));
			ResultSet result=state.executeQuery();
			
			if(result.next()){
				ses.setAttribute("registerStatus", "New User Request is already existing for this Email ID ");
		        response.sendRedirect("loginSuccess.jsp");
			}else
			{
				if(query.registerUser(user))
				 {  
			        	RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
			            rs.forward(request, response);
			        }
			        else
			        {
			        	ses.setAttribute("registerStatus", "New User Request is sent for Bank Approval");
				        response.sendRedirect("loginSuccess.jsp");
			        }
			}
		}catch(Exception e)
		{
			e.getMessage();
		}
		doGet(request, response);
	}
	
	

}
