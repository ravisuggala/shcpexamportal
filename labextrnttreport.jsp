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
String ndays=miscUtil.getFromSession(request, response, "days");
String nbatches=miscUtil.getFromSession(request, response, "batches");
int idays=Integer.parseInt(ndays);
int ibatches=Integer.parseInt(nbatches);

ArrayList sublist=(ArrayList)session.getValue("subjects");

String subjects[][]=new String[idays+1][ibatches+1];

String days[]=new String[idays+1];
String fromtime[]=new String[ibatches+1];
String totime[]=new String[ibatches+1];

for(int i=1;i<=ibatches;i++)
{
	String fromt=miscUtil.noNull(request.getParameter("fromtime"+i));
	String tot=miscUtil.noNull(request.getParameter("totime"+i));
	fromtime[i]=new SimpleDateFormat("hh:mm a").format(new SimpleDateFormat("HH:mm").parse(fromt));
	totime[i]=new SimpleDateFormat("hh:mm a").format(new SimpleDateFormat("HH:mm").parse(tot));
}
	

for(int i=1;i<=idays;i++)
{
	days[i]=miscUtil.formatDate(miscUtil.noNull(request.getParameter("day"+i)),"yyyy-MM-dd", "dd-MMM-yyyy (E)");
	days[i]=days[i].substring(0,days[i].indexOf("("))+"<br>"+days[i].substring(days[i].indexOf("("));
	for(int j=1;j<=ibatches;j++)
	{
		String param="day"+i+"batch"+j;
		String subcode=miscUtil.noNull(request.getParameter(param));
		subjects[i][j]=new SubjectDB().getSubjectTitle(subcode, reg)+" ("+subcode+")";
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
	<%= degree %> <%=miscUtil.semDescription(sem,degree) %> ( <%=ay %>)
	End Practical Examinations to be held in  <%=month %>  are scheduled as follows:
<br><br><br>
<center>
<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <Th nowrap>Date</TH>
							    
							    <%for(int i=1;i<=ibatches;i++){ %>
							    	<Th nowrap>Batch- <%=miscUtil.int2Roman(i) %><br>(<%=fromtime[i] %> to <%=totime[i] %>)</TH>
							    	<%} %>
							  </TR>
							  
							<%for(int i=1;i<=idays;i++){ %>
							  <tr>
							  <td nowrap><%=days[i] %>
							    <%for(int j=1;j<=ibatches;j++){ %>
							       <td><%=subjects[i][j] %> 
							       </td>
							       <%}%>
							       </tr>
							       <%} %>
							       
							        </TABLE>
<br>
</center>
<p style = "margin-left: 40px;" >Copy to: Director, Pharmacy colleges, Principal-SVCP, Office and website copy.</p>

<br><br>
<p align=right style = "margin-right: 35px;margin-left: 355px;">
<table  align="right" width=100%>
<tr>
<td>Controller of examinations</td>

<td>Principal</td>
<td><td>
<td>Director</td>
</table>
</p>
</font>
</body>
</html>