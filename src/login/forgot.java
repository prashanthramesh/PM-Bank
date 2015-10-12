package login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class forgot
 */
public class forgot extends HttpServlet {
	private static final long serialVersionUID = 1L;
	OnlineUser user ;
	Query query;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgot() {
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
		user = new OnlineUser();
		query = new Query();
		user.setLastName(request.getParameter("lname"));
		user.setDob(request.getParameter("dob"));
		user.setEmail(request.getParameter("email"));
		user.setPassword(request.getParameter("password"));
		
		if(query.forgotUser(user))
		 {
			out.println("Successfully Registered !!!!!!!");
			query.updateForgotUser(user);
	        	RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
	            rs.forward(request, response);
	        }
	        else
	        {
	           out.println("Username or Password incorrect");
	           RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
	           rs.include(request, response);
	        }
		doGet(request, response);
	}

}
