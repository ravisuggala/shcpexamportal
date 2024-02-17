<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
String branch=new String();
String sem=new String();
String ay=new String();
String degree=new String();
String totst;
String section=new String();
degree=miscUtil.noNull(request.getParameter("degree"));
branch=miscUtil.noNull(request.getParameter("branch"));
sem=miscUtil.noNull(request.getParameter("sem"));
section=miscUtil.noNull(request.getParameter("section"));
ay=miscUtil.noNull(request.getParameter("ay"));

 boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

 if(!validsec)
 {
 	session.setAttribute("error", "No students for selected branch and section");
 	response.sendRedirect("./errors.jsp");
 }

 int ret=new FacultyDB().deleteFacultyMapping(degree,branch,sem,section,ay);
 

String status=ret+" Faculty mapping(s) are deleted successfully";

%>
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

<jsp:include page='<%= header %>' flush="true" />


<html>
	
	<body>
		  <div id="centre">
		<center>	    <br><br><br>
			   <h3> <%=status %></h3>
				</center>	   
		  </div>
		<div id="pied"></div>
	</div>
	</body>
</html>
