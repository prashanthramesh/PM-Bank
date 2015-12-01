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

<title>Withdraw</title>
</head>
<body>

<fieldset>
<legend><b>Pay Bill</b></legend>
<h3 align=center> Bill Payment</h3>
<p align=center>Please select Bill Payee</p>
<form name="billform" action="PayeeType" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td width="43%">&nbsp;</td>
</tr> 
<tr><td><div align="center"><b>Select Bill Payment </b></div></td><tr>
<tr><td>&nbsp;</td><tr>
<tr><td>&nbsp;</td><td ><input type="radio" name="option" value="Electricity Bill" checked>Electricity Bill<br></td></tr>
<tr><td>&nbsp;</td><td ><input type="radio" name="option" value="Broadband Bill">Broadband Bill<br></td></tr>
<tr><td>&nbsp;</td><td ><input type="radio" name="option" value="Mobile Bill">Mobile Bill<br></td></tr>
<tr><td>&nbsp;</td><td ><input type="radio" name="option" value="Water Bill">Water Bill<br></td></tr>
<tr><td>&nbsp;</td><tr>
<td><div style = "padding-right:10px;" align="right">Account </div></td>
<%
String SaccNo="";
String ChaccNo="";
String CreditNo="";
try
{

	PreparedStatement state=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();;
while(result.next())
  {
      SaccNo=result.getString("savAcc");   
  }	
result.close();  

PreparedStatement state1=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
state1.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
ResultSet result1=state1.executeQuery();;
while(result1.next())
  {
      ChaccNo=result1.getString("chkAcc"); 
  }	
result1.close();  

PreparedStatement state2=connect.prepareStatement("SELECT * FROM creditcard WHERE email=?");
state2.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
ResultSet result2=state2.executeQuery();;
while(result2.next())
  {
	CreditNo=result2.getString("CARD_NO"); 
  }	
result2.close();  

}catch(Exception e)
{
	System.out.println("--------------->"+e.getMessage());
}
%>
<td width="57%">
<select name="accOption">
  <option value="'sav'+<%=SaccNo%>">Savings Account (<%=SaccNo%>)</option>
  <option value="'chq'+<%=ChaccNo%>">Chequing Account (<%=ChaccNo%>)</option>
  <%if(!CreditNo.equalsIgnoreCase("")) 
  {
  %>
  <option value="'cre'+<%=CreditNo%>">Credit Card (<%=CreditNo%>)</option>
  <%
  }
  %>
</select>
</td>
</tr>
<tr><td width="43%">&nbsp;</td><tr>
<tr><td colspan=2 align=center><button style = "margin-left:90px;"class="btn btn-primary"type="submit" name="pay" value="pay">Proceed to Bill Payment</button><td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>