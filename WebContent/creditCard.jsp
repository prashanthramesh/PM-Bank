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

<title>Withdraw</title>
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
<legend><b> Credit Card</b></legend>
<h3 align=center> Credit Card Information </h3>
<p align=center><b>Please find your Credit Card Information below </b></p>
<form name="creditform" action="ReqCreditCard" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{
	PreparedStatement state=connect.prepareStatement("SELECT * FROM CREDITCARD WHERE "+session.getAttribute( "currentID" ));
	ResultSet result=state.executeQuery();
	
	if(result.next()){
		
		String CardNo=result.getString("CARD_NO");
	    String CredAmt=result.getString("CRED_AMT");
	    String DebitAmt=result.getString("DEBIT_AMT");
	    String CcvNo=result.getString("CCV_NO");
	    String Exp_date=result.getString("EXPIRY_DATE");
%>
<tr align=center><td><b>Credit Card No :</b></td><td align=left><%=CardNo %></td></tr>
<tr align=center><td><b>Credit Amount :</b></td><td align=left><%=CredAmt %></td></tr>
<tr align=center><td><b>Debit Amount :</b></td><td align=left><%=DebitAmt %></td></tr>
<tr align=center><td><b>CCv No :</b></td><td align=left><%=CcvNo %></td></tr>
<tr align=center><td><b>Expiry Date :</b></td><td align=left><%=Exp_date %></td></tr>
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentID" )%>'>Home</a></div></td></tr>	     	      	    
<%    
	    
	}else
	{
%>
<tr><td><p align=center><b>No Credit Card Issued </b></p></td></tr>
<tr><td><p align=center>Please apply for a new credit card</p></td></tr>
<tr><td colspan=2 align=center bgcolor="#D5FFD5"><button type="submit"><u>A</u>pply Credit Card</button></td></tr>	
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentID" )%>'>Home</a></div></td></tr>		
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