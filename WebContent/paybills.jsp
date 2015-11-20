<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
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
                                <a href='viewTransaction.jsp=<%=session.getAttribute( "currentUser" )%>'>View Transaction</a>
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
                        <a href='forgotPassword.jsp=<%=session.getAttribute( "currentUser" )%>'>Mortgage</a>
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
<td><div align="right">Account </div></td>
<%
String SaccNo="";
String ChaccNo="";
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
}catch(Exception e)
{
	System.out.println("--------------->"+e.getMessage());
}
%>
<td width="57%">
<select style="width: 220px;" name="accOption">
  <option value="'sav'+<%=SaccNo%>">Savings Account (<%=SaccNo%>)</option>
  <option value="'chq'+<%=ChaccNo%>">Chequing Account (<%=ChaccNo%>)</option>
</select>
</td>
</tr>
<tr><td width="43%">&nbsp;</td><tr>
<tr><td colspan=2 align=center><button type="submit" name="pay" value="pay">Proceed to Bill Payment</button><td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>