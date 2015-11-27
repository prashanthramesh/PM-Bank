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
<script>
function cashValid()
{

var amount = document.cashform.depamt.value;

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
<title>CashDeposit</title>

</head>
<body>

    
    
 <fieldset>
<legend><b> Investments</b></legend>
<h3 align=center> Investment Portal </h3>
<p align=center><b>Please Select Account and Investment Option below </b></p>
<form name="investform" action="InvestAmtType" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td width="43%">&nbsp;</td>
</tr> 
<tr> 
<tr><td><div align="center"><b>Select Investment Type </b></div></td><tr>
<tr><td>&nbsp;</td></tr>
<tr><td align="right"><input type="radio" name="type" value="share" checked>Invest in Shares<br></td>
<td align="center"><input type="radio" name="type" value="fixeddep">Invest in Fixed Deposit<br></td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td><div align="right">Account </div></td>
<%
String SaccNo="";
String ChaccNo="";
try
{
	PreparedStatement state=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();
while(result.next())
  {
      SaccNo=result.getString("savAcc");   
  }	
result.close();  

PreparedStatement state1=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
state1.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
ResultSet result1=state1.executeQuery();
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
</tr>
<tr><td width="43%">&nbsp;</td><tr>
<td colspan=2 align=center><button type="submit" name="invest" value="invest">Proceed to Investment</button>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>