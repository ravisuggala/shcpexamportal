
<head>
<script language="javascript" src="./JS/FormChek.js"></script>
<script type="text/javascript" src="./JS/jquery-1.4.2.min.js">  </script>
<script type="text/javascript" src="./JS/functions.js">  </script>

</head>
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%


/*SELECT * FROM examcell.mids where mapid in 
(select mapid from mapsubjects where 
		ay='2015-2016' and branch='MECH' and regulation='R14-R' and sem='I-I' and subcode='UGBS1T01');*/
ArrayList marksrows=new ArrayList();
String status="";
String title="";

String degree=miscUtil.noNull(request.getParameter("degree"));
String branch=miscUtil.noNull(request.getParameter("branch"));
String sem=miscUtil.noNull(request.getParameter("sem"));
String ay=miscUtil.noNull(request.getParameter("ay"));
String subject=request.getParameter("subject");
String section=miscUtil.noNull(request.getParameter("section"));
String reg=miscUtil.noNull(request.getParameter("reg"));

boolean validsec=false;
	 validsec=new StudentDB().isValidSection(degree,branch,sem,section);

if(!validsec)
{
	session.setAttribute("error", "No students for selected branch and section");
	response.sendRedirect("./errors.jsp");
}


session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("ay",ay);
session.putValue("section",section);
session.putValue("reg",reg);



String subjtitle=(new SubjectDB().getSubjectTitle(subject, reg))+" ("+subject+")";
MidExamDB medb=new MidExamDB();
ArrayList marksdata=new ArrayList();
	
	marksdata=medb.getInternalMarks(ay, branch, reg, sem, subject,section,degree);
	TestDates td=medb.findTestDates(degree, branch, sem, section, ay, subject);
	

session.putValue("marksdata", marksdata);
 
title=new StudentDB().getYearDescription(sem,degree)+"("+ay+") Internal Assessment Marks";
session.putValue("title", title);

ArrayList marksdataprint=new ArrayList();
String br=branch;
branch=branch+"-"+section;
String maxatt="";
if(degree.equals("B.Pharmacy"))
	maxatt="3";
else
	maxatt="10";
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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";

	
%>

<jsp:include page='<%= header %>' flush="true" />


	<body>
		  <div id="centre">

			    <% 
			    if(marksdata.size()>0)
			    {
                  marksdataprint.add(0, title);
                  marksdataprint.add(1,branch);
                  marksdataprint.add(2,reg);
                  marksdataprint.add(3,ay);
                  marksdataprint.add(4,subjtitle);
                  marksdataprint.add(5,marksdata);
                  session.setAttribute("marksdataprint", marksdataprint);
                  
                  
                  
			    %>
			    <CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="100">
				<tr>
			    <th colspan=14 style="text-align: center;">SEVEN HILLS COLLEGE OF PHARMACY:TIRUPATI<BR>(AUTONOMOUS) </th>
			    </tr>

				<tr>
			    <th colspan=14 style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>
			    <th  nowrap>Branch : </th>
			    <th nowrap><%=branch %>  </th>
			    <th  align=center nowrap colspan=12> Regulation : <%=reg %> </th>
			    
			    </tr>
			    
			    <TR>
				   <TD COLSPAN="14" ALIGN="center"><h6><b> Student List</b></h6></TD>
				</TR>
				<tr>
							<th class=label><font size=1>Sl.No</font>
							<th class=label nowrap> <font size=1>Name of the Student</font>
							<th class=label nowrap><font size=1>Regd.No</font>
							<th class=label nowrap><font size=1>Attendance</font>
							<th class=label nowrap><font size=1>Attendance%</font>
							<th class=label nowrap><font size=1>Attendance<br> Marks</font>
						<%if(degree.equals("B.Pharmacy")){ %>	
							<th class=label nowrap><font size=1>Test-I <br>Marks</font>
							<th class=label nowrap><font size=1>Test-II <br>Marks</font>
							<th class=label nowrap><font size=1>Test-III <br>Marks</font>
							<th class=label nowrap><font size=1>Test-IV <br>Marks</font>
							<th class=label nowrap><font size=1>Total <br>Marks</font>
							<th class=label nowrap><font size=1>Average <br>Marks</font>
							<th class=label nowrap><font size=1>Assignment <br>Marks</font>
							<th class=label nowrap><font size=1>Total <br>Assesment <br>Marks</font>
							<%} %>
					<tr>
						<td nowrap colspan=3> <font size=1>Subject: <%= subjtitle%></font>
							<td nowrap><font size=1><%=td.getConducted() %></font>
							<td nowrap><font size=1>100</font>
							<td nowrap><font size=1><%=maxatt %></font>
							<%if(degree.equals("B.Pharmacy")){ %>
							<td ><font size=1><%= miscUtil.formatDate(td.getTest1(), "dd-MMM-yyyy", "dd/MM/yy")     %></font>
							<td ><font size=1><%= miscUtil.formatDate(td.getTest2(), "dd-MMM-yyyy", "dd/MM/yy")%></font>
							<td ><font size=1><%=miscUtil.formatDate(td.getTest3(), "dd-MMM-yyyy", "dd/MM/yy")%></font>
							<td ><font size=1><%=miscUtil.formatDate(td.getTest4(), "dd-MMM-yyyy", "dd/MM/yy")%></font>
							<td nowrap><font size=1>40</font>
							<td nowrap><font size=1>2</font>
							<td nowrap><font size=1>5</font>
							<td nowrap><font size=1>10</font>
							<%} %>
							<% 
							int cnt=1;
							for(int i=0;i<marksdata.size();i++)
							{
								MidExam mr=(MidExam)marksdata.get(i);
								
							%>
							<tr>
							<td align=right><%=cnt++ %>
							<td nowrap><%=new StudentDB().getStudentName(mr.getRegdno()) %>
							<td align=center><%=mr.getRegdno() %>
							<td align=center><%=mr.getAttended() %>
							<td align=center><%=mr.getAttperc() %>
							<td align=center><%=mr.getAtt() %>
							<%if(degree.equals("B.Pharmacy")){ %>
							<td align=center><%=mr.getTest1() %>
							<td align=center><%=mr.getTest2() %>
							<td align=center><%=mr.getTest3() %>
							<td align=center><%=mr.getTest4() %>
							<td align=center><%=mr.getTestmarks() %>
							<td align=center><%=mr.getActvts() %>
							<td align=center><%=mr.getAsst() %>
							<td align=center><%=mr.getDa() %>
							<%} %>
							<%} %>
							
							<tr>
							<TD colspan=14 align="center">
							<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
						  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
						 <!--  <input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlmidmarks") ></input>-->
						  

						  </form>
						   </TD>
						  </tr>
													
						</TABLE>
					    </CENTER>		
					    <%}
			    else
			    	out.println("<center><h4><b>No Marks data for selected branch and subject</b></h4></center>");
			    	  %>	  
					   
					   
					   
		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	
	</body>
</html>
