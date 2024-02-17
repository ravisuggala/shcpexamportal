
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "middb" scope="session" class="dao.MidExamDB" />
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
String conducted=new String();

String test1=new String();

String test2=new String();
String test3=new String();
String test4=new String();
	conducted=miscUtil.noNull(request.getParameter("conducted"));
	 test1=miscUtil.noNull(request.getParameter("date1"));
	 test2=miscUtil.noNull(request.getParameter("date2"));
	 test3=miscUtil.noNull(request.getParameter("date3"));
	 test4=miscUtil.noNull(request.getParameter("date4"));
	 
	 
	session.putValue("conducted",conducted);
	session.putValue("test1",test1);
	session.putValue("test2",test2);
	session.putValue("test3",test3);
	session.putValue("test4",test4);
	session.putValue("option", "internalstep2f");
		
	response.sendRedirect("./ActionServlet");
	
%>
	