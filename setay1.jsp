<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SVECW -- Examination Portal</title>
</head>
<%@ page import = "dao.User" %>


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
else if(ur.getStatus().equals("ACE"))
	header="./aceheader.jsp";


	
%>
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String ay=miscUtil.noNull(request.getParameter("ay"));
String status=stdb.updateAy(ay);

%>

<jsp:include page='<%= header %>' flush="true" />

<body>
<div id="centre">
					
	
					    <center><h3>Set Academic Year</h3></center>
					    <br><br><br>
					    <CENTER>
					    
					   <h6><%=status %></h6>
					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>



</body>

</html>