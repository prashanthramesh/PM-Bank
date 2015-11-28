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
<title>Insert title here</title>
</head>
<body>

    
    <fieldset>
<legend><b>Withdraw</b></legend>
<h3 align=center> Withdraw Portal</h3>
<p align=center>Please select the Account from which Money needs to be Withdrawn.</p>
<form name="withdrawform" action="withdrawMny.jsp" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0>
<tr> 
<tr>
<td><div style = "padding-right:10px;"align="right"> Select Account </div></td>
<%
String savAcc="";
String  chkAcc="";
try
{
    PreparedStatement state=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();
while(result.next())
  {
	savAcc=result.getString("savAcc");    
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
<select name="accOption">
  <option value="'sav'+<%=savAcc%>">Savings Account (<%=savAcc%>)</option>
  <option value="'chq'+<%=chkAcc%>">Chequing Account (<%=chkAcc%>)</option>
</select>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td width="43%">&nbsp;</td><tr>
<td colspan=2 align=center><button style = " margin-left: 65px;margin-top: -25px;" class="btn btn-primary" type="submit" name="withdraw" value="withdraw">Proceed to Withdraw</button>
</tr>
</table>
</form>
</fieldset>
</body>
</html>