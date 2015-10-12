<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create User</title>
<link href="css/menuMain.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width=100% bordercolor="#C6D4E1" bgcolor="#C6D4E1">
<tr><th scope="col"><div align="center"><h1 align="center"><font face="Times New Roman">PM- Online Banking System </font></h1></div></th></tr>
</table>
<div id="overall" align="center">
<div id="dropdwn" align="center">
<ul>
<li><a href='adminHome.jsp'>Home</a>
</li>
</ul>
<ul>
<li><a href='accountInfo.jsp?value=<%=session.getAttribute( "currentID" )%>'>Customers</a>
<ul>
<li><a href=''>View Balance</a></li>
<li><a href=''>View Transactions</a></li>
</ul>
</li>
</ul>
<ul>
<li><a href=''>Transfer</a>
<ul>
<li><a href=''>Deposit</a></li>
<li><a href=''>Withdraw</a></li>
</ul>
</li>
</ul>
<ul>
<li><a href=''>Credit Card</a>
</li>
</ul>
<ul>
<li><a href='paybills.jsp?value=<%=session.getAttribute( "currentID" )%>'>Pay Bills</a>
</li>
</ul>
<ul>
<li><a href='investMain.jsp?value=<%=session.getAttribute( "currentID" )%>'>Investments</a>
<ul>
<li><a href='viewShareInv.jsp?value=<%=session.getAttribute( "currentID" )%>'>Current Shares</a></li>
<li><a href='viewFdInv.jsp?value=<%=session.getAttribute( "currentID" )%>'>Current Fixed Deposit</a></li>
</ul>
</li>
</ul>
<ul>
<li><a href='updatePer.jsp?value=<%=session.getAttribute( "currentID" )%>'>Update Personal Info</a>
<ul>
<li><a href='changePass.jsp?value=<%=session.getAttribute( "currentID" )%>'>Change Password</a></li>
</ul>
</li>
</ul>
<ul>
<li><a href='logout.jsp'>Log Out</a></li>
</ul>
<br class="flow" />
</div>
</div>
&nbsp;
&nbsp;
</head>
<body>
<fieldset>
<legend><b> User </b></legend>
<h3 align=center> New User </h3>
<table width=50% align="center" cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<tr>
<td height="25"><p align=center><%=session.getAttribute("userAdd")%></p></td>
</tr>
<tr>
<td><div align="center"><a href='adminHome.jsp?value=<%=session.getAttribute( "currentID" )%>'>Home</a></div></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
</fieldset>
</body>
</html>