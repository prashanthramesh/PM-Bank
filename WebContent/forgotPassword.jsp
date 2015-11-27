<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<title>Forgot Password</title>
<script language="javascript" type="text/javascript">
function loginValidation()
{
var lname = document.forgetform.lname;
var dob = document.forgetform.dob;
var mail = document.forgetform.email;

if(onlyAlphabets(lname)){
if(validDob(dob)){
if(validEmail(mail)){
	document.forms[0].submit();
	return true;
}
}
}
return false;
}

function onlyAlphabets(Name)  
{   
var words = /^[A-Za-z]+$/;  
if(Name.value.match(words))  
{  
return true;  
}  
else  
{  
alert('Name is required and must be Alphabets');  
return false;  
}
}

function validDob(dobirth)
{
var dateFormat = /^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/g;
if(dobirth.value.match(dateFormat))
{
return true;	
}else{
alert('Date of Birth is Invalid \n Enter Date in MMDDYYYY Format');
return false;
}
}

function validEmail(mailID)
{
var idFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;	
if(mailID.value.match(idFormat))  
{  
return true;  
}  
else  
{  
alert('Email ID is Invalid');  
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
                <a class="navbar-brand" href="index.jsp">PM Online Banking System</a>
            </div>
            </div>
            </nav>
<div class="container" style = "width:300px;">
<div class="row">
<h3 align=center> Forgot Credentials</h3>
<p align=center>Please provide the informations below as provided while Account Creation </p>
<form name="forgetform" action="forgot" onSubmit="return loginValidation();" method="post" style = "line-height:30px;">
<div class="controls">
Last Name
<input class="form-control"  type="text" name="lname" value="" />
</div>
<div class="controls">
Date of Birth
<input class="form-control" type="text" name="dob" value="" maxlength="20"/>
</div>
<div class="controls">
Email
<input class="form-control" type="text" name="email" value="" />
</div>
<div class="controls">
New Password</div></td>
<input class="form-control" type="password" name="password" value="" />

<button style = "margin-top:10px;" class="btn btn-primary" type="submit">Change Password</button>&nbsp;<button style = "margin-top:10px;" class="btn btn-primary" type="reset"><u>R</u>eset</button>
</form>
</div>
<div>
</body>
</html>