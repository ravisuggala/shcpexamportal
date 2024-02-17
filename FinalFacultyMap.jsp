<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%

String degree=session.getValue("degree").toString();
String branch=session.getValue("branch").toString();
String ay=session.getValue("ay").toString();
String sem=session.getValue("sem").toString();
String section=session.getValue("section").toString();
String reg=session.getValue("reg").toString();

ArrayList subjects=(ArrayList)session.getValue("subjects");
int totsubs=subjects.size();
for(int i=0;i<subjects.size();i++)
{
	Subject subject=(Subject)subjects.get(i);
	String code=subject.getCode()+"f";
	String fid=miscUtil.noNull(request.getParameter(code));
	String aycode=miscUtil.getAyInShort(ay);
	String fmapid=fid+"-"+subject.getCode()+"-"+aycode+"-"+section;
	FacultyMap fm=new FacultyMap();
	fm.setFmapid(fmapid);
	fm.setFid(fid);
	fm.setSubcode(subject.getCode());
	fm.setSem(sem);
	fm.setAy(ay);
	fm.setDegree(degree);
	fm.setBranch(branch);
	fm.setSection(section);
	int res=new FacultyDB().insertFacultyMap(fm);
	if(res<1)
		totsubs--;
}
String status=miscUtil.semDescription(sem,degree)+" "+degree+"("+branch+") "+totsubs+" subjects are mapped with faculty";

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
