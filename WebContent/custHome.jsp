<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.util.*" %>
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
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>Customer Home Page</title>
</head>
<body>
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
                        <%--  <li>
                                <a href='viewBalance.jsp=<%=session.getAttribute( "currentUser" )%>'>View Balance</a>
                            </li> --%>
                             <li>
                                <a href='viewTransaction.jsp?value=<%=session.getAttribute( "currentUser" )%>'>View Transaction</a>
                            </li>
                        </ul>
                    </li>
                     <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href='transfer.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Transfer<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='withdrawal.jsp?value=<%=session.getAttribute( "currentUser" )%>'>WithDraw</a>
                            </li>
                             <li>
                                 <a href='DepositMain.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Deposit</a>
                            </li>
                        </ul>
                    </li>
                    <li >
                        <a href='creditCard.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Credit Card</a>
                    </li>
                     <li >
                        <a href='paybills.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Pay Bills</a>
                    </li>
                    <li >
                        <a href='investMain.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Investments</a>
                    </li>
                    <li >
                        <a href='mortgage.jsp=<%=session.getAttribute( "currentUser" )%>'>Mortgage</a>
                    </li>
                     <li >
                        <a href='forgotPassword.jsp=<%=session.getAttribute( "currentUser" )%>'>Change Password</a>
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
    <div style = "margin-top:20px;margin-left:110px;">
<b>Welcome <%= session.getAttribute( "currentID" ) %></b>
<fieldset>
<legend><b>Account</b></legend>
<h3 align=center> Account Information</h3>
<p align=center>Below are the Account details maintained</p>
<table width=100% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<tr><td><b> Savings Account </b></td><tr>
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
<tr><td><b> Checking Account </b></td><tr>
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