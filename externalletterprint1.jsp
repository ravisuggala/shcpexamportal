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

String subjects=utility.noNull(request.getParameter("selsubjects"));
String selsubjects[]=subjects.split(",");
String subject="";
for(int i=0;i<selsubjects.length;i++)
	subject+=new SubjectDB().getSubjectTitle(selsubjects[i], reg)+" ( "+selsubjects[i]+" ),";
subject=subject.substring(0,subject.lastIndexOf(","));

String date1=utility.noNull(request.getParameter("date1"));
String date2=utility.noNull(request.getParameter("date2"));
//System.out.println(date2);
String cdate=utility.noNull(request.getParameter("cdate"));
String fname=utility.noNull(request.getParameter("fname"));
String valuation=utility.noNull(request.getParameter("valuation"));

String address=utility.noNull(request.getParameter("address"));
address=address.replaceAll("\n", "<br>");

String examname=degree+" "+utility.semDescription(sem,degree) +"  ("+ay+" ) - End  Examinations";
String course=degree+" "+utility.semDescription(sem,degree) +"  ("+ay+" )";
date1=utility.formatDate(date1, "yyyy-MM-dd", "dd-MM-yyyy (E)");
date2=utility.formatDate(date2, "yyyy-MM-dd", "dd-MM-yyyy (E)");
cdate=utility.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");
String ref="Ref:"+degree+".Exams/"+ay;
if(!date2.equals(""))
	date1=date1 +" & "+ date2;

%>
<body>
	<button onClick="window.print()" style="float: right;">
		<img  alt="No Image" height="25px" width="25px" src="./imgs/print.png">
	</button>
	

	<font size="4"> 
	<p style="text-align: center;">

	<img src="./imgs/letterhead.jpg" align=center style="float: center;"></img>
</p>		
		<p style="text-align:left;margin-left: 85px;margin-right: 75px;">
 			<%=ref %> 
    			<span style="float:right;">
        				Date:<%=cdate %>
    			</span>
		</p>
		
		<p align=left style = "margin-left: 35px;">
		To,<br>
		<%=address %>
		
		</p>
		<p style = "margin-left: 35px;">Dear Sir/Madam,
		<p align=center>Sub: Appointment of Theory Paper Evaluator - Reg</p>
		<br>
		
<p style = "margin-left: 35px;margin-right: 75px;">
We hereby invite you as Theory Paper Evaluator for evaluating theory paper for the following Examination, as mentioned below.
</p>
	<table border="1" style="border-collapse: collapse;" align="center" height="250" cellpadding=5>
		<tr>
			<td colspan="2" align=center><b>Name of the Examination</b></td>
			
		</tr>
		<tr>
			<td colspan="2" align=left><%=examname %></td>
			
		</tr>

		<tr>
			<td >Subject Code & Name</td>
			<td><%= subject %> - Only Theory Paper Valuation</td>
		</tr>
		
		<tr>
			<td>Centre</td>
			<td>Sri Vishnu College of Pharmacy, Vishnupur,<br>
				Bhimavaram,534202, West Godavari District.</td>
		</tr>
		<tr>
			<td>Dates</td>
			<td><%=date1  %></td>
		</tr>
	</table>
	<br><br>
	<p style = "margin-left: 35px;margin-right: 75px;">
	The following points may please be noted:
    <ul>
        <li>    Please send your acceptance without fail after receipt of this letter.  Your acceptance may be conveyed either by Through e-mail to exams@svcp.edu.in or  Mobile:8332950863.
	    
	</ul>
	
	<font size="4"><p>
			<p style = "margin-right: 75px;" align=right>Thanking you,<br><br>
			<p style = "margin-right: 75px;" align=right>Yours Sincerely
		</p></font>
		<p style = "margin-left: 35px;margin-right: 75px;">
		<img src="./excelfiles/photos/ce.jpg" height="50px" ><br>
					Controller of Examinations
		
</body>
</html>