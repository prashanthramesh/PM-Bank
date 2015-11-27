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

<title>CreditCard</title>
</head>
<body>
<fieldset>
<legend><b> Fixed</b></legend>
<h3 align=center> Investment in Fixed Deposit </h3>
<p align=center><b>Please select the Amount and Time period to invest</b></p>
<form name="shareform" action="FixedDepInv" onSubmit="return payValid();" method="post">
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
<tr><td height="25"><div align="right">Select no of Months :</div></td>
<td><select style="width: 270px;" name="fdOption">
<%
PreparedStatement state;
ResultSet result;
try
{	    
	    state =connect.prepareStatement("SELECT * FROM FDPRE");		
		result=state.executeQuery();
		
		while(result.next()){
%>			
			<option value="<%=result.getString("TIMEPERIOD")+"/"+result.getString("RATEINTRST")%>"><%=result.getString("TIMEPERIOD")+" - Interest "+result.getString("RATEINTRST")+"%"%></option>
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
<td height="25"><div align="right">Amount to Invest :</div></td>
<td><input type="text" name="invamt" value="" ></td>
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