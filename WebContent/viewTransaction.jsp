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
    <fieldset>
&nbsp;
<legend><b>Transactions</b></legend>
<h3 align=center> View Transactions</h3>
<p align=center>Below is the Detailed Transaction Information of the Account</p>
<table width="1000px" align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5" >
<tr><td>&nbsp;<td></tr>

<tr><td align="center"><b> Account Number </b></td>
<td align="center"><b> Account Type </b></td>
<td align="center"><b> Transfer Type </b></td>
<td align="center"><b> Amount </b></td>
<td align="center"><b> Date and Time </b></td>
<tr>
<tr><td>&nbsp;</td></tr>
<%
if(request.getParameter("value").startsWith("sav"))
{
	Statement reqst = connect.createStatement();
	ResultSet result =reqst.executeQuery("SELECT * FROM TRANS WHERE accNo="+request.getParameter("value").substring(3));
	
	
	if(!result.next()){ 
		%>
		<tr><td><div align="center"><p>New Account </p></div></td></tr>
		<tr><td><div align="center"><p>No Transactions Available </p></div></td></tr>
	  <% 
	}
	else{
	    do{
	    	 String AccNo=result.getString("accNo");
		      String AccType=result.getString("accType");   
		      String Time=result.getString("trans_date"); 
		      String TransType=result.getString("transType");
		      String Amt=result.getString("amount");	      
	%>
	<tr><td align="center"><%=AccNo %></td>
	<td align="center"><%=AccType %></td>
	<td align="center"><%=TransType %></td>
	<td align="center"><%=Amt %>$</td>
	<td align="center"><%=Time %></td>
	<tr>
	<tr><td>&nbsp;</td></tr>
	<%
	    } 
	    while(result.next());
	}
	
result.close();
reqst.close();
connect.close();
}
else if(request.getParameter("value").startsWith("chk"))
{

	Statement reqstchk = connect.createStatement();
	ResultSet resultchk =reqstchk.executeQuery("SELECT * FROM TRANS WHERE accNo="+request.getParameter("value").substring(3));

	if(!resultchk.next()){ 
		%>
		<tr><td><div align="center"><p>New Account </p></div></td></tr>
		<tr><td><div align="center"><p>No Transactions Available </p></div></td></tr>
	  <% 
	}
	else{
	    do{

	    	String AccNo=resultchk.getString("accNo");
	    	
		      String AccType=resultchk.getString("accType");   
		      String Time=resultchk.getString("trans_date"); 
		      String TransType=resultchk.getString("transType");
		      String Amt=resultchk.getString("amount");	 
	%>
	<tr><td align="center"><%=AccNo %></td>
	<td align="center"><%=AccType %></td>
	<td align="center"><%=TransType %></td>
	<td align="center"><%=Amt %>$</td>
	<td align="center"><%=Time %></td>
	<tr>
	<tr><td>&nbsp;</td></tr>
	<%
	    } 
	    while(resultchk.next());
	}

resultchk.close();
reqstchk.close();
connect.close();
}
else
{
	 Statement reqFull = connect.createStatement();
	 ResultSet re =reqFull.executeQuery("SELECT * FROM TRANS WHERE custID="+request.getParameter("value"));	 
	 
	 if(!re.next()){ 
		 %>
			<tr><td><div align="center"><p>New Account </p></div></td></tr>
			<tr><td><div align="center"><p>No Transactions Available </p></div></td></tr>
		  <%
		}
		else{
		    do{
		    	String AccNo=re.getString("accNo");
			      String AccType=re.getString("accType");   
			      String Time=re.getString("trans_date"); 
			      String TransType=re.getString("transType");
			      String Amt=re.getString("amount");	
		 %>
		<tr><td align="center"><%=AccNo %></td>
		<td align="center"><%=AccType %></td>
		<td align="center"><%=TransType %></td>
		<td align="center"><%=Amt %>$</td>
		<td align="center"><%=Time %></td>
		<tr>
		<tr><td>&nbsp;</td></tr>
		<%
		    } 
		    while(re.next());
		}
	 
	 re.close();
	 reqFull.close();
	 connect.close();
}
%>
<tr><td colspan="6"><div align="center"><a href='accountInfo.jsp?value=<%=session.getAttribute( "currentID" )%>'>Account</a></div></td></tr>
</table>
</fieldset>
</body>
</html>
</body>
</html>