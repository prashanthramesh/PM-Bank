<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />

<title>CreditCard</title>
</head>
<body>


<fieldset>
<legend><b> Credit Card</b></legend>
<h3 align=center> Credit Card Information </h3>
<p align=center><b>Please find your Credit Card Information below </b></p>
<form name="creditform" action="ReqCreditCard" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{
	
	String savAcc="";
	String  chkAcc="";
	
	 PreparedStatement state1=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
		state1.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
		ResultSet result1=state1.executeQuery();
	while(result1.next())
	  {
		savAcc=result1.getString("savAcc");    
	  }	
	System.out.println("--------------->sav"+savAcc);
	result1.close();  
	state1.close();

	PreparedStatement state2=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
	state2.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result2=state2.executeQuery();
	while(result2.next())
	  {
	      chkAcc=result2.getString("chkAcc"); 
	  }	
	System.out.println("--------------->chk"+chkAcc);
	result2.close();  
	state2.close();
	
	PreparedStatement state=connect.prepareStatement("SELECT * FROM CREDITCARD WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();;
	
	if(result.next()){
		
		String CardNo=result.getString("CARD_NO");
	    String CredAmt=result.getString("CRED_AMT");
	    String DebitAmt=result.getString("DEBIT_AMT");
	    String CcvNo=result.getString("CCV_NO");
	    String Exp_date=result.getString("EXPIRY_DATE");
%>
<tr align=center><td><b>Credit Card No :</b></td><td align=left><%=CardNo %></td></tr>
<tr align=center><td><b>Credit Amount :</b></td><td align=left><%=CredAmt %></td></tr>
<tr align=center><td><b>Debit Amount :</b></td><td align=left><%=DebitAmt %></td></tr>
<tr align=center><td><b>CCv No :</b></td><td align=left><%=CcvNo %></td></tr>
<tr align=center><td><b>Expiry Date :</b></td><td align=left><%=Exp_date %></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td><div style = "padding-right:30px;"align="right">Pay Credit card from Account: </div></td>
<td><select name="accOption">
  <option value="'sav'+<%=savAcc%>">Savings Account (<%=savAcc%>)</option>
  <option value="'chq'+<%=chkAcc%>">Chequing Account (<%=chkAcc%>)</option>
</select>
</td>
</tr>
<tr><td><input name="intbalance" type="hidden"  value=<%=DebitAmt%>></td></tr>  
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=13 align=center><button name="buttonVal" value="pay" type="submit" ><u>P</u>ay Credit Card</button></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>	     	      	    
<%    
	    
	}else
	{
%>
<tr><td><p align=center><b>No Credit Card Issued </b></p></td></tr>
<tr><td><p align=center>Please apply for a new credit card</p></td></tr>
<tr><td colspan=2 align=center><button class="btn btn-primary" name="buttonVal" value="req" type="submit">Apply Credit Card</button></td></tr>	
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>		
<%		
	}
	state.close();
	connect.close();
} catch (Exception e) {	
	System.out.println("----------> error ------>"+e.getMessage()); 
}
 %>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>