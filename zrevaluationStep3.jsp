<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Revaluation Registration</title>
		<link rel="stylesheet" href="./CSS/styles.css" />
</head>
<%@ page import = "dao.*,java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<body>
<%
String regdno=miscUtil.noNull(request.getParameter("regdno"));
session.putValue("regdno", regdno);
String sem=session.getValue("sem").toString();
String examname=session.getValue("examname").toString();
String regvalue=session.getValue("regvalue").toString();
out.println("<br><br><center><h6>Selected Hallticket Number:"+regdno+"</h6></center><br>");
MasterMarksDB mmdb=new MasterMarksDB();
ArrayList subjs=mmdb.getRegisteredSubjects(regdno, sem,regvalue,examname);
%>
<FORM NAME = REGISTER METHOD = POST ACTION = "./revsave.jsp">

<table border=1 align=center>
<tr>
<th>Sl.No</th>
<th>Subject Code</th>
<th>Name of the Subject </th>
<th>Check</th>
<%
for(int i=0;i<subjs.size();i++)
{
	Subject sub=(Subject)subjs.get(i);
%>
	<tr>
	<td><%= i+1%>
	<td><%=sub.getCode() %></td>
	<td><%=sub.getSname() %>
	<td><input type=checkbox name=subjects value=<%=sub.getCode()%>></td>
	</tr>
	
<% }%>

<tr>
<td colspan=4 align=center><input type=submit value=Register></td>
</table>




</body>
</html>