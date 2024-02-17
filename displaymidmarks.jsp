
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
	
String subject=request.getParameter("subject");
String ay=session.getValue("ay").toString();
String branch=session.getValue("branch").toString();
String reg=session.getValue("reg").toString();
String sem=session.getValue("sem").toString();
String section=session.getValue("section").toString();
String midno=session.getValue("midno").toString();
String degree=session.getValue("degree").toString();
String type=session.getValue("midno").toString();

String subjtitle=(new SubjectDB().getSubjectTitle(subject, reg))+" ("+subject+")";
MidExamDB medb=new MidExamDB();
ArrayList marksdata=new ArrayList();
		
	marksdata=medb.getMidMarks(ay, branch, reg, sem, subject, midno,section,degree);

session.putValue("marksdata", marksdata);
 
 title=new StudentDB().getYearDescription(sem,degree)+" Mid-"+midno+" Examination";
session.putValue("title", title);

ArrayList marksdataprint=new ArrayList();
String br=branch;
branch=branch+"-"+section;

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
			    <th colspan=8 style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>
			    <th colspan=2 >Branch : <%=branch %>  </th>
			    <th colspan=2 align=center> Regulation : <%=reg %> </th>
			    <th colspan=4> Academic Year : <%=ay %> </th>
			    </tr>
			    <tr>
			    <th colspan=8>Subject: <%= subjtitle%> </th>
			    </tr>
			    
			    <TR>
				   <TD COLSPAN="8" ALIGN="center"><h6><b> Student List</b></h6></TD>
				</TR>
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap> <font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<% if(br.equals("M.B.A")) 
							{%>
							<th style="text-align: center;" ><font size=1>Descriptive<br>(20)</font>
							<th><font size=1>PPTs<br>(20)</font>
							<th><font size=1>Total<br>(40)</font>
							</tr>
							<% }
							else if(!type.equals("final")){
							%>
							
							<th style="text-align: center;" ><font size=1>Descriptive<br>(30)</font>
							<th><font size=1>Quiz<br>(10)</font>
							<th style="text-align: center;"><font size=1>Assignment<br>(10)</font>
							<th style="text-align: center;"><font size=1>Descriptive<br>(20)</font>
							<th><font size=1>Total<br>(40)</font>
							</tr>
							<%} 
							else
							{%>
								<th style="text-align: center;" ><font size=1>Final Marks</font>
								
								</tr>
									
							<% }%>
							%>
							<% 
							for(int i=0;i<marksdata.size();i++)
							{
								MidExam mr=(MidExam)marksdata.get(i);					
							%>
							<tr>
							<td align=right><%=i+1 %>
							<td nowrap><%=new StudentDB().getStudentName(mr.getRegdno()) %>
							<td align=center><%=mr.getRegdno() %>
							
							<%  if(!type.equals("final")){ %>
							
							<td align=center><%=mr.getDm() %>
							<td align=center><%=mr.getQm() %>
							<%if(!br.equals("M.B.A"))
							{ %>
							<td align=center><%=mr.getAm() %>
							<td align=center><%=mr.getFdm() %>
							<%} %>
							<td align=center><%=mr.getTot() %>
						    <%}
							else
							{
								
							%>
							<td align=center colspan=5><%=mr.getTot() %>
							<%} %>
							</tr>
							<%} %>
							<tr>
							<TD colspan=8 align="center">
							
							
								<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
						  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
						 <input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlmidmarks") ></input>
						  <input id="btnSubmit" type="button" value="Export to PDF"  onClick=selectOption("pdfmidmarks")></input>

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
