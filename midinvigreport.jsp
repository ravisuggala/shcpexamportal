<%@ page import="java.util.*,dao.*,java.text.SimpleDateFormat"%>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id="fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
String degree=miscUtil.getFromSession(request, response, "degree");
String branch=miscUtil.getFromSession(request, response, "branch");
String sem=miscUtil.getFromSession(request, response, "sem");
String ay=miscUtil.getFromSession(request, response, "ay");
String midno=miscUtil.getFromSession(request, response, "midno");
String time=miscUtil.getFromSession(request, response, "time");
String month=miscUtil.getFromSession(request, response, "month");
String cdate=miscUtil.getFromSession(request, response, "cdate");
String reg=miscUtil.getFromSession(request, response, "reg");

ArrayList sublist=(ArrayList)session.getValue("subjects");



%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
	<button onClick="window.print()" style="float: right;">
		<img alt="No Image" height="25px" width="25px" src="./imgs/print.png">
	</button>

	<img src="./imgs/letterhead.jpg"></img>
	<p align=right style="margin-right: 75px;">
		Date:<%=cdate %></p>
<p style = "margin-left: 35px;">
	<%= degree %> <%=miscUtil.semDescription(sem,degree) %> ( <%=ay %>) <%=miscUtil.midDescription(midno) %> 
	Examinations to be held in <%=month %>  are scheduled as follows: <br><br> Time: <%= time %>
<br><br><br>
	<table border="1" style="border-collapse: collapse;" align="center" height="70" width="400" cellpadding=10>
		<tr>
			<td><b>Day & Date</b></td>
			<td><b><%=degree %>(Subject & Code)</b></td>
			<td nowrap><b>Signatures of Invigilators</b></td>
		</tr>
		<%
					for(int i=0;i<sublist.size();i++)
					{
						TestDates subject=(TestDates)sublist.get(i);
						String condate=miscUtil.formatDate(miscUtil.noNull(subject.getTest(midno)),"dd-MMM-yyyy", "dd-MMM-yyyy (E)");
						String param="f-"+subject.getSubcode();
				   %>
		<tr>
			<td nowrap><%=condate %></td>
			<td nowrap><%=new SubjectDB().getSubjectTitle(subject.getSubcode(), reg)+"("+subject.getSubcode()+")" %>
			<td nowrap><%=request.getParameter(param).substring(1) %>
			
			 <%} %>
	</table>
<br><br>
<p style = "margin-left: 35px;">Copy to: Director, Pharmacy colleges, Principal-SVCP, Office and website copy.</p>
<br><br><br>
<p>
Note:<br>
All the staff must adhere to the Examination schedules., Invigilation in particular. In case of any emergency, 
they will have to make the alternative arrangement by themselves. Your co-operation is highly appreciated.
</p>
<br><br><br>
<p align=right style = "margin-right: 35px;margin-left: 355px;">
<table  align="right">
<tr>
<td height="30%">
Controller of examinations</td>
</table>
</p>
</body>
</html>