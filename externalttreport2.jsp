<%@ page import="java.util.*,dao.*,java.text.SimpleDateFormat"%>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id="fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%

String exam=miscUtil.noNull(request.getParameter("examname"));
String type=miscUtil.noNull(request.getParameter("type"));
ExternalExam ee=new ExternalExamDB().getExamInfo(exam);
String time=new ExternalExamDB().getExamTime(exam);
String degree=ee.getDegree();
String sem=ee.getSem();
String ay=ee.getAy();

String month=ee.getMonth();
String cdate=miscUtil.noNull(request.getParameter("cdate"));
cdate=miscUtil.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");


ArrayList sublist=new ExternalExamDB().getExamTimeTable(exam);


%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<style>


.left-col {
    float: left;
    width: 40%;
}
.center-col {
    float: left;
    width: 45%;
}
.right-col {
    float: left;
    width: 15%;
}

</style>

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
	<%= degree %> <%=miscUtil.semDescription(sem,degree) %> ( <%=ay %>) End (<%= type%>) Examinations to be held in <%=month %> 
	  are scheduled as follows: <br><br> Time: <%= time %>
<br><br><br>
	<table border="1" style="border-collapse: collapse;" align="center" height="70" width="95%" cellpadding=10>
		<tr>
			<td><b>Sl.No</b></td>
			<td><b>Day & Date</b></td>
			<td><b>Subject Code</b></td>
			<td><b>Subject Name</b></td>
		</tr>
		<%
					for(int i=0;i<sublist.size();i++)
					{
						TestDates subject=(TestDates)sublist.get(i);
						String condate=subject.getExternal();
						String subcode=subject.getSubcode();
						String subname=subject.getSubname();
					
				   %>
		<tr>
			<td nowrap><%=i+1 %></td>
			<td nowrap><%=condate %></td>
			<td nowrap><%=subcode %>
			<td><%=subname %>
			
			 <%} %>
	</table>
<br><br>
<p style = "margin-left: 35px;">Copy to: Director, Pharmacy colleges, Principal-SVCP, Office and website copy.</p>
<br><br><br>
<div class="left-col">Controller of examinations</div>
<div class="center-col">Principal</div>
<div class="right-col">Director</div>

</body>
</html>