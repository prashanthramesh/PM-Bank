<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<title>Login</title>
<script language="javascript" type="text/javascript">
function loginValidation()
{
var fname = document.loginform.fname;
var pwd = document.loginform.password;

if(validcardNo(fname)){
if(validPassWrd(pwd)){
	document.forms[0].submit();
	return true;

}
}
return false;
}

function validcardNo(fname)
{
	
	
var Len = fname.value.length;
var noFormat = /^\d+$/;
if(Len == 0)
{
alert('Username should not be empty !!!!'); 
return false;
}
if(Len < 1)
{
alert('Invalid customer name'); 
return false;
}

if(Len.value.match(noFormat)){
	return true;
	} 
	else
	{
	alert('Username is Invalid \n');
	return false;	
	}
}

function validPassWrd(pwd)
{
	
var passLen = pwd.value.length;
if(passLen == 0)
{
alert('Password must not be Empty'); 
return false;
}else
{
return true;
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
                <a class="navbar-brand" href="index.jsp">PM Online Banking System</a>
            </div>
            </div>
            </nav>
<div class="container" style = "width:250px ! important;">
<div class="row">
            
                <h3>Login</h3>
                <form  name="loginform" action="login" onSubmit="return loginValidation();" method="post"id="contactForm">
                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Account Number:</label>
                            <input type="text" class="form-control" name = "fname"required data-validation-required-message="Please enter your Account Number.">
                            <p class="help-block"></p>
                        </div>
                    </div>
                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Password:</label>
                            <input type="password" class="form-control"name = "password" required data-validation-required-message="Please enter your passowrd.">
                        </div>
                    </div>
                    <!-- For success/fail messages -->
                    <button type="submit" class="btn btn-primary">Login</button>
                   <a href="signup.jsp"> <div class="btn btn-primary" style = "float:right;">Sign Up</div></a>
                </form>
                <p style = "margin-top:10px;">
                 <a href="forgotPassword.jsp">Forgot Password</a></p>
            </div>
            </div>
</body>
       


</html>