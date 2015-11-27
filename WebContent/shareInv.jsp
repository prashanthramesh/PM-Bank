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
<script language="javascript" type="text/javascript">
function payValid()
{
var noofShr = document.shareform.shrNo;


if(validRecNo(noofShr)){
	return true;

}
return false;		
}


function validRecNo(noofShr)
{
var len = noofShr.value.length;
var noFormat = /^\d+$/;
if(len == 0)
{
	alert('Please enter valid number of shares to Invest');
	return false;	
}
if(noofShr.value.match(noFormat)){
return true;
} 
else
{
alert('Entered No of share is Invalid');
return false;	
}
}

</script>
<title>Customer Home Page</title>
</head>
<body>
<body>
    
<fieldset>
<legend><b> Shares</b></legend>
<h3 align=center> Investment in Shares </h3>
<p align=center><b>Share details are been listed as per present day Price </b></p>
<form name="shareform" action="ShareInv" onSubmit="return payValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{	
	System.out.println("------------------> ACC TYPE -------"+session.getAttribute("InvAccountType").toString());
	System.out.println("------------------> AccountNo -------"+session.getAttribute("InvAccountNo").toString());
	
	String AccountType = session.getAttribute("InvAccountType").toString();
	String AccountNo = session.getAttribute("InvAccountNo").toString();	
	String Balance = null;
	PreparedStatement state;
	ResultSet result;
	
	if(AccountType.equals("Savings"))
	{
		state =connect.prepareStatement("SELECT * FROM SAVACC WHERE SAVACCNO=?");	
		state.setString(1,AccountNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("ACC_BALANCE");
		}
	
	}else{
		
		state =connect.prepareStatement("SELECT * FROM CHCKACC WHERE CHCKACCNO=?");	
		state.setString(1,AccountNo);
		result=state.executeQuery();
		
		while(result.next()){			
			Balance=result.getString("ACC_BALANCE");
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
<tr><td><input type="hidden" name="accType" value=<%=AccountType%>></td><td><input type="hidden" name="balAmt" value=<%=Balance%>></td><td><input type="hidden" name="accno" value=<%=AccountNo%>></td></tr>  
 <%
  
}catch(Exception e){
System.out.println("---------> error here DEPOSIT DETAIL CASH---->"+e.getMessage());
}
%>
<tr><td height="25"><div align="right">Select Share detail :</div></td>
<td><select style="width: 300px;" name="shrOption">
<%
PreparedStatement state;
ResultSet result;
try
{	    
	    state =connect.prepareStatement("SELECT * FROM SHAREPRE");		
		result=state.executeQuery();
		
		while(result.next()){
%>			
			<option value="<%=result.getString("COMPNAME")+"/"+result.getString("RATEPERSHARE")%>"><%=result.getString("COMPNAME")+" - Per Share "+result.getString("RATEPERSHARE")+"$"%></option>
<%			
		 }
		 
		  result.close();
		  state.close();
 %>
 </select></td></tr>
 <%
}catch(Exception e){
	System.out.println("---------> error here DEPOSIT DETAIL CASH---->"+e.getMessage());	
}
%>
<tr>
<td height="25"><div align="right">Number of Investing Shares :</div></td>
<td><input type="text" name="shrNo" value="" ></td>
</tr>
<tr>
<td colspan=2 align=center bgcolor="#D5FFD5"><button type="submit" name="tranmny" value="tranmny"><u>I</u>nvest </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset"><u>R</u>eset</button></td> 
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2"><div align="center"><a href="investMain.jsp">Switch Investment Type \ Account</a></div></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>