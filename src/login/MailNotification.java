package login;

import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;

public class MailNotification {
	
	String bankMail ="pm18@mail.com";
	String bankPass ="Admin@123";
	String senderEmail ;
	
	Message mess;
	Session sess;
	
	public MailNotification(String senderMail)
	{
		this.senderEmail = senderMail;
		
		Properties pro = new Properties();
		pro.put("mail.smtp.host", "smtp.mail.com");
		pro.put("mail.smtp.socketFactory.port", "465");
		pro.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		pro.put("mail.smtp.auth", "true");
		pro.put("mail.smtp.port", "465");
		
        this.sess= Session.getDefaultInstance(pro,new javax.mail.Authenticator() {
					
        protected PasswordAuthentication getPasswordAuthentication() {
        	
		return new PasswordAuthentication(bankMail,bankPass);
					}
				});
        
        this.mess = new MimeMessage(this.sess);
	}
	
	public void sendMail(String Sub,String Text){
		
		try {
			 
			mess.setFrom(new InternetAddress("pm18@mail.com","Admin@123"));
			mess.setRecipients(Message.RecipientType.TO,InternetAddress.parse(senderEmail));
			mess.setSubject(Sub);
			mess.setText(Text);
 
			Transport.send(mess);
 
			System.out.println("Mail sent successfully --------->");
 
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}