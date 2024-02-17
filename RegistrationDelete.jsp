<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Registrations Deletion</title>
</head>
<body>
<%@ page import = "dao.*,java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<%@ page import="dao.User"%>


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




<%
String regdno=session.getValue("regdno").toString();

String examid=session.getValue("examname").toString();
String subcodes[]=request.getParameterValues("subjects");

if (subcodes != null) 
{
	for(int i=0;i<subcodes.length;i++)
	{
		String subcode=subcodes[i];
		exdb.deleteRegistration(examid,regdno,subcode);
	}
	out.println("<br><br><center><font color=green><h4> "+subcodes.length+" Exam Registration(s)  deleted successfully</h4></font></center><br>");
}
else
out.println("<br><br><center><font color=green><h4> No Subject Selection made to delete registrations</h4></font></center><br>");

%>

</body>
</html>