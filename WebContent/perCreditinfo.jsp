<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Credit Card Request</title>
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
                    <li >
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
<legend><b>Personal Information</b></legend>
<h3 align=center> Personal Information of Customer</h3>
<form name="perInfo" action="ReqApproval" method="POST">
<table align="center" style = "line-height:30px;">
<%
String email = request.getParameter("value").trim();
%>
<tr><td><input type="hidden" name="email" value="<%=email%>" size=25/></td></tr>
<%
String savbal = "";
String chkbal = "";
String expiry = "";
try
{
	PreparedStatement state1=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
	state1.setString(1,email);
	ResultSet result1=state1.executeQuery();
	while(result1.next()){
		savbal=result1.getString("intialVal");
		expiry=result1.getString("dayy");
	}
	state1.close();

	
	PreparedStatement state2=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
	state2.setString(1,email);
	ResultSet result2=state2.executeQuery();
	while(result2.next()){
		chkbal=result2.getString("intialVal");
	}
	state2.close();
	
	PreparedStatement state=connect.prepareStatement("SELECT * FROM account_details WHERE email=?");
	state.setString(1,email);
	ResultSet result=state.executeQuery();
	
	while(result.next()){
		
		String FirstName=result.getString("first_name");
	    String LastName=result.getString("last_name");
	    String Number=result.getString("phone_no");
	    String Dateofbirth=result.getString("dob");
	    String Email=result.getString("email");
	    String Gender=result.getString("gender");
	    String custID=result.getString("cust_ID");
	   
 %>
 <tr>
<td><div align="center"><b>Customer ID</b></div></td>
<td><%=custID%></td>
</tr>
<tr>
<td><div align="center"><b>First Name</b></div></td>
<td><%=FirstName%></td>
</tr>
<tr>
<td><div align="center"><b>Last Name </b></div></td>
<td><%=LastName%></td>
</tr>
<tr>
<td><div align="center"><b>Saving Account Balance</b></div></td>
<td><%=savbal%></td>
</tr>
<tr>
<td><div align="center"><b>Chequing Account Balance </b></div></td>
<td><%=chkbal%></td>
</tr>
<tr>
<td><div align="center"><b>Account Expiry Date</b></div></td>
<td><%=expiry%></td>
</tr>
<tr>
<td><div align="center"><b>Date Of Birth</b></div></td>
<td><%=Dateofbirth%></td>
</tr>
<tr>
<td><div align="center"><b>Gender </b></div></td>
<td><%=Gender%></td>
</tr>
<tr>
<td><div align="center"><b>Email </b></div></td>
<td><%=Email%></td>
</tr>
<tr>
<td><div align="center"><b>Contact Number </b></div></td>
<td> &nbsp;<%=Number%></td>
</tr>
<tr>
<tr><td><input name="id" type="hidden"  value=<%=custID%>></td></tr> 
<tr><td><input name="expiry" type="hidden"  value=<%=expiry%>></td></tr> 
<tr><td><input name="email" type="hidden"  value=<%=Email%>></td></tr> 
<%
  }
	state.close();
	connect.close();
} catch (Exception e) {	
	System.out.println("----------> error ------>"+e.getMessage());
}
%>
<tr align = "center" style = "position:absolute;margin-left:45px;">
<td><button class="btn btn-primary" type="submit" name="approveBut" value="credapprove"><u>A</u>pprove</button>&nbsp;<button class="btn btn-primary" type="submit"  name="declineBut" value="creddecline"><u>D</u>ecline</button></td> 
</tr>
</table>
</form>
</fieldset>
</body>
</html>