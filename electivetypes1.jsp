
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%

String sem=session.getValue("sem").toString();
String branch=session.getValue("branch").toString();
HashMap electives=(HashMap)session.getValue("electives");

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
		
		
	</head>
	<body>
		  <div id="centre">
			    <center><h1>Mid Examinations Marks Entry</h1></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./displayelectivemidmarks.jsp">
							
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> <%=disp%></b></h2></TD>
							</TR>
							
								
							<TR>
								
	     		<td nowrap align=right> Elective Categories:
							<td nowrap><select size="1" name="elecat">
											<option value="" selected></option>
								<%
									   Set<String> keys=electives.keySet();
										for(String key:keys)
										{
								%>
								
										
										<option value='<%=key %>'><%=key %> </option>
								<%
											
								} 
										
									%>
	
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
	
	</body>
</html>
