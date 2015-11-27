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
<title>CashDeposit</title>
<script language="javascript" type="text/javascript">
function cashValid()
{

var amount = document.cashform.depamt;

if(validAmount(amount)){

	return true;	
}

return false;
}

function validAmount(amount)
{
var len = amount.value.length;
var noFormat = /^\d+.?\d*$/;
if(len == 0)
{
	alert('Please enter Amount to Deposit');
	return false;	
}	
if((amount.match(noFormat)) && (amount > 0 )){
return true;
} 
else
{
alert('Entered Amount is Invalid');
return false;	
}
}

</script>
</head>
<body>

 <fieldset>
 <legend><b>Deposit</b></legend>
<h3 align=center> Cash Deposit</h3>
   <p align=center>Please enter the amount to be deposited </p>
<form name="cashform" action="CashDeposit" onSubmit="return cashValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{	

	
	String AccountType = session.getAttribute("AccountType").toString();
	String AccountNo = session.getAttribute("AccountNo").toString();	
	String Balance = null;
	PreparedStatement state;
	ResultSet result;
	
	if(AccountType.equals("Savings"))
	{
		state =connect.prepareStatement("SELECT * FROM SAVACC WHERE savAcc=?");	
		state.setString(1,AccountNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("intialVal");
		}
	
	}else{
		
		state =connect.prepareStatement("SELECT * FROM CHCKACC WHERE chkAcc=?");	
		state.setString(1,AccountNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("intialVal");
		}
		
	}
 
  result.close();
  state.close();
  %>
<tr>
<td height="25"><div align="right">Account Type :</div></td>
<td><%=AccountType%></td>
</tr>
<tr>
<tr>
<td height="25"><div align="right">Account Number :</div></td>
<td><%=AccountNo%></td>
</tr>
<tr>
<tr>
<td height="25"><div align="right">Current Balance :</div></td>
<td><%=Balance%> $</td>
</tr>
<tr>  
<tr><td><input type="hidden" name="accType" value=<%=AccountType%>></td><td><input type="hidden" name="balance" value=<%=Balance%>></td><td><input type="hidden" name="accno" value=<%=AccountNo%>></td></tr>  
<tr></tr>  
  <%
  
}catch(Exception e){
System.out.println("---------> error here DEPOSIT DETAIL CASH---->"+e.getMessage());
}
%>	
<tr>
<td height="25"><div align="right">Deposit amount :</div></td>
<td><input type="text" name="depamt" value="" ></td>
</tr>
<tr>
<tr><td>&nbsp;</td></tr>
<td colspan=2 align=center><button type="submit" name="dePo" value="dePo"><u>D</u>eposit </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset"><u>R</u>eset</button></td> 
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2"><div align="center"><a href="DepositMain.jsp">Switch Account</a></div></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>