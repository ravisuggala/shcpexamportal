<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> SHCP -- Examination Registrations</title>

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
<font face=verdana size=5>Registration successfully done for </font><font color="blue" size=5><%=st.getRegdno() %> </font>
<br> <br><font face=verdana size=6 color=green><a href="./registration1.jsp?type=<%=st.getType() %>" > Click here for another <%=st.getType() %> Examination Registration</a></font> 
		</CENTER>



	</div>


</html>