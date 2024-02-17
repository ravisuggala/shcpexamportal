
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
	
String subject=miscUtil.noNull(request.getParameter("subject"));
String ay=miscUtil.noNull(request.getParameter("ay"));
String branch=miscUtil.noNull(request.getParameter("branch"));
String reg=miscUtil.noNull(request.getParameter("reg"));
String sem=miscUtil.noNull(request.getParameter("sem"));
String section=miscUtil.noNull(request.getParameter("section"));
String degree=miscUtil.noNull(request.getParameter("degree"));

boolean validsec=false;
validsec=new StudentDB().isValidSection(degree,branch,sem,section);

if(!validsec)
{
session.setAttribute("error", "No students for selected branch and section");
response.sendRedirect("./errors.jsp");
}


//System.out.println(ay+branch+reg+sem+subject+section+degree);
String subjtitle=(new SubjectDB().getSubjectTitle(subject, reg))+" ("+subject+")";
MidExamDB medb=new MidExamDB();
ArrayList marksdata=new ArrayList();
		
if(!degree.equals("Pharm.D"))
	marksdata=medb.getGrandMidMarks(ay, branch, reg, sem, subject,section,degree);
else
	marksdata=medb.getPDGrandMidMarks(ay, branch, reg, sem, subject,section,degree);

session.putValue("marksdata", marksdata);
 
title=new StudentDB().getYearDescription(sem,degree)+" Mid Examination";
session.putValue("title", title);

ArrayList marksdataprint=new ArrayList();
String br=branch;
branch=branch+"-"+section;

String colspan="";
if(degree.equals("Pharm.D"))
	colspan="10";
else
	colspan="9";

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
			    <th colspan=<%=colspan %> style="text-align: center;">SEVEN HILLS COLLEGE OF PHARMACY:TIRUPATHI<BR>(AUTONOMOUS) </th>
			    </tr>
				
				<tr>
			    <th colspan=<%=colspan %> style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>
			    <th colspan=2 >Branch : <%=branch %>  </th>
			    <th colspan=3 align=center> Regulation : <%=reg %> </th>
			    <th colspan=4 nowrap> Academic Year : <%=ay %> </th>
			    </tr>
			    <tr>
			    <th colspan=<%=colspan %>>Subject: <%= subjtitle%> </th>
			    </tr>
			    
			    <TR>
				   <TD COLSPAN=<%=colspan %> ALIGN="center"><h6><b> Student List</b></h6></TD>
				</TR>
							<tr>
							<th class=label><font size=1>Sl.No</font>
							<th class=label nowrap> <font size=1>Name of the Student</font>
							<th class=label><font size=1>Regd.No</font>
							<th class=label nowrap><font size=1 >I Mid</font>
							<th class=label nowrap><font size=1 >II Mid</font>
							<%if(degree.equals("Pharm.D")){ %>
								<th class=label nowrap><font size=1 >III Mid</font>
							<%} %>
							<th class=label><font size=1>Re Mid</font>
							<th class=label><font size=1 nowrap>Scaled to 20</font>
							<th class=label align="center"><font size=1>Daily Assessment</font>
							<th class=label><font size=1>Final Marks</font>
							
							
							<% 
							for(int i=0;i<marksdata.size();i++)
							{
								MidExam mr=(MidExam)marksdata.get(i);					
							%>
							<tr>
							<td align=right><%=i+1 %>
							<td nowrap><%=new StudentDB().getStudentName(mr.getRegdno()) %>
							<td align=center><%=mr.getRegdno() %>
							<td align=center><%=mr.getValue("mid1") %>
							<td align=center><%=mr.getValue("mid2") %>
							<%if(degree.equals("Pharm.D")){ %>
								<td align=center ><%=mr.getValue("mid3") %>
							<%} %>
							
							<td align=center><%=mr.getValue("remid") %>
							<td align=center><%=mr.getValue("avg") %>
							<td align=center><%=mr.getDa() %>
							<td align=center><%=mr.getTot() %>
							
							<%} %>
							<tr>
							<TD colspan=<%=colspan %> align="center">
							
							
								<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
						  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
						 <!--  <input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlgrandmidmarks") ></input>-->
						  

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
