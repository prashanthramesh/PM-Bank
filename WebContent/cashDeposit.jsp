<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.util.*" %>
<%@ include file="dbconn.jsp" %>
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
                        <a href="custHome.jsp">Home</a>
                    </li>
                    <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Account<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='viewBalance.jsp=<%=session.getAttribute( "currentUser" )%>'>View Balance</a>
                            </li>
                             <li>
                                <a href='viewTransaction.jsp=<%=session.getAttribute( "currentUser" )%>'>View Transaction</a>
                            </li>
                        </ul>
                    </li>
                     <li class = "dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href='transfer.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Transfer<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='withdraw.jsp=<%=session.getAttribute( "currentUser" )%>'>With Draw</a>
                            </li>
                             <li>
                                <a href='cashDeposit.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Deposit</a>
                            </li>
                        </ul>
                    </li>
                    <li >
                        <a href='creditCard.jsp=<%=session.getAttribute( "currentUser" )%>'>Credit Card</a>
                    </li>
                     <li >
                        <a href='paybill.jsp=<%=session.getAttribute( "currentUser" )%>'>Pay Bills</a>
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
   <p align=center>Please enter the amount to be deposited </p>
<form name="cashform" action="CashDeposit" onSubmit="return cashValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{	
	System.out.println("------------------> ACC TYPE -------"+session.getAttribute("AccountType").toString());
	System.out.println("------------------> AccountNo -------"+session.getAttribute("AccountNo").toString());
	
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
<td colspan=2 align=center><button type="submit" name="dePo" value="dePo"><u>D</u>eposit </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset"><u>R</u>eset</button></td> 
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2"><div align="center"><a href="DepositMain.jsp">Switch Account</a></div></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>