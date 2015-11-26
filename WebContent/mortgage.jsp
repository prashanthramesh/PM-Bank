<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
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
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="custHome.jsp">PM Online Banking System</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="active">
                        <a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a>
                    </li>
                    <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Account<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                        <%--  <li>
                                <a href='viewBalance.jsp=<%=session.getAttribute( "currentUser" )%>'>View Balance</a>
                            </li> --%>
                             <li>
                                <a href='viewTransaction.jsp=<%=session.getAttribute( "currentUser" )%>'>View Transaction</a>
                            </li>
                        </ul>
                    </li>
                     <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href='transfer.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Transfer<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='withdrawal.jsp?value=<%=session.getAttribute( "currentUser" )%>'>WithDraw</a>
                            </li>
                             <li>
                                 <a href='DepositMain.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Deposit</a>
                            </li>
                        </ul>
                    </li>
                    <li >
                        <a href='creditCard.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Credit Card</a>
                    </li>
                     <li >
                        <a href='paybills.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Pay Bills</a>
                    </li>
                    <li >
                        <a href='forgotPassword.jsp=<%=session.getAttribute( "currentUser" )%>'>Mortgage</a>
                    </li>
                     <li >
                        <a href='forgotPassword.jsp=<%=session.getAttribute( "currentUser" )%>'>Change Password</a>
                    </li>
                    
                    <li >
                        <a href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

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
<tr><td colspan=2 align=center><button type="submit"><u>A</u>pply for Mortgage</button></td></tr>	
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