<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
ArrayList subjlist=new ArrayList();
if (!miscUtil.noNull(request.getParameter("hiddenActionType")).equals("MapSubject2"))
{
response.sendRedirect("./MapSubject1.jsp");
}
String degree=session.getValue("degree").toString();
String branch=session.getValue("branch").toString();
String ay=session.getValue("ay").toString();
String sem=session.getValue("sem").toString();
String section=session.getValue("section").toString();
String reg=session.getValue("reg").toString();
String bysm=new String();
String subjs[]=request.getParameterValues("subject");
String slist=new String();
if(subjs==null)
{
	session.setAttribute("importresult", "ERROR!!Please select atleast one subject");
	session.setAttribute("target", "smap");
	response.sendRedirect("./ImportResult.jsp");
}
else
{
SubjectDB subdb=new SubjectDB();
for(int i=0;i<subjs.length;i++)
{
	subjlist.add(subjs[i]);
	slist=slist+subjs[i]+"-"+subdb.getSubjectTitle(subjs[i],reg)+"<br>";
}
 bysm=sem+" "+branch+"-"+section;
session.putValue("subjlist", subjlist);
}
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
	<head>
		<title>Subjects Mapping</title>
		
	</head>
	<body>
		  <div id="centre">
			    
			    <FORM NAME="CANCELFORM" ACTION="./MapSubject1.jsp" METHOD="POST">
					<INPUT TYPE = "HIDDEN" NAME = "dummy" VALUE = "">
					</FORM>
			    <CENTER>
						<TABLE BORDER="1" WIDTH="650">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> Subject Mapping Information</b></h2></TD>
							</TR>
							
							<TR>
								<TD   ALIGN="left">Academic Year: </TD>
								<TD   align="left">
								<%= ay %>
								</TD>
							</TR>
							<TR>
								<TD ALIGN="left">Course: </TD>
								<TD  align="left">
								<%= degree %>
								</TD>
							</TR>
							
							<TR>
								<TD ALIGN="left">Branch: </TD>
								<TD  align="left">
								<%= bysm %>
								</TD>
							</TR>
							<TR>
								<TD  width=180 ALIGN="left">Subjects: </TD>
								<TD  width=500 align="left">
							<%=slist %>
							</TD>
							</TR>
							
							
                         	<TR>
                         	<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "MapSubject">
							
								<TD align="center" colspan=2><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Submit"></INPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<INPUT TYPE="BUTTON" NAME="Modify" VALUE="Modify" onClick="document.CANCELFORM.submit()"></TD>
							</TR>
							</FORM>
						</TABLE>
					    </CENTER>			  
					   
					   
					   
		  </div>
		<div id="pied"></div>
	</div>
	</body>
</html>
