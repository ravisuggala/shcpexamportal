
<%@ page import="java.util.*,dao.*"%>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id="fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id="subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id="stdb" scope="session" class="dao.StudentDB" />

<%@ page import="dao.User"%>
<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
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
String period="";
String examname="";
String disp="";
ArrayList students=new ArrayList();
ExternalExamDB eedb=new ExternalExamDB();

degree=miscUtil.noNull(request.getParameter("degree"));
branch=miscUtil.noNull(request.getParameter("branch"));
sem=miscUtil.noNull(request.getParameter("sem"));
reg=miscUtil.noNull(request.getParameter("reg"));
ay=miscUtil.noNull(request.getParameter("ay"));
period=miscUtil.noNull(request.getParameter("period"));
examname= miscUtil.noNull(request.getParameter("examname"));

	
    session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	session.putValue("period",period);
	session.putValue("examname",examname);
	
	
	session.putValue("students", students);

	String sm=subdb.isContainsViva(degree,branch,sem,reg,"S");
		if(!sm.equals(""))
    	{
    		session.putValue("subject", sm);
    		session.putValue("type", "S");
    		students=eedb.getRegisteredStudents(examname, branch,sm);
    		
    		session.putValue("mapids", students);
    		response.sendRedirect("./seminarmarks.jsp");
    	}
    	else
    	{
    		String error="No Seminar for selected branch and semester";
    		session.putValue("error", error);
    		response.sendRedirect("./errors.jsp");
    	}
   	
	
		



	
%>

</body>
</html>
