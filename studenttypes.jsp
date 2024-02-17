
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%


String disp="Subject Categories";
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
			    <center><h1>Import Students</h1></center>
			    <CENTER>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							
							<input type=hidden name="option" value="studenttypes"></input>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> Student Category</b></h2></TD>
							</TR>
							
								
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Student Category </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="cat">
								<option value=""></option>
								<option value="regular">Regular</option>
								<option value="detained">Detained</option>
								<option value="Transfered">Transfered</option>
								<option value="reregistered">Re-Registered</option>
								<option value="readmitted">Re-Admitted</option>
								</select>
								
								</td>	
	     																
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
