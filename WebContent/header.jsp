<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
                    <li>
                        <a href = 'viewTransaction.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Account</a>
                        </li>
                      
                    
                     <li class = "dropdown">
                        <a href='withdrawal.jsp?value=<%=session.getAttribute( "currentUser" )%>' class="dropdown-toggle" data-toggle="dropdown" >Transfer<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                                <a href='withdrawal.jsp?value=<%=session.getAttribute( "currentUser" )%>'>WithDraw</a>
                            </li>
                             <li>
                                 <a href='DepositMain.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Deposit</a>
                            </li>
                            
                        </ul>
                    </li>
                    <li>
                        <a href='creditCard.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Credit Card</a>
                    </li>
                     <li >
                        <a href='paybills.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Pay Bills</a>
                    </li>
                    <li >
                        <a href='mortgage.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Mortgage</a>
                    </li>
                     <li >
                        <a href="#vvv">Change Password</a>
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
</body>
</html>