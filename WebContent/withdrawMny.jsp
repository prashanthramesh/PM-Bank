<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ include file="dbconn.jsp" %>
 <%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script language="javascript" type="text/javascript">
function cashValid()
{

var amount = document.mnywith.withamt.value;

if(validAmount(amount)){

	return true;	
}

return false;
}

function validAmount(amount)
{
var len = amount.length;
var noFormat = /^\d+.?\d*$/;
if(len == 0)
{
	alert('Please enter Amount to Withdraw');
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
<legend><b>Withdraw</b></legend>
<h3 align=center> Withdraw Amount </h3>
<p align=center>Please enter the amount to be Withdrawn </p>
<form name="mnywith" action="WithdrawMny" onSubmit="return cashValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{	
	
    String type = request.getParameter("accOption");
    String accNo = request.getParameter("accOption").substring(6);
    
    System.out.println("---------> accOption here---->"+request.getParameter("accOption"));
    System.out.println("---------> accOption next place---->"+request.getParameter("accOption").substring(6));

	String Balance = null;
	String AccountType = "";
	PreparedStatement state;
	ResultSet result;
	
	if(type.startsWith("'sav'"))
	{
		AccountType = "Savings";
		state =connect.prepareStatement("SELECT * FROM savacc WHERE savAcc=?");	
		state.setString(1,accNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("intialVal");
		}
	
	}else{
		
		AccountType = "Chequeing";
		state =connect.prepareStatement("SELECT * FROM CHCKACC WHERE chkAcc=?");	
		state.setString(1,accNo);
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
<td><%=accNo%></td>
</tr>
<tr>
<tr>  
<tr><td><input type="hidden" name="accType" value=<%=AccountType%>></td><td><input name="balance" type="hidden"  value=<%=Balance%>></td><td><input type="hidden" name="accno" value=<%=accNo%>></td></tr>  
<tr></tr>  
  <%
  
}catch(Exception e){
e.getMessage();
}
%>	
<tr>
<td height="25"><div align="right">Withdraw amount :</div></td>
<td><input type="text" name="withamt" value="" ></td>
</tr>
<tr>
<td colspan=2 align=center bgcolor="#D5FFD5"><button type="submit" name="with" value="with"><u>W</u>ithdraw</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset"><u>R</u>eset</button></td> 
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2"><div align="center"><a href="withdrawal.jsp">Switch Account</a></div></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>