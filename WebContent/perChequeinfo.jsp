<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mortgage Request</title>
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
<legend><b>Cheque Details</b></legend>
<h3 align=center> Uploaded Cheque and Acoount details</h3>
<form name="perInfo" action="ReqApproval" method="POST">
<table align="center" style = "line-height:30px;">
<%
String email = request.getParameter("value").trim();
%>
<tr><td><input type="hidden" name="email" value="<%=email%>" size=25/></td></tr>
<%
String deAmt = "";
String accType = "";
String accTable = "";

String bal = "";
String expiry = "";
String AccNo = "";
try
{
		
	PreparedStatement state3=connect.prepareStatement("SELECT * FROM CHEQUEREQ WHERE email=?");
	state3.setString(1,email);
	ResultSet result3=state3.executeQuery();
	while(result3.next()){
		deAmt=result3.getString("amount");
		accType=result3.getString("accType");
	}
	state3.close();
	
	PreparedStatement state2;
	ResultSet result2;
	
	if(accType.equals("Savings"))
	{
		state2 =connect.prepareStatement("SELECT * FROM SAVACC WHERE email=?");	
		state2.setString(1,email);
		result2=state2.executeQuery();
		
		while(result2.next()){			
			bal=result2.getString("intialVal");
			AccNo=result2.getString("savAcc");
		}
	
	}else{
		
		state2 =connect.prepareStatement("SELECT * FROM CHCKACC WHERE email=?");	
		state2.setString(1,email);
		result2=state2.executeQuery();
		
		while(result2.next()){			
			bal=result2.getString("intialVal");
			AccNo=result2.getString("chkAcc");
		}
		
	}
 
  result2.close();
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
<tr>
 <tr>
<td><div align="center"><b>Deposit to Account </b></div></td>
<td><%=accType%></td>
<tr>
<td><div align="center"><b>Existing Account Balance</b></div></td>
<td><%=bal%></td>
</tr>
<tr>
<td><div align="center"><b>Cheque Amount</b></div></td>
<td><%=deAmt%></td>
</tr>
<tr><td><b> Uploaded Cheque</b></td></tr>
<tr>
<td><img src="ShowImage?email=<%=email%>"></img></td>
</tr>
<tr><td><input name="accno" type="hidden"  value=<%=AccNo%>></td></tr>  
<tr><td><input name="email" type="hidden"  value=<%=Email%>></td></tr> 
<tr><td><input name="accType" type="hidden"  value=<%=accType%>></td></tr>  
<tr><td><input name="balance" type="hidden"  value=<%=bal%>></td></tr> 
<tr><td><input name="depamt" type="hidden"  value=<%=deAmt%>></td></tr>
<tr><td><input name="custID" type="hidden"  value=<%=custID%>></td></tr>
<%
  }
	state.close();
	connect.close();
} catch (Exception e) {	
	System.out.println("----------> error ------>"+e.getMessage());
}
%>
<tr align = "center" style = "position:absolute;margin-left:45px;">
<td><button class="btn btn-primary" type="submit" name="approveBut" value="chqapprove"><u>A</u>pprove</button>&nbsp;<button class="btn btn-primary" type="submit"  name="declineBut" value="chqdecline"><u>D</u>ecline</button></td> 
</tr>
</table>
</form>
</fieldset>
</body>
</html> 