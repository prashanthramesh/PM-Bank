package login;


import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DepositType
 */
@WebServlet("/DepositType")
public class Deposit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Deposit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("Came here Deposit type---------->");
		
		 
		 HttpSession ses = request.getSession();
		 System.out.println("---------cust id-------"+ses.getAttribute("currentUser"));
	
		 String Accountno = request.getParameter("accOption");
		 System.out.println("Came here Deposit main work---------->"+Accountno);
		 
		 
		 System.out.println("Came here Deposit type---------->"+request.getParameter("cash"));
		 
		 
		 
		 if(request.getParameter("cash")!=null)
		 {
			 if(Accountno.startsWith("'sav'"))
			 {	
				 System.out.println("came here savings");
				 System.out.println("++++++++++ sav Accountno.substring(3) ++++>"+Accountno.substring(6));
				 ses.setAttribute("AccountType", "Savings");
				 ses.setAttribute("AccountNo", Accountno.substring(6));			 
				 response.sendRedirect("cashDeposit.jsp");
			 }else{
				 System.out.println("came here chequeing");
				 System.out.println("++++++++++ chq Accountno.substring(3) ++++"+Accountno.substring(6));
				 ses.setAttribute("AccountType", "Chequing");
				 ses.setAttribute("AccountNo", Accountno.substring(6));			 
				 response.sendRedirect("cashDeposit.jsp");
			 } 
			 
		 }else
		 {
			 if(Accountno.startsWith("'sav'"))
			 {			 
				 ses.setAttribute("AccountType", "Savings");
				 ses.setAttribute("AccountNo", Accountno.substring(6));			 
				 response.sendRedirect("chequeDeposit.jsp");
			 }else{
				 ses.setAttribute("AccountType", "Chequing");
				 ses.setAttribute("AccountNo", Accountno.substring(6));			 
				 response.sendRedirect("chequeDeposit.jsp");
			 } 
		 }
	}

}