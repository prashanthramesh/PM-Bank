package login;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class login extends HttpServlet {
	String fname;

	String password ;
	HttpSession session;
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
         fname= request.getParameter("fname");
         password = request.getParameter("password");
         
         try
         {
            if(fname.equalsIgnoreCase("admin") && password.equalsIgnoreCase("admin") )
             {
             	session = request.getSession(true); 
             	session.setAttribute("currentUser", fname);
             	RequestDispatcher rs = request.getRequestDispatcher("WelcomeAdmin.jsp");
                rs.forward(request, response);
             }
            
            else if(Query.checkUser(fname,password)){
            	session = request.getSession(true); 
             	session.setAttribute("currentUser", fname);
	        	RequestDispatcher rs = request.getRequestDispatcher("custHome.jsp");
	            rs.forward(request, response);            	
            }
           else
           {
             RequestDispatcher rs = request.getRequestDispatcher("loginfailure.jsp");
             rs.include(request, response);
            } 
        	 
         }catch(Exception e)
         {
        	 e.printStackTrace();
         }
        
    }  
    }
