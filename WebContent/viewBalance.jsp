<%@ page import="java.sql.*"%>
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
<title>Insert title here</title>
</head>
<body>
<h3 align=center> View Account Balance</h3>
<p align=center>Below is the Detailed Account Information of the Account</p>
<table width=100% align=center cellpadding=5 cellspacing=0 style = "line-height:25px;">
<tr><td>&nbsp;</td></tr>
<%
if(request.getParameter("value").startsWith("sav"))
{
%>
<tr><td align="right"><b> Savings Account NO </b></td><td align="left"><b><%=request.getParameter("value").substring(3)%></b></td></tr>
<%
Statement req = connect.createStatement();
ResultSet result =req.executeQuery("SELECT * FROM SAVACC WHERE savAcc="+request.getParameter("value").substring(3));
while(result.next())
  {
      String Balance=result.getString("intialVal");
      String SaccNo=result.getString("savAcc");   
      String expDate=result.getString("dayy"); 
      String lname=result.getString("lname");
%>
<tr><td>&nbsp;</td></tr>
<tr><td align="right"><b> Name of Holder </b></td><td><%=lname%></td></tr>
<tr><td align="right"><b> Currency </b></td><td>    CANADIAN DOLLARS</td></tr>
<tr><td align="right"><b> Current Balance </b></td><td ><%=Balance%> $</td></tr>
<tr><td align="right"><b> Expiry Date </b></td><td><%=expDate%></td></tr>
<tr><td align="right"><b> Interest Rate </b></td><td>3% P.A</td></tr>
<tr><td>&nbsp;</td></tr>
 <%
  }
result.close();

}else if(request.getParameter("value").startsWith("chk"))
{
%>
<tr><td align="right"><b> Checking Account NO </b></td><td align="left"><b><%=request.getParameter("value").substring(3)%></b></td></tr>
<%
Statement reqst = connect.createStatement();
ResultSet result =reqst.executeQuery("SELECT * FROM CHCKACC WHERE chkAcc="+request.getParameter("value").substring(3));
while(result.next())
  {
	String Balance=result.getString("intialVal");
    String SaccNo=result.getString("chkAcc");   
    String expDate=result.getString("dayy"); 
    String lname=result.getString("lname");;
%>
<tr><td>&nbsp;</td></tr>
<tr><td align="right"><b> Name of Holder:&nbsp;</b></td><td><%=lname%></td></tr>
<tr><td align="right"><b> Currency:&nbsp; </b></td><td>    CANADIAN DOLLARS</td></tr>
<tr><td align="right"><b> Current Balance:&nbsp; </b></td><td ><%=Balance%> $</td></tr>
<tr><td align="right"><b> Expiry Date :&nbsp;</b></td><td><%=expDate%></td></tr>
<tr><td align="right"><b> Interest Rate:&nbsp; </b></td><td>0% P.A</td></tr>
<tr><td>&nbsp;</td></tr>
<%
  }
result.close();	
}else
{
%>
<%
Statement reqst = connect.createStatement();
ResultSet result =reqst.executeQuery("SELECT * FROM SAVACC WHERE custID="+request.getParameter("value"));
while(result.next())
  {
	String Balance=result.getString("intialVal");
    String SaccNo=result.getString("savAcc");   
    String expDate=result.getString("dayy"); 
    String lname=result.getString("lname");
      
%>
 <tr><td>&nbsp;</td></tr>
 <tr><td align="right"><b> Name of Holder:&nbsp; </b></td><td><%=lname%></td></tr>
  <tr><td align="right"><b> Account Type:&nbsp; </b></td><td> Savings Account</td></tr>
  <tr><td align="right"><b> Account Number:&nbsp; </b></td><td> <%=SaccNo%></td></tr>
 <tr><td align="right"><b> Currency:&nbsp; </b></td><td>    CANADIAN DOLLARS</td></tr>
  <tr><td align="right"><b> Current Balance:&nbsp; </b></td><td ><%=Balance%></td></tr>
 <tr><td align="right"><b> Expiry Date:&nbsp; </b></td><td><%=expDate%></td></tr>
  <tr><td align="right"><b> Interest Rate :&nbsp;</b></td><td>3% P.A</td></tr>
 <tr><td>&nbsp;</td></tr>
<%
 }
 result.close();

 Statement reqst1 = connect.createStatement();
 ResultSet result1 =reqst.executeQuery("SELECT * FROM chckacc WHERE custID="+request.getParameter("value"));
 while(result1.next())
   {
	 String Balance=result1.getString("intialVal");
     String chaccNo=result1.getString("chkAcc");   
     String expDate=result1.getString("dayy"); 
     String lname=result1.getString("lname");
 %>
 <tr><td>&nbsp;</td></tr>
 <tr><td align="right"><b> Name of Holder:&nbsp; </b></td><td><%=lname%></td></tr>
   <tr><td align="right"><b> Account Type :&nbsp;</b></td><td> Chequing Account</td></tr>
  <tr><td align="right"><b> Account Number:&nbsp; </b></td><td> <%=chaccNo%></td></tr>
 <tr><td align="right"><b> Currency:&nbsp; </b></td><td>    CANADIAN DOLLARS</td></tr>
 <tr><td align="right"><b> Current Balance:&nbsp; </b></td><td ><%=Balance%></td></tr>
 <tr><td align="right"><b> Expiry Date:&nbsp; </b></td><td><%=expDate%></td></tr>
 <tr><td align="right"><b> Interest Rate:&nbsp;</b></td><td>0% P.A</td></tr>
 <tr><td>&nbsp;</td></tr>
 <% 
}
 result1.close();
}
%>
<td colspan="2"><div align="center"><a href='accountInfo.jsp?value=<%=session.getAttribute( "currentID" )%>'>Account</a></div></td>
</table>
</fieldset>
</body>
</html>