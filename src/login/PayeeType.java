package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PayeeType
 */
public class PayeeType extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayeeType() {
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
		System.out.println("Came here Payee type---------->");
		
		 
		 HttpSession ses = request.getSession();
		 System.out.println("---------cust id-------"+ses.getAttribute("currentID"));
	
		 String Accountno = request.getParameter("accOption");
		 System.out.println("Came here Transfer main work---------->"+Accountno);
		 
		 String payType = request.getParameter("option");
		 
		 System.out.println("Came here Payee type---------->"+request.getParameter("option"));
		 
		
			 if(Accountno.startsWith("'sav'"))
			 {	
				 System.out.println("came here savings");
				 System.out.println("++++++++++ sav Accountno.substring(3) ++++>"+Accountno.substring(6));
				 ses.setAttribute("PayAccountType", "Savings");
				 ses.setAttribute("PayAccountNo", Accountno.substring(6));
				 ses.setAttribute("PayType", payType);
				 response.sendRedirect("payConf.jsp");
			 }else{
				 System.out.println("came here chequeing");
				 System.out.println("++++++++++ chq Accountno.substring(3) ++++"+Accountno.substring(6));
				 ses.setAttribute("PayAccountType", "Chequing");
				 ses.setAttribute("PayAccountNo", Accountno.substring(6));	
				 ses.setAttribute("PayType", payType);
				 response.sendRedirect("payConf.jsp");
			 } 
			 
	}

}
