package login;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class login extends HttpServlet {
	String fname;
	String password ;
	HttpSession session;
	Query query;
	OnlineUser userDet;
	
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
         fname= request.getParameter("fname");
         password = request.getParameter("password");
         query = new Query();
         try
         {
            if(fname.equalsIgnoreCase("admin") && password.equalsIgnoreCase("admin") )
             {
             	session = request.getSession(true); 
             	session.setAttribute("currentUser", "Admin");
             	RequestDispatcher rs = request.getRequestDispatcher("WelcomeAdmin.jsp");
                rs.forward(request, response);
             }
            
            else if(query.checkUser(fname,password)){
            	session = request.getSession(true); 
            	userDet = query.fetchUserInfoCustID(fname);
             	session.setAttribute("currentUser", userDet.getEmail());
             	session.setAttribute("currentID", userDet.getFirstName());
             	session.setAttribute("custID", userDet.getCustomerID());
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
