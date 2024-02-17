<%@ page import="java.util.*,dao.*,java.text.SimpleDateFormat"%>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id="fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
String degree=miscUtil.getFromSession(request, response, "degree");
String branch=miscUtil.getFromSession(request, response, "branch");
String sem=miscUtil.getFromSession(request, response, "sem");
String ay=miscUtil.getFromSession(request, response, "ay");
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
	<p align=right style="margin-right: 75px;">
		Date:<%=cdate %></p>
<p style = "margin-left: 35px;">
	<%= degree %> <%=miscUtil.semDescription(sem,degree) %> ( <%=ay %>) 
	End Practical Examinations - <%=month %>  <br><br> 
<br><br><br>
	<table border="1" style="border-collapse: collapse;" align="center" height="70" width="400" cellpadding=10>
		<tr>
							    <Th nowrap>Dates</TH>
							    <Th nowrap>Name of the Subject &<br>code</TH>
							    <Th nowrap>No.of Batches</TH>
							    <Th>Name of the Internal Faculty</TH>
							    <Th>Name of the External Examiner & Address</TH>
				
		</tr>
		<%
					for(int i=0;i<sublist.size();i++)
					{
						Subject subject=(Subject)sublist.get(i);
						String date1=miscUtil.noNull(request.getParameter(subject.getCode()+"-date1"));
						date1=miscUtil.formatDate(date1,"yyyy-MM-dd", "dd-MM-yyyy");
						String date2=miscUtil.noNull(request.getParameter(subject.getCode()+"-date2"));
						date2=miscUtil.formatDate(date2,"yyyy-MM-dd", "dd-MM-yyyy");
						String date3=miscUtil.noNull(request.getParameter(subject.getCode()+"-date3"));
						date3=miscUtil.formatDate(date3,"yyyy-MM-dd", "dd-MM-yyyy");
						String date4=miscUtil.noNull(request.getParameter(subject.getCode()+"-date4"));
						date4=miscUtil.formatDate(date4,"yyyy-MM-dd", "dd-MM-yyyy");
						
						String dates=date1;
						if(!date2.equals(""))
							dates=dates+"<br>&<br>"+date2;
						if(!date3.equals(""))
							dates=dates+"<br>&<br>"+date3;
						if(!date4.equals(""))
							dates=dates+"<br>&<br>"+date4;
									
						String batch=miscUtil.noNull(request.getParameter(subject.getCode()+"-batch"));
						String dept=miscUtil.noNull(request.getParameter(subject.getCode()+"-dept"));
						String fname=new FacultyDB().getFacultyName(miscUtil.noNull(request.getParameter(subject.getCode()+"-if")));
						String ifname=fname+"<br>"+dept+"<br>SVCP,Bhimavaram";
						String address=miscUtil.noNull(request.getParameter(subject.getCode()+"-address"));
						address=address.replaceAll("\n", "<br>");
						
						String codename=subject.getSname()+"("+subject.getCode()+")";
				   %>
		<tr>
			<td nowrap align=center><%=dates %></td>
			<td nowrap><%= codename %>
			<td nowrap><%= batch %>
			<td nowrap><%= ifname %>
			<td nowrap><%= address %>
			
			 <%} %>
	</table>
<br><br>
<p style = "margin-left: 35px;">Copy to: Director, Principal-SVCP.</p>
<br><br><br>

<div class="left-col">Controller of examinations</div>
<div class="center-col">Principal</div>
<div class="right-col">Director</div>


</body>
</html>