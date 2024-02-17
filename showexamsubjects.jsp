
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

ArrayList studentsList=new ArrayList();
ArrayList subjectsList=new ArrayList();
//ArrayList maplist=new ArrayList();
ArrayList timetable=new ArrayList();
String reg="";
ExternalExamDB eedb=new ExternalExamDB();
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
	 
	 code=miscUtil.noNull(request.getParameter("examname"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 
	session.putValue("branch", branch);
	session.putValue("examname", code);
	
	
	ExternalExam ee=eedb.getExamInfo(code);
	
		MapSubjectDB mdb=new MapSubjectDB();
		reg=ee.getReg();
		//maplist=mdb.getMapSubjectsList(code,branch, sem, ee.getReg(), ay);
		
		if(ee.getType().equals("REGULAR"))
			subjectsList=mdb.getMappedAllSubjects(branch, sem, ee.getReg(), ay);
		else if(ee.getType().equals("SUPPLEMENTARY"))
			subjectsList=mdb.getMappedAllSupplySubjects(branch, sem, ee.getReg(), ay);
	    timetable=eedb.isTimetableSet(code,branch);
		
		//session.putValue("maplist", maplist);

		session.putValue("subjectslist", subjectsList);
		//System.out.println(subjectsList.size());
	}




	//System.out.println("in else");
	
String disp=sem+" "+branch+" Subjects Details";
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
		<script language="javascript" src="./JS/datetimepicker.js"></script>
	</head>
	<body>
		  <div id="centre">
			    <center><h2>External Examinations Time Table</h2></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep3">
							
						<TABLE BORDER="1"  WIDTH="500">
							<TR>
							    <TD COLSPAN="3" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							
							<TR>
								
							    <TD COLSPAN="3" ALIGN="center">Examination Time::
							    <%Vector times=miscUtil.getTimeValues() ;%>
							    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							    From::<%=miscUtil.getSelectList(new StringBuffer(), times, null, "from", 1, 100, false, "") %>
							    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							    To::<%=miscUtil.getSelectList(new StringBuffer(), times, null, "to", 1, 100, false, "") %>
							    
							    </TD>
							</TR>
							
							<TR>
								<td valign="top">
									<table border=1 CELLPADDING="2" CELLSPACING="2">
									<tr>
										<th>Sl.No</th>
										<th align="center">Subject</th>
										<th>Date of Examination</th> 
									</tr>
									<%
									
									for(int i=0;i<subjectsList.size();i++)
									{ 
										String subjcode=subjectsList.get(i).toString();
										String subjt=new SubjectDB().getSubjectTitle(subjcode,reg)+" ("+subjcode+")";
										String dt=eedb.findDateOfExam(code,branch,subjcode);
									%>
									<tr>
										<td nowrap align="right"><%=i+1 %>
										<td nowrap><%= subjt%>
										<td nowrap align="center">
<input id='demo<%=i %>' type="text" value=<%=dt %> size="10" name='<%=subjcode %>date'><a href="javascript:NewCal('demo<%=i %>','ddMMMyyyy')"><img src="./imgs/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td>
									</tr>
									<% }%>
																
									</table>
							</td>		
							</TR>
							
									<input type=hidden name="option" value="examtimetable"></input>					
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
