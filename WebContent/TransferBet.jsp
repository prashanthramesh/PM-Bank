
<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.util.*" %>
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
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>Transfer Between Accounts</title>
</head>
<body>
<legend><b>Transfer</b></legend>
<p align=center>Please select the Account in which Money needs to be transfered </p>
<form name="transferform" action="TransferAcc"  method="POST">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td width="43%">&nbsp;</td>
<tr> 
<tr>
<td><div style = "padding-right:10px;"align="right">From Account: </div></td>
<%
String savAcc="";
String  chkAcc="";
String  savBal="";
String  chkBal="";
try
{
    System.out.println("++++++++ current USer ++++"+session.getAttribute( "currentUser"));
    PreparedStatement state=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();
while(result.next())
  {
	savAcc=result.getString("savAcc");
	savBal=result.getString("intialVal");
  }	
System.out.println("--------------->sav"+savAcc);
result.close();  
state.close();

PreparedStatement state1=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
state1.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
ResultSet result1=state1.executeQuery();
while(result1.next())
  {
      chkAcc=result1.getString("chkAcc"); 
      chkBal=result1.getString("intialVal");
  }	
System.out.println("--------------->chk"+chkAcc);
result1.close();  
state1.close();
}catch(Exception e)
{
	System.out.println("--------------->"+e.getMessage());
}
%>
<td>
<select name="frmOption">
  <option value="'sav'+<%=savAcc%>">Savings Account (<%=savAcc%>)</option>
  <option value="'chq'+<%=chkAcc%>">Chequing Account (<%=chkAcc%>)</option>
</select>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td><div style = "padding-right:10px;"align="right">To Account: </div></td>
<td>
<select name="toOption">
  <option value="'chq'+<%=chkAcc%>">Chequing Account (<%=chkAcc%>)</option>
  <option value="'sav'+<%=savAcc%>">Savings Account (<%=savAcc%>)</option>  
</select>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td height="25"><div align="right" style = "padding-right:10px;"><b>Transfer amount :</b></div></td>
<td><input type="text" name="tranamt" value="" maxlength="8"/></td>
</tr>
<tr><td>&nbsp;</td></tr>  
<tr><td><input type="hidden" name="savBal" value=<%=savBal%>></td><td><input type="hidden" name="chkBal" value=<%=chkBal%>></td></tr>  
<tr><td><input type="hidden" name="savAcc" value=<%=savAcc%>></td><td><input type="hidden" name="chkAcc" value=<%=chkAcc%>></td></tr>
<tr>
<td colspan=2 align=center><button style = "margin-top:20px;margin-left:75px;"class="btn btn-primary" type="submit" name="tran" value="tran">Transfer </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button style = "margin-top:20px;" class="btn btn-primary" type="reset">Reset</button></td> 
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</body>
</html>