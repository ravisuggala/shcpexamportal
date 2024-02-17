<!DOCTYPE html>

<head>
<style>
.center {
	display: block;
	margin-left: auto;
	margin-right: auto;
	width: 50%;
}

.imgright {
	float: right;
	margin: 0 0 0 15px;
}

.imgleft {
	float: left;
	margin: 0 0 0 15px;
}
</style>

</head>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="dao.User,dao.StudentDB,java.util.ArrayList,dao.FBSMiscUtilitiesBean,dao.SubjectDB,dao.FacultyDB"%>
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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";

ArrayList regs=new StudentDB().getRegulations();
	
%>
<% 
FBSMiscUtilitiesBean utility=new FBSMiscUtilitiesBean(); 
String degree=utility.noNull(request.getParameter("degree"));
String branch=utility.noNull(request.getParameter("branch"));
String sem=utility.noNull(request.getParameter("sem"));
String ay=utility.noNull(request.getParameter("ay"));
String reg=utility.noNull(request.getParameter("reg"));
String subject=utility.noNull(request.getParameter("subject"));
subject=new SubjectDB().getSubjectTitle(subject, reg)+" ( "+subject+" )";
String date1=utility.noNull(request.getParameter("date1"));
String date2=utility.noNull(request.getParameter("date2"));
String cdate=utility.noNull(request.getParameter("cdate"));
String fname=utility.noNull(request.getParameter("fname"));
fname=new FacultyDB().getFacultyName(fname);
String address=utility.noNull(request.getParameter("address"));
address=address.replaceAll("\n", "<br>");

String examname=degree+" "+utility.semDescription(sem,degree) +"  ("+ay+" ) - End Practical Examinations";
date1=utility.formatDate(date1, "yyyy-MM-dd", "dd-MM-yyyy (E)");
date2=utility.formatDate(date2, "yyyy-MM-dd", "dd-MM-yyyy (E)");
cdate=utility.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");

%>
<body>
	<button onClick="window.print()" style="float: right;">
		<img alt="No Image" height="25px" width="25px" src="./imgs/print.png">
	</button>
	

	<font size="4"> 
	<img src="./imgs/letterhead.jpg"></img>
		<p align=right style = "margin-right: 75px;">	Date:<%=cdate %></p>
		<p style = "margin-left: 35px;">Dear Sir/Madam,
		<p align=center>Sub: Appointment of Internal Examiner - Reg</p>
		<br>
		<p style = "margin-left: 35px;margin-right: 75px;">This is to inform you that you are appointed as Internal
			Examiner for the following Examinations. Please accept the offer and
			kindly intimate your acceptance by return mail.</p></font><br>
	<table border="1" style="border-collapse: collapse;" align="center" height="250" cellpadding=5>
		<tr>
			<td colspan="2" align=center><b>Name of the Examination</b></td>
			<td align=center><b>Name and <br>Address of the Internal Examiner</b></td>
		</tr>
		<tr>
			<td colspan="2"><%=  examname%></td>
			<td rowspan="4"><%= fname + "<br>"+address %></td>
		</tr>
		<tr>
			<td>Subject</td>
			<td><%= subject %></td>
		</tr>
		<tr>
			<td>Centre</td>
			<td>Sri Vishnu College of Pharmacy, Vishnupur,
				Bhimavaram,534202, West Godavari District.</td>
		</tr>
		<tr>
			<td>Dates</td>
			<td><%=date1 +" & "+ date2 %></td>
		</tr>
	</table>
	<br><br>
	<font size="4"><p>
			<p style = "margin-left: 35px;">Thanking you,<br><br>
			<p style = "margin-left: 35px;"><br> With regards,<br> Exam Branch, SVCP
		</p></font>
</body>
</html>