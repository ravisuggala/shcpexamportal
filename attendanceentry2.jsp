
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%@ page import = "dao.User" %>
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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";

%>


<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String cat=new String();
String midno=new String();
String section=new String();
String totst;
String disp="";
ArrayList students=new ArrayList();
ArrayList subjectsList=new ArrayList();
String target=miscUtil.noNull(request.getParameter("hiddenActionType"));
String fe="";
String subject="";
String elecat="";
String fid="";
String date="";
if(target.equals("storemarks"))
{
	degree=session.getValue("degree").toString();
	branch=session.getValue("branch").toString();
	sem=session.getValue("sem").toString();
	section=session.getValue("section").toString();

	ay=session.getValue("ay").toString();

	
	midno=session.getValue("midno").toString();	
	students=(ArrayList)session.getValue("students");	
}
else
{
	degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 sem=miscUtil.noNull(request.getParameter("sem"));

	 ay=miscUtil.noNull(request.getParameter("ay"));
	
	 midno=miscUtil.noNull(request.getParameter("midno"));
	 section=miscUtil.noNull(request.getParameter("section"));
	date=miscUtil.noNull(request.getParameter("cdate"));

	 students=stdb.getStudentList(degree, branch, sem,section); 
	 
	 
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	session.putValue("section",section);
	session.putValue("ay",ay);
	//session.putValue("cat",cat);
	//session.putValue("fe",fe);
	session.putValue("midno",midno);
	session.putValue("students", students);
	session.putValue("date", date);
	//session.putValue("elecat",elecat);
	
}
	boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

	if(!validsec)
	{
		session.setAttribute("error", "No students for selected branch and section");
		response.sendRedirect("./errors.jsp");
	}
   
	
		session.putValue("option", "attendancestep2");
		
		response.sendRedirect("./prattendanceinput.jsp");
	
%>


