<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
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
                <a class="navbar-brand" href='WelcomeAdmin.jsp'>PM Online Banking System</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href='WelcomeAdmin.jsp'>Home</a>
                    </li>
                 
                     
                     <li class = "dropdown">
                        <a href='pendAccReq.jsp' class="dropdown-toggle" data-toggle="dropdown" >Approve User<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                         <li>
                      
                                <a href='custRegister.jsp'>Add User</a>
                            </li>
                             <li>
                                 <a href='UpdateUser.jsp'>Update User</a>
                            </li>
                             <li>
                                 <a href='DeleteUser.jsp'>Delete User</a>
                            </li>
                        </ul>
                    </li>
                    <li >
                        <a href='custTransaction.jsp'>Transaction History</a>
                    </li>
                     <li >
                        <a href='custWithdraw.jsp'>Withdraw</a>	
                    </li>
                                         <li >
                        <a href='custDeposit.jsp'>Deposit</a>
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