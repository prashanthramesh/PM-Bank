package login;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class ChequeDeposit
 */
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
maxFileSize=1024*1024*10,      // 10MB
maxRequestSize=1024*1024*50)   // 50MB
public class ChequeDeposit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 public final String UPLOAD_DIRECTORY = "G:/uploads";
	 public static final String SAVE_DIR = "G:/uploads";
       
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
			
			 String appPath = request.getServletContext().getRealPath("");
                System.out.println("appPath--->"+appPath);
		        String savePath = appPath + File.separator + SAVE_DIR;
		        System.out.println("savePath--->"+savePath);
		        
		        File fileSaveDir = new File(savePath);
		        if (!fileSaveDir.exists()) {
		            fileSaveDir.mkdir();
		        }
		         
		        for (Part part : request.getParts()) {
		            String fileName = extractFileName(part);
		            part.write(savePath + File.separator + fileName);
		        }
		 
		        ses.setAttribute("chequeresult", "Cheque has been Uploaded for Admin Approval!");
		        response.sendRedirect("chequePass.jsp");
			
		}catch(Exception e)
		{
			ses.setAttribute("chequeresult", "Cheque has been Uploaded for Admin Approval!");
	        response.sendRedirect("chequePass.jsp");
		}
       
	}

	
	 private String extractFileName(Part part) {
	        String contentDisp = part.getHeader("content-disposition");
	        String[] items = contentDisp.split(";");
	        for (String s : items) {
	            if (s.trim().startsWith("filename")) {
	                return s.substring(s.indexOf("=") + 2, s.length()-1);
	            }
	        }
	        return "";
	    }
}
