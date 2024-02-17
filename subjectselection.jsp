
<head>
<script language="javascript" src="./JS/functions.js"></script>
</head>
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%

HashMap subjectsList = (HashMap)session.getAttribute("electives");
String selele=new String();
String param=miscUtil.noNull(request.getParameter("hiddenActionType"));
if (param.equals("storemarks"))
	selele=session.getValue("selele").toString();
else
{
	selele=request.getParameter("elecat");
	session.putValue("selele", selele);
	
}
 
//System.out.println(selele);
ArrayList slist=(ArrayList)subjectsList.get(selele);

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
			    <center><h1>Elective Mapping - Step 3 of 4</h1></center>
			    <CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="300">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet" >
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "elective">
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "midstep2">
							<TR>
							    <TD COLSPAN="3" ALIGN="center"><h6><b> List of subjects for  <%=selele %></b></h6></TD>
							</TR>

							<tr>
							<td nowrap align=right> Name of the Subject:
							
							<td colspan=2>
							<select name="subject">
							<option value="" selected></option>
							
							<%
							for(int i=0;i<slist.size();i++)
							{
								Subject sub=(Subject)slist.get(i);
								
						   %>
							<option value=<%=sub.getCode() %>><%=sub.getSname() %>	
								
							<%
							}
							
							%>
							
							
							</select>
						</td>
						</tr>
						
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
	
	</body>
</html>
							
