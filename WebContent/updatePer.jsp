<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.security.*" %>
<%@ include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<title>Add User</title>
<script language="javascript" type="text/javascript">
function regValidation()
{

var firstName = document.registerform.fname;
var lastName = document.registerform.lname;
var dobDate = document.registerform.dob;
var mailID = document.registerform.email;
var phne = document.registerform.pnumber;
var password = document.registerform.pwd;



if(onlyAlphabets(firstName)){
if(onlyAlphabets(lastName)){
if(check()){
if(validDob(dobDate)){	
if(validEmail(mailID)){
if(validPhneNo(phne)){
if(validPassword(password)){

	document.forms[0].submit();
	return true;
}
}
}	
}	
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

function check(){	
optionLen = document.registerform.gen.length;
option = "";
for (i = 0; i <optionLen; i++) {
if (document.registerform.gen[i].checked) {
option = document.registerform.gen[i].value;
}
}

if (option == "") {
alert("Select the Gender");
return false;
}else
{
return true;
}
}

function validDob(dobirth)
{
var dateFormat = /^([0-9]{2})-([0-9]{2})-([0-9]{4})$/;
if(dobirth.value.match(dateFormat))
{
return true;	
}else{
alert('Date of Birth is Invalid \n Enter Date in MM-DD-YYYY Format');
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

function validPhneNo(phne)
{
var noFormat =  /^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}/;
if(phne.value.match(noFormat)){
return true;
} 
else
{
alert('Phone Number is Invalid');
return false;	
}
}

function validPassword(password)
{
var size = password.value.length;
if(size < 6 )
{
alert('Password must contain atleast six characters !! '); 
return false;
}
else
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
                <a class="navbar-brand" href="WelcomeAdmin.jsp">PM Online Banking System</a>
            </div>
            </div>
            </nav>
 <div class="container" style = "width:300px;">
<div class="row">
<fieldset>
<legend><b>Update </b></legend>
<h3 align=center> Personal Information</h3>
<p align=center>You can view and update your personal information here</p>
<form name="updateform" action="UserOpr" onSubmit="return updValidation();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{	
	String custID = request.getParameter("custid").trim();
	PreparedStatement state=connect.prepareStatement("SELECT * FROM account_details WHERE cust_ID=?");
	state.setString(1,custID);
	ResultSet result=state.executeQuery();
	
	while(result.next()){
		
		String FirstName=result.getString("first_name");
	    String LastName=result.getString("last_name");
	    String Dateofbirth=result.getString("dob");
	    String Gender=result.getString("gender");
	    String Email=result.getString("email");
	    String Number=result.getString("phone_no");		    
%>	
<tr>
<td height="25"><div align="right">First Name</div></td>
<td><input type="text" name="fname" value="<%=FirstName%>" /></td>
</tr>
<tr>
<td height="25"><div align="right">Last Name</div></td>
<td><input type="text" name="lname" value="<%=LastName%>" /></td>
</tr>
<tr>
<tr>
<td height="25"><div align="right">Gender</div></td>
<td><input type="text" name="gen" value="<%=Gender%>" /></td>
</tr>
<tr>
<tr>
<td height="25"><div align="right">Date of Birth</div></td>
<td><input type="text" name="dob" value="<%=Dateofbirth%>" maxlength="8"/></td>
</tr>
<tr>
<td height="25"><div align="right">Email</div></td>
<td><input type="text" name="email" value="<%=Email%>" /></td>
</tr>
<tr>
<td height="25"><div align="right">Phone Number</div></td>
<td><input type="text" name="pnumber" value="<%=Number%>" maxlength="10"></td>
</tr>
<tr><td><input name="custID" type="hidden"  value=<%=custID%>></td></tr>  
<%
}
	state.close();
	
}catch(Exception e){
	System.out.println("---------> error here cust id---->"+e.getMessage());
}
%>
<tr>
<td colspan=2 align=center><button style = "margin-top:20px;margin-left:75px;"class="btn btn-primary" type="submit" name="buttonVal" value="update">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button style = "margin-top:20px;" class="btn btn-primary" type="reset">Reset</button></td> 
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>