
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

ArrayList examsList=new ArrayList();
String target=miscUtil.noNull(session.getValue("target"));
if(target.equals("status"))
{
	degree=session.getValue("degree").toString();
	
	sem=session.getValue("sem").toString();
	
	ay=session.getValue("ay").toString();
	examsList=(ArrayList)session.getValue("examslist");
}
else
{
	degree=miscUtil.noNull(request.getParameter("degree"));
	 
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 
	 ay=miscUtil.noNull(request.getParameter("ay"));
	
	 examsList=exdb.getExamsList(degree, sem,ay); 
	 
	session.putValue("degree",degree);
	
	session.putValue("sem",sem);
	session.putValue("ay",ay);
	session.putValue("examslist", examsList);

		
}
	//System.out.println("in else");
	
String disp="List of Examinations for "+sem+" "+degree;
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
		
		
	</head>
	<body>
		  <div id="centre">
			    <center><h2>External Examination Aggregate Results Download</h2></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep2">
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							
								
							<TR>
								
								<TD  colspan=2 WIDTH="50%" align="left">
								<table border=0>
								<tr>
								<td nowrap WIDTH="10%" ALIGN="right">List of the Examinations:
								<td WIDTH="10%" ALIGN="right" nowrap>
								<select name=examname>
								<option value=""></option>
								
									<%
										for(int i=0;i<examsList.size();i++)
										{
											ExternalExam sub=(ExternalExam)examsList.get(i);
											
											%>
											<option value='<%=sub.getCode() %>'><%=sub.getDescription() %></option>
											<%
											
										}
									%>
									</select>
									</tr>
									
									</table>
								</TD>
							</TR>
								<input type=hidden name="option" value="externalaggregate"></input>					
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
	
	</body>
</html>
