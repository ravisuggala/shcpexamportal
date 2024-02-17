
<%@ page import="java.util.*,dao.*"%>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id="fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id="subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id="exdb" scope="session" class="dao.ExternalExamDB" />

<%


String examcode=miscUtil.noNull(request.getParameter("exam"));
String regdno=miscUtil.noNull(request.getParameter("regdno"));

session.setAttribute("examname", examcode);
session.setAttribute("regdno",regdno);

ExternalExamDB eedb=new ExternalExamDB();
ExternalExam ee=eedb.getExamInfo(examcode);
ArrayList regdsubs=eedb.getRegisteredSubjects(examcode,regdno);
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
else if(ur.getStatus().equals("ACE"))
	header="./aceheader.jsp";

	
%>

<jsp:include page='<%= header %>' flush="true" />


<body>
	<div id="centre">
		<center>
			<h2>External Examinations Registration</h2>
		</center>
		<CENTER>
			<FORM NAME=REGISTER METHOD=POST ACTION="./RegistrationDelete.jsp" onsubmit="return confirm('Are you sure?');" >
				<INPUT TYPE=HIDDEN NAME="option" VALUE="delreg">

				<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
					<TR>
						<TD COLSPAN="3" ALIGN="center"><h5>
								<b> List of Registered Subjects for regdno::<%=regdno %></b>
								</h2>
						</TD>
					</TR>


					<TR>

						<th>Subject Code</th>
						<th nowrap>Subject Name</th>
						<th>Check</th>
					</tr>
	<%
	for(int i=0;i<regdsubs.size();i++)
	{
		String sub=regdsubs.get(i).toString();
		String sname=new SubjectDB().getSubjectTitle(sub, ee.getReg());
	%>
					<tr>
						<td><%=sub %></td>
						<td><%=sname %>
						<td><input type=checkbox name=subjects value=<%=sub%>>
						</td>
					</tr>

					<% }%>

					<tr>
						<td colspan=4 align=center><input type=submit value=Delete>
						</td>
				</table>
			</FORM>
		</CENTER>



	</div>
	<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>

</body>
</html>
