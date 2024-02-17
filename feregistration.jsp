
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



HashMap mapelectives=new HashMap();

//String target=miscUtil.noNull(session.getValue(("target")));
	degree=miscUtil.noNull(request.getParameter("degree"));
	 
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 
	 ay=miscUtil.noNull(request.getParameter("ay"));
	 
	 code=miscUtil.noNull(request.getParameter("examname"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 
	session.putValue("degree", degree);
	session.putValue("sem", sem);
	session.putValue("ay", ay);
	session.putValue("examname", code);
	session.putValue("branch", branch);
	
			ExternalExamDB eedb=new ExternalExamDB();
			ExternalExam ee=eedb.getExamInfo(code);
	        reg=ee.getReg();
			FreeElectiveDB fedb=new FreeElectiveDB();
			ArrayList stlist=fedb.getStudentList(sem,branch,ay);
			
	session.putValue("stlist", stlist);


	//System.out.println("in else");
	
String disp=sem+" "+branch+" Free Elective Details";
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
							
						<TABLE BORDER="1"  width=35%>
							<TR>
							    <TD COLSPAN="8" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							
							
							<TR>
										<th>Sl.No</th>
										<th>Regd.No</th>
										<th>Subject Code</th>
										<th>Subject Name</th>
										<th>Branch</th>
										<th>Sem</th>
										<th>Elective Category</th>
										<th><input type=checkbox id="regds" name=regds value="rall" onClick="toggle(this,'regdnos')"></input></th> 
							</tr>
									<%
									
									int stcnt=1;
									for(int i=0;i<stlist.size();i++)
									{ 
									  FreeElective st=(FreeElective)stlist.get(i);
									%>
									
								    <tr>
										<td width=10% nowrap align="right"><%=stcnt++ %>
										<td nowrap width=18%><%=st.getRegdno() %>
										<td nowrap><font size=1><%= st.getSubcode() %></font>
										<td nowrap><font size=1><%= st.getSubname() %>
										<td nowrap><font size=1><%= st.getBranch()+"-"+st.getSection() %></font>
										<td nowrap><font size=1><%= st.getSem() %></font>
										<td nowrap><font size=1><%= st.getElective() %></font>
										
										<td nowrap ><input type=checkbox name=regdnos value=<%=st.getRegdno() %> onclick="deSelectAll('regdnos','regds')"></input></td>
									</tr>
									<% }
									
									%>
									
										
							
									<input type=hidden name="option" value="feregistration"></input>					
							<TR>
								<TD colspan=8  align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="Submit"></INPUT></TD>
								
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
