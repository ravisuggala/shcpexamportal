
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
if(target.equals("storemarks"))
{
	degree=session.getValue("degree").toString();
	branch=session.getValue("branch").toString();
	sem=session.getValue("sem").toString();
	section=session.getValue("section").toString();
	reg=session.getValue("reg").toString();
	ay=session.getValue("ay").toString();
	cat=miscUtil.noNull(request.getParameter("cat"));
	session.putValue("cat",cat);
	
	//midno=session.getValue("midno").toString();	
	students=(ArrayList)session.getValue("students");	
	
	
	
	subject= miscUtil.noNull(request.getParameter("subject"));
	session.putValue("subject",subject);
	elecat=miscUtil.noNull(request.getParameter("elecat"));
	session.putValue("elecat",elecat);
	
}
else
{
	degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 reg=miscUtil.noNull(request.getParameter("reg"));
	 ay=miscUtil.noNull(request.getParameter("ay"));
	 cat=miscUtil.noNull(request.getParameter("cat"));
//	 midno=miscUtil.noNull(request.getParameter("midno"));
	 section=miscUtil.noNull(request.getParameter("section"));
	 subject= miscUtil.noNull(request.getParameter("subject"));
	 elecat=miscUtil.noNull(request.getParameter("elecat"));

	 students=stdb.getStudentList(degree, branch, sem,section); 
	 
	
	 
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	session.putValue("section",section);
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	session.putValue("cat",cat);
	
	//session.putValue("midno",midno);
	session.putValue("students", students);
	session.putValue("elecat",elecat);
	session.putValue("subject",subject);
	

}
	boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

	if(!validsec)
	{
		session.setAttribute("error", "No students for selected branch and section");
		response.sendRedirect("./errors.jsp");
	}
   
	String utype=ur.getStatus();
	boolean freez=false;
			session.putValue("option", "internalstep2");
		
		response.sendRedirect("./ActionServlet");
	
%>


