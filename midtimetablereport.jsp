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

ArrayList sublist=(ArrayList)session.getValue("subjects");
MidExamDB medb=new MidExamDB();
for(int i=0;i<sublist.size();i++)
{
	TestDates td=new TestDates();
	td.setDegree(degree);
	td.setBranch(branch);
	td.setAy(ay);
	td.setSem(sem);
	
	Subject sub=(Subject)sublist.get(i);
	td.setSubcode(sub.getCode());
	String middate=miscUtil.noNull(request.getParameter("date-"+sub.getCode()));
	middate=miscUtil.formatDate(middate, "yyyy-MM-dd", "dd-MMM-yyyy");
	td.setTestValue(midno, middate);
	
	ArrayList sections=new StudentDB().getSectionsList(degree,branch,sem);
	for(int j=0;j<sections.size();j++)
	{
		td.setSection(sections.get(j).toString());
		medb.insertTestDates(td);
	}
}


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
<font size=5>
	<p align=right style="margin-right: 75px;">
		Date:<%=cdate %></p>
<p style = "margin-left: 35px;">
	<%= degree %> <%=miscUtil.semDescription(sem,degree) %> ( <%=ay %>) <%=miscUtil.midDescription(midno) %> 
	Examinations <%=month %>  are scheduled as follows: <br><br> Time: <%= time %>
<br><br><br>
	<table border="1" style="border-collapse: collapse;" align="center" height="70" width="400" cellpadding=10>
		<tr>
			<td><b>Day & Date</b></td>
			<td><b><%=degree %>(Subject & Code)</b></td>
		</tr>
		<%
					for(int i=0;i<sublist.size();i++)
					{
						Subject subject=(Subject)sublist.get(i);
						String condate=miscUtil.formatDate(miscUtil.noNull(request.getParameter("date-"+subject.getCode())),"yyyy-MM-dd", "dd-MMM-yyyy (E)");
					
				   %>
		<tr>
			<td nowrap><%=condate %></td>
			<td nowrap><%=subject.getSname() %>(<%=subject.getCode() %>)
			
			 <%} %>
	</table>
<br><br>
<p style = "margin-left: 35px;">Copy to: Director, Pharmacy colleges, Principal-SVCP, Office and website copy.</p>
<br><br><br>
<p style = "margin-left: 35px;">
<table  align="center" width="100%">
<tr>
<td width="30%" height="30%">
Controller of examinations</td>
<td width="30%" height="30%"><br> UG Coordinator</td>
<td width="30%" height="30%"><br>Principal  </td>
<td width="30%" height="30%"><br>Director</td>
</table>
</p>

</font>

</body>
</html>