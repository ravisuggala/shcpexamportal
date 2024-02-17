<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
ArrayList starray=new ArrayList();
if (!miscUtil.noNull(request.getParameter("hiddenActionType")).equals("bp8mapelective3"))
{
response.sendRedirect("./bp8mapelective1.jsp");
}
String degree=session.getValue("degree").toString();
String branch=session.getValue("branch").toString();
String ay=session.getValue("ay").toString();
String sem=session.getValue("sem").toString();
String section=session.getValue("section").toString();
String reg=session.getValue("reg").toString();
String bysm=new String();
String selele=session.getValue("selele").toString();

String elesubj=miscUtil.noNull(request.getParameter("elesubj"));


String stlist[]=request.getParameterValues("ToLB");

SubjectDB subdb=new SubjectDB();
String subjtitle=subdb.getSubjectTitle(elesubj,reg)+"<br>";

 bysm=sem+" "+branch+"-"+section;
//session.putValue("subjlist", subjlist);
String sts=new String();
for(int i=0;i<stlist.length;i++)
{
	sts=sts+stlist[i]+",";
	starray.add(stlist[i]);
}
session.putValue("stlist", starray);
session.putValue("elesubj", elesubj);
session.putValue("electivesem","bp8");

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
			    
			    <FORM NAME="CANCELFORM" ACTION="./bp8mapelective1.jsp" METHOD="POST">
					<INPUT TYPE = "HIDDEN" NAME = "dummy" VALUE = "">
					</FORM>
			    <CENTER>
						<TABLE BORDER="1" WIDTH="650" style="table-layout: fixed;">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> Elective Subject Mapping Information</b></h2></TD>
							</TR>
							
							<TR>
								<TD   ALIGN="left" NOWRAP>Academic Year: </TD>
								<TD   align="left">
								<%= ay %>
								</TD>
							</TR>
							<TR>
								<TD ALIGN="left" NOWRAP>Course: </TD>
								<TD  align="left">
								<%= degree %>
								</TD>
							</TR>
							
							<TR>
								<TD ALIGN="left" NOWRAP>Branch: </TD>
								<TD  align="left">
								<%= bysm %>
								</TD>
							</TR>
							<TR>
								<TD  width=180 ALIGN="left">Subject: </TD>
								<TD  width=500 align="left">
							<%=selele+" - "+subjtitle %>
							</TD>
							</TR>
							
							<TR>
								<TD  width=180 ALIGN="left" NOWRAP>List of Students: </TD>
								<TD  width=500 align="left" style="word-wrap: break-word">
							<%=sts %>
							</TD>
							</TR>
							
                         	<TR>
                         	<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "MapElective">
							
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
