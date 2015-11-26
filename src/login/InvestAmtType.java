package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class InvestAmtType
 */
public class InvestAmtType extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InvestAmtType() {
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
		
		System.out.println("Came here invest type---------->");
		
		 
		 HttpSession ses = request.getSession();
		 System.out.println("---------cust id-------"+ses.getAttribute("currentID"));
	
		 String Accountno = request.getParameter("accOption");
		 System.out.println("Came here invest main work---------->"+Accountno);
		 
		 
		 System.out.println("Came here invest type---------->"+request.getParameter("type"));
		 
		 if(request.getParameter("type").equals("share"))
		 {
			 if(Accountno.startsWith("'sav'"))
			 {	
				 System.out.println("came here savings");
				 System.out.println("++++++++++ sav Accountno.substring(3) ++++>"+Accountno.substring(6));
				 ses.setAttribute("InvAccountType", "Savings");
				 ses.setAttribute("InvAccountNo", Accountno.substring(6));			 
				 response.sendRedirect("shareInv.jsp");
			 }else{
				 System.out.println("came here chequeing");
				 System.out.println("++++++++++ chq Accountno.substring(3) ++++"+Accountno.substring(6));
				 ses.setAttribute("InvAccountType", "Chequing");
				 ses.setAttribute("InvAccountNo", Accountno.substring(6));			 
				 response.sendRedirect("shareInv.jsp");
			 } 
			 
		 }else
		 {
			 if(Accountno.startsWith("'sav'"))
			 {			 
				 ses.setAttribute("InvAccountType", "Savings");
				 ses.setAttribute("InvAccountNo", Accountno.substring(6));			 
				 response.sendRedirect("depoInv.jsp");
			 }else{
				 ses.setAttribute("InvAccountType", "Chequing");
				 ses.setAttribute("InvAccountNo", Accountno.substring(6));			 
				 response.sendRedirect("depoInv.jsp");
			 } 
		 }
	}

}
