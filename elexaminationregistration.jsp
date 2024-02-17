
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<%

String sem=new String();
String ay=new String();
String degree=new String();
String branch=new String();
String code=new String();
String reg=new String();
ArrayList studentsList=new ArrayList();
ArrayList subjectsList=new ArrayList();
ArrayList maplist=new ArrayList();

String target=miscUtil.noNull(request.getParameter("hiddenActionType"));
if(target.equals("storemarks"))
{
	degree=session.getValue("degree").toString();
	
	sem=session.getValue("sem").toString();
	
	ay=session.getValue("ay").toString();

}
else
{
	degree=session.getValue("degree").toString();
	 
	 sem=session.getValue("sem").toString();
	 
	 ay=session.getValue("ay").toString();
	 
	 code=session.getValue("examname").toString();
	 branch=session.getValue("branch").toString();
	 
	String cat=miscUtil.noNull(request.getParameter("cat"));
	
	if(cat.equals("common"))
	{
			ExternalExamDB eedb=new ExternalExamDB();
			ExternalExam ee=eedb.getExamInfo(code);
	        reg=ee.getReg();
			String info=eedb.isExistedForCommon(code,sem,branch,ee.getReg());
			if(info.equals("0"))
			{
				MapSubjectDB mdb=new MapSubjectDB();
				
				maplist=mdb.getMapSubjectsList(code,branch, sem, ee.getReg(), ay);
				
				subjectsList=mdb.getMapSubjectsByGroup(branch, sem, ee.getReg(), ay);
				studentsList=mdb.getMapStudentsByGroup(branch, sem, ee.getReg(), ay);
				
				session.putValue("maplist", maplist);
				session.putValue("studentslist",studentsList);
				session.putValue("subjectslist", subjectsList);
			}
			else
			{
				miscUtil.writeToSession(request, response, "error", info);
				miscUtil.forwardToPage(request, response, "./errors.jsp");
			}
	}
	else
	{
		response.sendRedirect("./electivetypes2.jsp");
	}
	

}
	//System.out.println("in else");
	
String disp=sem+" "+branch+" Students and Subjects Details";
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
		
		<script language="javascript" src="./JS/functions.js"></script>
	</head>
	<body>
		  <div id="centre">
			    <center><h2>External Examinations Registration</h2></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep3">
							
						<TABLE BORDER="0"  WIDTH="500">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							
							<tr>
							<td nowrap align="center">Students List (Total:<%=studentsList.size() %>)</td>
							<td nowrap align="center"> Subjects List (Total:<%=subjectsList.size() %>)</td>
							</tr>	
							
							<TR>
							<td>
									<table border=1 CELLPADDING="2" CELLSPACING="2">
									<tr>
										<th>Sl.No</th>
										<th>Regd.No</th>
										<th><input type=checkbox id="regds" name=regds value="rall" onClick="toggle(this,'regdnos')"></input></th> 
									</tr>
									<%
									for(int i=0;i<studentsList.size();i++)
									{ 
										String regdno=studentsList.get(i).toString();
									%>
									<tr>
										<td nowrap align="right"><%=i+1 %>
										<td nowrap><%=regdno %>
										<td nowrap align="center"><input type=checkbox name=regdnos value=<%=regdno%> onclick="deSelectAll('regdnos','regds')"></input></td>
									</tr>
									<% }%>
									
									</table>
								</td>	
								<td valign="top">
									<table border=1 CELLPADDING="2" CELLSPACING="2">
									<tr>
										<th>Sl.No</th>
										<th align="center">Subject</th>
										<th><input type=checkbox id="subjs" name="subjs" value="sall" onClick="toggle(this,'subjects')"></input></th> 
									</tr>
									<%
									for(int i=0;i<subjectsList.size();i++)
									{ 
										String subjcode=subjectsList.get(i).toString();
										String subjt=new SubjectDB().getSubjectTitle(subjcode,reg)+" ("+subjcode+")";
									%>
									<tr>
										<td nowrap align="right"><%=i+1 %>
										<td nowrap><%= subjt%>
										<td nowrap align="center"><input type=checkbox name=subjects value=<%=subjcode%> onclick="deSelectAll('subjects','subjs')"></input></td>
									</tr>
									<% }%>
									
									</table>
							</td>		
							</TR>
							
									<input type=hidden name="option" value="examregistration"></input>					
							<TR>
								<TD colspan=2  align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="Submit"></INPUT></TD>
								
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
