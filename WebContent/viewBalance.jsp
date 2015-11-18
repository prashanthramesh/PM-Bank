<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
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
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="custHome.jsp">PM Online Banking System</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="active">
                        <a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a>
                    </li>
                    <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Account<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='viewBalance.jsp=<%=session.getAttribute( "currentUser" )%>'>View Balance</a>
                            </li>
                             <li>
                                <a href='viewTransaction.jsp=<%=session.getAttribute( "currentUser" )%>'>View Transaction</a>
                            </li>
                        </ul>
                    </li>
                     <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href='transfer.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Transfer<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='withdrawal.jsp?value=<%=session.getAttribute( "currentUser" )%>'>With Draw</a>
                            </li>
                             <li>
                                 <a href='DepositMain.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Deposit</a>
                            </li>
                        </ul>
                    </li>
                    <li >
                        <a href='creditCard.jsp=<%=session.getAttribute( "currentUser" )%>'>Credit Card</a>
                    </li>
                     <li >
                        <a href='paybill.jsp=<%=session.getAttribute( "currentUser" )%>'>Pay Bills</a>
                    </li>
                    <li >
                        <a href='forgotPassword.jsp=<%=session.getAttribute( "currentUser" )%>'>Mortgage</a>
                    </li>
                     <li >
                        <a href='forgotPassword.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Change Password</a>
                    </li>
                    
                    <li >
                        <a href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
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