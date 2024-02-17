<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Revaluation Registrations</title>
</head>
<body>
<%@ page import = "dao.*,java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />


<%
String regdno=session.getValue("regdno").toString();
String regvalue=session.getValue("regvalue").toString();
String examid=session.getValue("examname").toString();
String subcodes[]=request.getParameterValues("subjects");

if (subcodes != null) 
{
	for(int i=0;i<subcodes.length;i++)
	{
		String subcode=subcodes[i];
		exdb.doRegistrationForRevaluation(examid,regvalue,regdno,subcode);
	}
}

out.println("<br><br><center><font color=green><h4>"+regdno+" is registered successfully with "+subcodes.length+" subjects</h4></font></center><br>");
out.println("<br><br><center><font color=red><a href='#' onclick='window.close()'> Close Window</a></font></center>");
%>

</body>
</html>