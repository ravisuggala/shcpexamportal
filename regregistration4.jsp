<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>
<%@ page import = "dao.*,java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />


<%@ page import="dao.User"%>


<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
if(ur==null)
{
%>
<jsp:forward page="./index.jsp"></jsp:forward>
<%}
if(ur.getStatus().equals("admin"))
	header="./adminheader.jsp";
else if(ur.getStatus().equals("clerk"))
	header="./mainmenuheader.jsp";
else if(ur.getStatus().equals("office"))
	header="./feemenuheader.jsp";

	
%>

<jsp:include page='<%= header %>' flush="true" />




<%
Student st=(Student)session.getValue("student");




%>
	<div id="centre">
<center>
			<h2>External Examinations Registration</h2>
		</center>
		<CENTER>
		<br><br>
<!--  <font face=verdana size=4>Please Collect <font color="red"><%=st.getAmount() %>/-</font> cash from <font color="blue"><%=st.getRegdno() %> </font> for registering <font color="green"><%=st.getSubcount() %> </font>subjects and then-->
<font face=verdana size=4>Registration successfully done for </font><font color="blue"><%=st.getRegdno() %> </font>
<br> <br><a href="./regregistration1.jsp?type=REGULAR" > Click here for another Regular Examination Registration</a></font> 
		</CENTER>



	</div>


</html>