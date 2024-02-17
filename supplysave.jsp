<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Supplementary Registrations</title>
</head>
<body>
<%@ page import = "dao.*,java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />


<%
String regdno=session.getValue("regdno").toString();
String regvalue=session.getValue("regulation").toString();
String examid=session.getValue("examname").toString();
String subcodes[]=request.getParameterValues("subjects");

String sem=session.getValue("sem").toString();
String ay=session.getValue("ay").toString();
String branch=session.getValue("branch").toString();

HashMap supplylist=(HashMap)session.getValue("supplylist");
ArrayList subjs=(ArrayList)supplylist.get(regdno);

if (subcodes != null) 
{
	for(int i=0;i<subcodes.length;i++)
	{
		String subcode=subcodes[i];
		RegistrationRecord rr=new RegistrationRecord();
		rr.setId(examid);
		rr.setMapid(regdno+"-"+subcode);
		rr.setRegdno(regdno);
		rr.setSubcode(subcode);
		rr.setSem(sem);
		rr.setAy(ay);
		rr.setRegulation(regvalue);
		rr.setBranch(branch);
		rr.setDate(exdb.getExamDate(rr.getId(),rr.getBranch(),rr.getSubcode()));
		rr.setBrcode(miscUtil.getBranchCode(rr.getBranch(),miscUtil.getDegreeCode(rr.getId())));
		exdb.doRegistration(rr);
		for(int j=0;j<subjs.size();j++)
		{
			Subject sub=(Subject)subjs.get(j);
			if(sub.getCode().equals(subcode))
			{
				subjs.remove(j);
				break;
			}
		}
	}
	supplylist.put(regdno, subjs);
	session.putValue("supplylist", supplylist);
}

out.println("<br><br><center><font color=green><h4>"+regdno+" is registered successfully with "+subcodes.length+" subjects</h4></font></center><br>");
out.println("<br><br><center><font color=red><a href='#' onclick='window.close()'> Close Window</a></font></center>");
%>

</body>
</html>