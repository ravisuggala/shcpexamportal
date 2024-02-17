
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
%>


<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String cat=new String();
String type=new String();
String section=new String();
String elecat="";
String disp="";
ArrayList students=new ArrayList();
ArrayList subjectsList=new ArrayList();
String target=miscUtil.noNull(request.getParameter("hiddenActionType"));
String fe="";
String subject="";
	degree=miscUtil.noNull(request.getParameter("degree"));

	 sem=miscUtil.noNull(request.getParameter("sem"));
	 reg=miscUtil.noNull(request.getParameter("reg"));
	 ay=miscUtil.noNull(request.getParameter("ay"));

     
	
	session.putValue("degree",degree);

	session.putValue("sem",sem);
	
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	
	

	   
	String utype=ur.getStatus();
	boolean freez=false;
	if(!utype.equals("admin"))
		 freez=new MidExamDB().isMidFreeze(sem,degree,ay,type);
	
	if(freez)
	{
		 ServletContext sc = getServletContext();
		    RequestDispatcher rd = sc.getRequestDispatcher("/statusinfo.jsp");
		    request.setAttribute("status", "Mid Marks are freezed for the selected branch and section");
			rd.forward(request, response);
	}

	else
	{
		MidExamDB mdb=new MidExamDB();
		students=mdb.getFEAbsentStudentList(degree, sem,ay,reg);
		
		session.putValue("students", students);	
	session.putValue("option", "fegtstep2");
	response.sendRedirect("./fegtinput.jsp");
	}
	
		


	
%>

	</body>
</html>
