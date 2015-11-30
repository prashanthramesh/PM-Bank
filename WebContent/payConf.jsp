<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script language="javascript" type="text/javascript">
function payValid()
{
var BilaccNo = document.payform.BilaccNo;
var billAmt = document.payform.billAmt;


if(validRecNo(BilaccNo,7)){	
if(validAmount(billAmt)){
	
	return true;

}
}
return false;		
}


function validRecNo(recNo,lenth)
{
var len = recNo.value.length;
var noFormat = /^\d+$/;
if(len < 7)
{
	alert('Please enter Valid Bill Number');
	return false;	
}
if(recNo.value.match(noFormat)){
return true;
} 
else
{
alert('Bill Number is Invalid');
return false;	
}
}


function validAmount(amount)
{
var len = amount.value.length;
var noFormat = /^\d+.?\d*$/;
if(len == 0)
{
	alert('Please enter Amount to Pay');
	return false;	
}	
if(amount.value.match(noFormat)){
return true;
} 
else
{
alert('Entered Amount is Invalid');
return false;	
}
}

</script>
<title>Insert title here</title>
</head>
<body>

<fieldset>
<legend><b>Pay</b></legend>
<h3 align=center> Bill Payment </h3>
<p align=center>Please enter the amount to be Payed</p>
<form style = "line-height:35px;"name="payform" action="PayTransfer" onSubmit="return payValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%

try
{	
	System.out.println("------------------> ACC TYPE -------"+session.getAttribute("PayAccountType").toString());
	System.out.println("------------------> AccountNo -------"+session.getAttribute("PayAccountNo").toString());
	System.out.println("------------------> PayeeType -------"+session.getAttribute("PayType").toString());
	
	String AccountType = session.getAttribute("PayAccountType").toString();
	String AccountNo = session.getAttribute("PayAccountNo").toString();	
	String payType = session.getAttribute("PayType").toString();	
	
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
	
	}else if(AccountType.equals("Chequing")){
		
		state =connect.prepareStatement("SELECT * FROM CHCKACC WHERE chkAcc=?");	
		state.setString(1,AccountNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("intialVal");
		}
		
	}else{
		state =connect.prepareStatement("SELECT * FROM creditcard WHERE CARD_NO=?");	
		state.setString(1,AccountNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("CRED_AMT");
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
<tr>  
<tr><td><input type="hidden" name="payType" value=<%=payType%>></td><td><input type="hidden" name="accType" value=<%=AccountType%>></td><td><input type="hidden" name="balAmt" value=<%=Balance%>></td><td><input type="hidden" name="accno" value=<%=AccountNo%>></td></tr>  
<tr></tr> 
<tr>
<td height="25"><div align="right">Type of Bill Payment :</div></td>
<td><%=payType%></td>
</tr>
<%

if(payType.equals("Broadband Bill"))
{
 %>
 <tr><td height="25"><div align="right">Select Service Provider :</div></td><td>
<select style="width: 220px;" name="serOption">
  <option value="Acanac">Acanac</option>
  <option value="Bell Internet">Bell Internet</option>
  <option value="Velcom">Velcom</option>
  <option value="Cogeco">Cogeco</option>
  <option value="Telus">Telus</option>
</select></td>
</tr>
 <%		
}else if(payType.equals("Mobile Bill"))
{
 %> 
 <tr><td height="25"><div align="right">Select Service Provider :</div></td><td>
<select style="width: 220px;" name="serOption">
  <option value="Rogers">Rogers</option>
  <option value="Bell Wireless">Bell Wireless</option>
  <option value="MTS Mobility">MTS Mobility</option>
  <option value="Fido">Fido</option>
  <option value="ChatR">ChatR</option>
</select></td>
</tr>
 <%
} else if(payType.equals("Water Bill")){
%>
<tr><td><input type="hidden" name="serOption" value="Water"></td></tr>
<%
} else if(payType.equals("Electricity Bill")){
%>
<tr><td><input type="hidden" name="serOption" value="Electricity"></td></tr>
<%
}	
}catch(Exception e){
System.out.println("---------> error here DEPOSIT DETAIL CASH---->"+e.getMessage());
}
%>

<tr>
<td height="25"><div align="right">Payee Bill No :</div></td>
<td><input style = "height:40px;margin-bottom:20px;"type="text" name="BilaccNo" value="" maxlength="7"></td>
</tr>
<tr>
<td height="25"><div align="right">Bill Amount :</div></td>
<td><input style = "height:40px;" type="text" name="billAmt" value="" ></td>
</tr>
<tr><td>&nbsp;</td></tr> 
<tr>
<td colspan=2 align=center><button style = "margin-left:60px;"class="btn btn-primary" type="submit" name="Paymny" value="Paymny">Pay </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-primary" type="reset">Reset</button></td> 
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2"><div align="center"><a href="paybills.jsp">Switch Payee Type \ Account</a></div></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>