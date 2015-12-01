package login;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dbConnection.DbConnection;

/**
 * Servlet implementation class ShowImage
 */
public class ShowImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DbConnection db;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowImage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("came here dude !!");	
		System.out.println("email "+request.getParameter("email"));	

		Blob image = null;
		byte[ ] imgData = null ;
		
		 try{
		    	db = new DbConnection();
		    	PreparedStatement state3=db.getConnect().prepareStatement("SELECT * FROM CHEQUEREQ WHERE email=?");
		    	state3.setString(1,request.getParameter("email"));
		    	ResultSet result3=state3.executeQuery();
		    	while(result3.next()){
		    		image = result3.getBlob("Photo");
		    		imgData = image.getBytes(1,(int)image.length());
		    	}
		    	
		    	response.setContentType("image/gif");
				OutputStream o = response.getOutputStream();
				o.write(imgData);
				o.flush();
				o.close();
				result3.close();
				state3.close();

		     }catch(Exception e)
		     {
		         e.printStackTrace();
		     }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
