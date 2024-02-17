
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String section=new String();
String totst;
if (miscUtil.noNull(request.getParameter("hiddenActionType")).equals("mapresult"))
{
degree=session.getValue("degree").toString();
branch=session.getValue("branch").toString();
sem=session.getValue("sem").toString();
section=session.getValue("section").toString();
reg=session.getValue("reg").toString();
ay=session.getValue("ay").toString();
}
else if (miscUtil.noNull(request.getParameter("hiddenActionType")).equals("MapElective1"))
{
	//System.out.println("in else");
	 degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
  	 sem=miscUtil.noNull(request.getParameter("sem"));
     section=miscUtil.noNull(request.getParameter("section"));
     reg=miscUtil.noNull(request.getParameter("reg"));
     ay=miscUtil.noNull(request.getParameter("ay"));
 
 boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

 if(!validsec)
 {
 	session.setAttribute("error", "No students for selected branch and section");
 	response.sendRedirect("./errors.jsp");
 }

 
session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("section",section);
session.putValue("reg",reg);
session.putValue("ay",ay);
}
HashMap subjectsList = subdb.getElectiveList(degree,branch,sem,reg);


totst=stdb.getTotalStudents(degree, branch, sem,section);
session.putValue("electives", subjectsList);
String disp="List of Electives for "+sem+" "+branch;
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
		<title>Electives Mapping</title>
		
	</head>
	<body>
		  <div id="centre">
			    <center><h1>Electives Mapping - Step 2 of 3</h1></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./MapElective3.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapElective2">
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							<tr>
							<td nowrap> Elective Categories:
							<td nowrap><select size="1" name="elecat">
											<option value="" selected></option>
								<%
									   Set<String> keys=subjectsList.keySet();
										for(String key:keys)
										{
								%>
								
										
										<option value='<%=key %>'><%=key %> </option>
								<%
											
								} 
										
									%>
									</table>
								</TD>
							</TR>
														
							<TR>
								<TD colspan=2 rowspan=2 align="center"><br></br><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->" onclick="checkmultiple()"></INPUT><br></br></TD>

							</TR>
							</FORM>
						</TABLE>
					    </CENTER>			  
					   
					   
					   
		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	
	</body>
</html>
