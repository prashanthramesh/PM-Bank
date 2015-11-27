<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.util.*" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>Customer Home Page</title>
</head>
<body>
<body>

    <div style = "margin-top:20px;margin-left:110px;">
<b>Welcome <%= session.getAttribute( "currentID" ) %></b>
<fieldset>
<legend><b>Account</b></legend>
<h3 align=center> Account Information</h3>
<p align=center>Below are the Account details maintained</p>
<table width=100% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<tr><td><b style="position:absolute;margin-top:15px;"> Savings Account </b></td><tr>
<tr><td>&nbsp;</td><tr>
<%
try
{
	PreparedStatement state=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();
while(result.next())
  {
      String Balance=result.getString("intialVal");
      String SaccNo=result.getString("savAcc");   
      String expDate=result.getString("dayy"); 
      String lname=result.getString("lname");
 %>
<tr align=center>
<td><b>Account No</b></td>
<td><b>Balance</b></td>
</tr>
<tr align=center>
<td><%=SaccNo%></td>
<td>$<%=Balance%></td>
</tr>
<%
  }
result.close();
}catch(Exception e)
{
	e.getMessage();
}
%>
<tr><td>&nbsp;</td><tr>
<tr><td><b style="position:absolute; margin-top:20px;">Checking Account </b></td><tr>
<tr><td>&nbsp;</td><tr>
<%
try
{
	
	PreparedStatement state=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result1=state.executeQuery();
	while(result1.next())
	  {
	      String Balance=result1.getString("intialVal");
	      String ChaccNo=result1.getString("chkAcc");   
	      String expDate=result1.getString("dayy"); 
	      String lname=result1.getString("lname");
	      
	      %>
	      <tr align=center>
	      <td><b>Account No</b></td>
	      <td><b>Balance</b></td>	      
	      </tr>
	      <tr align=center>
	      <td><%=ChaccNo%></td>
	      <td>$<%=Balance%></td>	     
	      </tr>
    <%
	  }
	result1.close();
	
}catch(Exception e)
{
	e.getMessage();
}
%>
<tr><td>&nbsp;</td><tr>
<tr><td>&nbsp;</td><tr>
</table>
</fieldset>
</body>
</html>