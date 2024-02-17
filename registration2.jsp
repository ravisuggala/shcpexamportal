
<%@ page import="java.util.*,dao.*"%>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />

<script language=javascript>

function toggle(source) {
	  checkboxes = document.getElementsByName('subjects');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
</script>		



<%
String regdno=miscUtil.noNull(request.getParameter("regdno"));
String sem=miscUtil.noNull(request.getParameter("sem"));
regdno=regdno.toUpperCase();
session.setAttribute("regdno",regdno);
session.setAttribute("sem",sem);
String type=session.getAttribute("type").toString();
//System.out.println(type);
Student st=null;
if(type.equals("SUPPLEMENTARY"))
	st=new StudentDB().getSubjectsForRegistration(regdno,sem,"SUPPLEMENTARY");
else if(type.equals("REVALUATION"))
	st=new StudentDB().getSubjectsForRegistration(regdno,sem,"REVALUATION");
else if(type.equals("SUPPLY REVALUATION"))
	st=new StudentDB().getSubjectsForRegistration(regdno,sem,"SUPPLY REVALUATION");
else if(type.equals("SPECIAL THEORY"))
	st=new StudentDB().getSubjectsForRegistration(regdno,sem,"SPECIAL THEORY");

if(st==null)
{
	session.setAttribute("error", "Regd.no is not found for the selected examination type");
	response.sendRedirect("./errors.jsp");
}
	
else
{
session.setAttribute("student",st);

%>

<%@ page import="dao.User"%>


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

else if(ur.getStatus().equals("office"))
	header="./feemenuheader.jsp";
	
%>

<jsp:include page='<%= header %>' flush="true" />

<html>
<head>
<title>SVCP--Examination Fee Portal</title>

</head>
<body>
	<div id="centre">
		<center>
			<h2>External Examinations Registration</h2>
		</center>
		<CENTER>
			<FORM NAME=REGISTER METHOD=POST ACTION="./registration3.jsp" onsubmit="return confirm('Are you sure?');" >
				<INPUT TYPE=HIDDEN NAME="option" VALUE="delreg">
				
				
				
<table border=0 cellspacing=30 >
<tr>
<td>
				<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="350">
					<TR>
						<th>Regd.No:</th>
						<td><%=regdno %>
					</TR>
					<tr>
						<th nowrap>Name of the Student</th>
						<td nowrap><%=st.getName() %></td>
					</tr>
					<tr>
						<th>Course</th>
						<td><%=st.getDegree() %></td>
					</tr>
					<tr>
						<th>Branch</th>
						<td><%=st.getBranch() %></td>
					</tr>
					<tr>
						<th>Semester</th>
						<Td><%=st.getSem() %></Td>
					</tr>
					<tr>
						<th nowrap>Examination Type</th>
						<td nowrap><%=st.getType() %></td>
					</tr>
									
				</TABLE>
				</td>
				<td>
				<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="350">
					<TR>
						<TD COLSPAN="3" ALIGN="center"><h5>	<b> List of Subjects to be registered</b></h2></TD>
					</TR>
					<TR>
						<th nowrap>Subject Code</th>
						<th nowrap>Subject Name</th>
						<th>Check<br><input type="checkbox" onClick="toggle(this)" /></br></th>
					</tr>
	<%
	StringTokenizer tokens=new StringTokenizer(st.getSubjects(),"#");
	while(tokens.hasMoreTokens())
	{
		String sub=tokens.nextToken();
		String parts[]=sub.split("-");
		String subcode=parts[0];
		String sname=parts[1];
	%>
					<tr>
						<td><%=subcode %></td>
						<td nowrap><%=sname %>
						<td><input type=checkbox name=subjects value='<%=sub%>'>
						</td>
					</tr>

	<% }%>

					<tr>
						<td colspan=4 align=center><input type=submit value=Proceed>
						</td>
				</table>
				
				
				</td>
</table>
		</FORM>
		</CENTER>
	</div>
	<div id="pied"></div>
	</div>
	<br></br>

</body>
</html>
<%}%>