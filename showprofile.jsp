<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SVECW -- Examination Portal</title>
</head>
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
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String regdno=miscUtil.noNull(request.getParameter("regdno"));
Student st=stdb.getStudent(regdno);
if(st==null)
{
	miscUtil.writeToSession(request, response, "error", "No Student bearing with Regd.no:"+regdno);
	miscUtil.forwardToPage(request, response, "./errors.jsp");
}
else
{

%>

<jsp:include page='<%= header %>' flush="true" />

<body>
<div id="centre">
					
	
					    <center><h3>Student Profile</h3></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
								<INPUT TYPE=HIDDEN NAME="option" VALUE = "editprofile">
							<TR>
								<TD  nowrap WIDTH="20%" ALIGN="right">Regd No:</TD>
								<td nowrap WIDTH="10%" ALIGN="left"><input  name="regdno" value=<%=st.getRegdno() %> ></td>
							</TR>
							<TR>
								<TD  nowrap WIDTH="20%" ALIGN="right">Name:</TD>
								<td nowrap WIDTH="10%" ALIGN="left"><input  name="name" size=50 value='<%=st.getName() %>' ></td>
							</TR>
							<TR>
								<TD  nowrap WIDTH="20%" ALIGN="right">Year of Admission:</TD>
								<td nowrap WIDTH="10%" ALIGN="left"><input  name="yoa" value=<%=st.getYoa() %> ></td>
							</TR>
							<TR>
								<TD  nowrap WIDTH="20%" ALIGN="right">Branch:</TD>
								<td nowrap WIDTH="10%" ALIGN="left"><input  name="branch" value=<%=st.getBranch() %> ></td>
							</TR>
							<TR>
								<TD  nowrap WIDTH="20%" ALIGN="right">Semester:</TD>
								<td nowrap WIDTH="10%" ALIGN="left"><input  name="sem" value=<%=st.getSem() %> ></td>
							</TR>
							<TR>
								<TD  nowrap WIDTH="20%" ALIGN="right">Section:</TD>
								<td nowrap WIDTH="10%" ALIGN="left"><input  name="section" value=<%=st.getSection() %> onkeyup='javascript:this.value=this.value.toUpperCase();'></td>
							</TR>
							
							
							
							<TR>
							    <TD colspan=2 align="center">
							    <INPUT TYPE="SUBMIT" NAME="submit" VALUE="Save"></INPUT></TD>

							</TR>
							</FORM>
						</TABLE>
					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>



</body>
<%} %>
</html>