
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
String period="";
ArrayList students=new ArrayList();
ArrayList subjectsList=new ArrayList();
String target=miscUtil.noNull(request.getParameter("hiddenActionType"));
String fe="";
String subject="";
String elecat="";
String examname="";
String evtype="";
ExternalExamDB eedb=new ExternalExamDB();
if(target.equals("storemarks"))
{
	degree=session.getValue("degree").toString();
	branch=session.getValue("branch").toString();
	sem=session.getValue("sem").toString();
	
	reg=session.getValue("reg").toString();
	ay=session.getValue("ay").toString();
	cat=miscUtil.noNull(request.getParameter("cat"));
	session.putValue("cat",cat);
	 period=miscUtil.noNull(miscUtil.getFromSession(request, response, "period"));
	 
		
		
	examname= miscUtil.noNull(session.getValue("examname"));
	
	
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
	 period=miscUtil.noNull(request.getParameter("period"));
	 subject= miscUtil.noNull(request.getParameter("subject"));
	 elecat=miscUtil.noNull(request.getParameter("elecat"));
	 examname= miscUtil.noNull(request.getParameter("examname"));
	 
	 
	
	 
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	session.putValue("period",period);
	session.putValue("examname",examname);
	
	session.putValue("elecat",elecat);
	session.putValue("subject",subject);
	
	

}

	students=eedb.getRegisteredStudents(examname, branch,subject);
	session.putValue("mapids", students);
	

	
	boolean freez=false;
	freez=new MidExamDB().isMidFreeze(sem,degree,ay,examname);
	
	if(freez)
	{
		 	ServletContext sc = getServletContext();
		    RequestDispatcher rd = sc.getRequestDispatcher("/statusinfo.jsp");
		    request.setAttribute("status", "External Marks are freezed for the selected branch and section");
			rd.forward(request, response);
	}

	else
	{
		
		
		response.sendRedirect("./mp275marksinput.jsp");
	}
%>


