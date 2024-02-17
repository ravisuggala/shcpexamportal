<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />


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

<jsp:include page='<%= header %>' flush="true" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Revaluation Examination Registration</title>




<script type="text/javascript">
// From: http://www.webdeveloper.com/forum/showthread.php?t=242793

function OpenWindow(info) {
	var w = 880, h = 500,left = Number((screen.width/2)-(w/2)), tops = Number((screen.height/2)-(h/2));
  window.open(info,'Revaluation Registration','toolbar=no, location=0, directories=no, status=no, menubar=no, scrollbars=no, resizable=0, copyhistory=no, width='+w+', height='+h+', top='+tops+', left='+left);
}
</script>
</head>
<body>

<%
String degree=session.getValue("degree").toString();
String sem=session.getValue("sem").toString();
String ay=session.getValue("ay").toString();

String code=miscUtil.noNull(request.getParameter("examname"));
String branch=miscUtil.noNull(request.getParameter("branch"));

session.putValue("branch", branch);
session.putValue("examname", code);

ArrayList examsList=exdb.getExamsList(degree, sem,ay,"REGULAR");

String regvalue="";
if(examsList.size()>0)
{
	ExternalExam ex=(ExternalExam)examsList.get(0);
	regvalue=ex.getCode();
	session.putValue("regvalue", regvalue);
}

ExternalExamDB eedb=new ExternalExamDB();
ExternalExam ee=eedb.getExamInfo(code);

ArrayList stlist=eedb.getStListForRevaluation(regvalue,branch);

if(stlist.size()>0)
{
	
%>
<table align=center border=1>
<tr>
<td>Sl.No</td>
<td>Regdno</td>
<td>Check</td>
</tr>
<% 

	for(int i=0;i<stlist.size();i++)
	{
		String st=(String)stlist.get(i);
		String url="./zrevaluationStep3.jsp?regdno="+st;
	
%>


<tr>
<td><%=i+1 %></td>
<td><%=st %></td>
<TD align=center><input type="checkbox" name="register" value='<%=url %>'  onclick="if(this.checked){OpenWindow(this.value)}"></input></TD>
</tr>

<% }  %>

</table>
<%
}
else
	
out.println("<center><br><br><h3>No Students are registered for previous Regular Examination</h3></center>");
%>
</body>
</html>