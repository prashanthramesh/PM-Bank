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

<title>Mortgage</title>
<script language="javascript" type="text/javascript">
function cashValid()
{

var amount = document.mortgageform.mortamt;

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
	alert('Please enter Mortgage Amount ');
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
<legend><b> Mortgage</b></legend>
<h3 align=center> Mortgage Information </h3>
<p align=center><b>Please find your Mortgage Information below </b></p>
&nbsp;
<form name="mortgageform" action="ReqMortgage" onSubmit="return cashValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{
	PreparedStatement state=connect.prepareStatement("SELECT * FROM MORTGAGE WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();;
	
	if(result.next()){
		
		String id=result.getString("id");
	    String Amtneed=result.getString("Totalamount");
	    String intrestRate=result.getString("intrestRate");
	    String timeyr=result.getString("timeyr");
	    String timesan=result.getString("timesan");
	    String extime=result.getString("extime");
	    String Mortgageamt=result.getString("Mortgageamt");
	    String Mortreason=result.getString("mortReason");
%>
<tr align=center><td><b>ID </b></td>
<td><b>Reason </b></td>
<td><b>Mortgage Amount :</b></td>
<td><b>Amount to Pay :</b></td>
<td><b>Interest Rate :</b></td>
<td><b>Date Sanctioned :</b></td>
<td><b>Expiry Date :</b></td>
</tr>
<tr align=center><td><%=id %></td>
<td><%=Mortreason %></td>
<td><%=Mortgageamt %></td>
<td><%=Amtneed %></td>
<td><%=intrestRate %></td>
<td><%=timesan %></td>
<td><%=extime %></td>
</tr>
<tr><td colspan=2 align=center><button type="submit"><u>P</u>ay Mortgage</button></td></tr>
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>	     	      	    
<%    
	    
	}else
	{
%>
<tr><td>&nbsp;</td></tr>
<tr><p align=center>No Mortgage Issued  </p></tr>
<tr><p align=center>Please apply for a new Mortgage  </p></tr>
<tr>
<td height="25"><div align="center">Enter Mortgage amount </div></td>
<td><input type="text" name="mortamt" value="" ></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align=center>Select Year and Interest </td><td>
<select style="width: 150px;" name="mortReason">
<option value="'1 Year 2.89'">1 Year - 2.89 % </option>
  <option value="'2 Year 2.84'">2 Year - 2.84 % </option>
  <option value="'3 Year 3.39'">3 Year - 3.39 % </option>
  <option value="'4 Year 3.89'">4 Year - 3.89 % </option>
  <option value="'5 Year 4.64'">5 Year - 4.64 % </option>
</select>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align=center>Select Reason </td><td>
<select style="width: 150px;" name="mortReason">
  <option value="'NewHouse'">New House </option>
  <option value="'RefinancingMortgage'">Refinancing Mortgage </option>
</select>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=2 align=center><button style = "margin-top:-20px;margin-left:85px;"class="btn btn-primary" type="submit">Apply for Mortgage</button></td></tr>	
<tr><td>&nbsp;</td></tr>
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>		
<%		
	}
	state.close();
	connect.close();
} catch (Exception e) {	
	System.out.println("----------> error ------>"+e.getMessage());
}
 %>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>