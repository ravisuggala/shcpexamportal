
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb1" scope="session" class="dao.MapSubjectDB" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />

<%
String branch=new String();
String sem=new String();
String ay=new String();
String degree=new String();
String type=new String();
String section=new String();
String totst;
String cat=new String();
String elecat="";
String reg="";
String subject="";
String midno="";

	//System.out.println("in else");

 degree=miscUtil.noNull(request.getParameter("degree"));
 branch=miscUtil.noNull(request.getParameter("branch"));
 sem=miscUtil.noNull(request.getParameter("sem"));
 ay=miscUtil.noNull(request.getParameter("ay"));
 
 section=miscUtil.noNull(request.getParameter("section"));
 cat=miscUtil.noNull(request.getParameter("cat"));
 reg=miscUtil.noNull(request.getParameter("reg"));
 elecat=miscUtil.noNull(request.getParameter("elecat"));
 subject=miscUtil.noNull(request.getParameter("subject"));
 midno=miscUtil.noNull(request.getParameter("midno"));
 
 
 boolean validsec=false;
	 validsec=new StudentDB().isValidSection(degree,branch,sem,section);

 if(!validsec)
 {
 	session.setAttribute("error", "No students for selected branch and section");
 	response.sendRedirect("./errors.jsp");
 }
 

 
 
 
  
session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("ay",ay);
session.putValue("section",section);
session.putValue("elecat", elecat);
session.putValue("subject", subject);
session.putValue("reg",reg);
session.putValue("cat",cat);
session.putValue("midno",midno);
if(degree.equals("Pharm.D"))
response.sendRedirect("./pddisplaygrandmidmarks.jsp");
else if(cat.equals("au"))
{
	MidExamDB medb=new MidExamDB();
	ArrayList slist=medb.getAuditSubjectsMarks(branch, sem,ay,section);
	Subject ausub=new SubjectDB().getNonCreditSubject(branch, sem, reg);
	session.putValue("aumarks", slist);
	session.putValue("ausubject", ausub);
	response.sendRedirect("./displayaumarks.jsp");
}
else
	response.sendRedirect("./displaygrandmidmarks.jsp");


%>

	
	</body>
</html>
