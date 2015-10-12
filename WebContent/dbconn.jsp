<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
	Connection connect=null;
	try{
	Class.forName("com.mysql.jdbc.Driver");
	connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root", "password123");
    System.out.println("DB Connection created here 1:"+connect);
	}
	catch(Exception e)
	{ 
	e.printStackTrace();
	}
%>