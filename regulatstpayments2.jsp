
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<%

String sem=new String();

String degree=new String();

ArrayList studentsList=new ArrayList();
ArrayList subjectsList=new ArrayList();
ArrayList maplist=new ArrayList();

HashMap mapelectives=new HashMap();

String target=miscUtil.noNull(session.getValue(("target")));
if(target.equals("status"))
{
	degree=session.getValue("degree").toString();
	
	sem=session.getValue("sem").toString();
	
	

}
else
{
	degree=miscUtil.noNull(request.getParameter("degree"));
	 
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 
	 MapSubjectDB mdb=new MapSubjectDB();
				
				
				
				
				studentsList=mdb.getMapStudentsByGroup(degree, sem);
				
				
				session.putValue("studentslist",studentsList);
				
				
				
			
	}
	
	


	//System.out.println("in else");
	
String disp=sem+" sem "+degree+" Student Details";
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
			    <center><h2>External Examinations Payments</h2></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep3">
							
						<TABLE BORDER="1"  width=35%>
							<TR>
							    <TD COLSPAN="4" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							
							
							<TR>
										<th>Sl.No</th>
										<th>Regd.No</th>
										<th>Name of the Student</th>
										<th><input type=checkbox id="regds" name=regds value="rall" onClick="toggle(this,'regdnos')"></input></th> 
							</tr>
									<%
									
									int stcnt=1;
									
							        for(int j=0;j<studentsList.size();j++,stcnt++)
									{ 
									  String regdno=studentsList.get(j).toString();
									%>
									
								    <tr>
										<td width=10% nowrap align="right"><%=stcnt%>
										<td nowrap width=18%><%=regdno %>
										<td nowrap><font size=1><%=new StudentDB().getStudentName(regdno) %></font>
										<td nowrap ><input type=checkbox name=regdnos value=<%=regdno %> onclick="deSelectAll('regdnos','regds')"></input></td>
									</tr>
									<% }
									
									%>
									
										
							
									<input type=hidden name="option" value="regularpayments"></input>					
							<TR>
								<TD colspan=4  align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="Submit"></INPUT></TD>
								
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
