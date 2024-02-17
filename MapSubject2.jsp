
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
String totst;
String section=new String();
if (miscUtil.noNull(request.getParameter("hiddenActionType")).equals("mapresult"))
{
degree=miscUtil.getFromSession(request, response, "degree");
section=miscUtil.getFromSession(request, response, "section");
reg=miscUtil.getFromSession(request, response, "reg");

branch=session.getValue("branch").toString();
sem=session.getValue("sem").toString();
ay=session.getValue("ay").toString();
}
else if (miscUtil.noNull(request.getParameter("hiddenActionType")).equals("MapSubject1"))
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
session.putValue("reg",reg);
session.putValue("ay",ay);
session.putValue("section", section);
}
ArrayList subjectsList = subdb.getNotMappedSubjectsList(degree,branch,sem,reg,ay,section);
totst=stdb.getTotalStudents(degree, branch, sem,section);
String disp="List of Subjects for "+sem+" "+branch;
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
<script language=javascript>

function toggle(source) {
	  checkboxes = document.getElementsByName('subject');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
</script>		
	</head>
	<body>
		  <div id="centre">
			    <center><h1>Subjects Mapping </h1></center>
			    <CENTER>
			    <%
			    if(subjectsList.size()==0)
			    {
			    	out.println("<br><br><h3>Subjects are already mapped with the selected students</h3><br><br>");
			    }
			    else
			    {
			    %>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./FinalMap.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapSubject2">
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							<TR>
								<TD  WIDTH="50%" ALIGN="RIGHT">Total Students: </TD>
								<TD  WIDTH="50%" align="left"><%=totst %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" onClick="toggle(this)" /> Select All
								
								
							<TR>
								
								<TD  colspan=2 WIDTH="50%" align="left">
								<table border=0>
								<tr>
									<%
										for(int i=0;i<subjectsList.size();i++)
										{
											Subject sub=(Subject)subjectsList.get(i);
											out.println("<td nowrap>");
											%>
											<input type="checkbox" name="subject" value='<%= sub.getCode() %>'><%= sub.getSname() %> </input>
											<%
											if((i+1)%3==0)
												out.println("<tr>");
										}
									%>
									</table>
								</TD>
							</TR>
														
							<TR>
								<TD colspan=2 rowspan=2 align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>

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
	<%
	}
	%>
	</body>
</html>
