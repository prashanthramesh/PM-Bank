<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Request Portal</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
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
                <a class="navbar-brand" href="WelcomeAdmin.jsp">PM Online Banking System</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="WelcomeAdmin.jsp">Home</a>
                    </li>
                    <li class="active">
                        <a href='pendAccReq.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Customer Requests</a>
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
&nbsp;
&nbsp;
<fieldset>
<legend><b>New User </b></legend>
<h3 align=center> New User Requests </h3>
<p align=center>Listed below are the various New Customer Request </p>
<table width="1000px" align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5" >
<tr><td>&nbsp;<td></tr>
<%
Statement req = connect.createStatement();
ResultSet result =req.executeQuery("SELECT * FROM pending_request");
if(!result.next()){ 
	%>
	<tr><td><div align="center"><p>No New User Requests Available </div></td></tr>
  <% 
}
else{
%>
<tr><td align="right"><b> First Name </b></td>
<td align="center"><b> Email Id </b></td>
<tr>
<%
    do{
	    	  String fname=result.getString("first_name");
		      String email=result.getString("email");   	      
	%>
	<tr>
	<td align="right"><%=fname %></td>
	<td align="center"><a href='perinfo.jsp?value=<%=email%>'><%=email %></a></td>
	<tr>
	<tr><td>&nbsp;</td></tr>
	<%
	    } 
	    while(result.next());
	}
	
result.close();
req.close();
connect.close();
%>
<tr><td colspan="6"><div align="center"><a href='WelcomeAdmin.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>
</table>
</fieldset>
</body>
</html>