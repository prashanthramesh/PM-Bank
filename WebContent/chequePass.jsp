<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<title>Deposit</title>
</head>
<body>
<fieldset>
<legend><b> Deposit </b></legend>
<h3 align=center> Cheque Deposit </h3>
<table width=50% align="center" cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<tr>
<td height="25"><p align=center><%=session.getAttribute("chequeresult")%></p></td>
</tr>
<tr>
<td><div align="center"><a href='DepositMain.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Deposit</a></div></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
</fieldset>
</body>
</html>