package login;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class ChequeDeposit
 */
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
maxFileSize=1024*1024*10,      // 10MB
maxRequestSize=1024*1024*50)   // 50MB
public class ChequeDeposit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 Query query;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChequeDeposit() {
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

		HttpSession ses = request.getSession();
		try
		{
			query = new Query();
			String email = String.valueOf(ses.getAttribute("currentUser"));
			String custID = String.valueOf(ses.getAttribute("custID"));
			String amount = request.getParameter("cheamt");
			String accType = request.getParameter("accType");
			
			
			System.out.println("email +++++"+email);
			System.out.println("custID +++++"+custID);
			System.out.println("amount +++++"+amount);
			System.out.println("accType +++++"+accType);
				         
	        InputStream inpStream = null; 
	        
	        Part file = request.getPart("image");
	        
	        System.out.println("file +++++"+file);
	        
	        if (file != null) {
	            System.out.println(file.getName());
	            System.out.println(file.getSize());
	            System.out.println(file.getContentType());
	            inpStream = file.getInputStream();
	        }
	        
	        System.out.println("iputStream +++++"+inpStream);
	        query.reqChequeDeposit(email, custID, amount, inpStream,accType);
			   
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		 ses.setAttribute("chequeresult", "Cheque has been Uploaded for Admin Approval!");
	     response.sendRedirect("chequePass.jsp");
	}
}