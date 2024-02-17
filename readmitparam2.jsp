
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String degree="";
String branch="";
String yoa="";
String fromsem="";
String tosem="";
String section="";
String ay="";

String modify=miscUtil.noNull(request.getParameter("modify"));

if(!modify.equals("modify"))
{
 degree=miscUtil.noNull(request.getParameter("degree"));

yoa=miscUtil.noNull(request.getParameter("yoa"));
 fromsem=miscUtil.noNull(request.getParameter("fromsem"));
ay=miscUtil.noNull(request.getParameter("ay"));


session.putValue("degree", degree);

session.putValue("yoa", yoa);
session.putValue("fromsem", fromsem);
session.putValue("ay", ay);

}
else
{
	 degree=miscUtil.noNull(session.getValue("degree").toString());
	yoa=miscUtil.noNull(session.getValue("yoa").toString());
	 fromsem=miscUtil.noNull(session.getValue("fromsem").toString());
	 ay=miscUtil.noNull(session.getValue("ay").toString());


}

ArrayList stlist=stdb.getDetainedStudentList(degree,  fromsem,yoa);
session.putValue("dtlist", stlist);
String disp="List of  "+fromsem+" "+" Students";

%>	
	
	<script language=javascript>

function toggle(source) {
	  checkboxes = document.getElementsByName('regdnos');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	

function untoggleall(isEnabled,regdno) {
	document.getElementById(regdno+"-admitsem").disabled = !isEnabled;
    document.getElementById(regdno+"-section").disabled = !isEnabled;
    document.getElementById(regdno+"-yoa").disabled = !isEnabled;
}
	
</script>		

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
					
	
					    <center><h3>Student ReAdmission</h3></center>
					    <CENTER>
				
							<FORM NAME = REGISTER METHOD = POST ACTION = "./readmitparamsdisplay.jsp">
<% 							
if(stlist.size()>0)
{
	
%>
<table align=center border=1>
<tr>
<td align=center>Sl.No</td>
<td align=center>Regdno</td>
<td align=center>Name of the Student</td>
<td align=center>Select</td>
<td align=center>ReAdmit Semester</td>
<td align=center>Section</td>
<td align=center>YearOfAdmission</td>
</tr>
<% 

	for(int i=0;i<stlist.size();i++)
	{
		Student st=(Student)stlist.get(i);

	
%>


<tr>
<td><%=i+1 %></td>
<td nowrap><%=st.getRegdno() %></td>
<td nowrap><%=st.getName() %></td>
<TD align=center><input type="checkbox" name="regdnos" value='<%=st.getRegdno() %>' onclick="untoggleall(this.checked,'<%=st.getRegdno()%>')"></input>
<td>
<select name='<%=st.getRegdno()%>-admitsem' id='<%=st.getRegdno()%>-admitsem' disabled>
									<option></option>
									<option value="I-I" >I YEAR - I SEM</option> 
        							<option value="I-II" >I YEAR - II SEM</option> 
        							<option value="II-I" >II YEAR - I SEM</option> 
        							<option value="II-II">II YEAR - II SEM</option> 
        							<option value="III-I">III YEAR - I SEM</option>
        							<option value="III-II">III YEAR - II SEM</option>
        							<option value="IV-I" >IV YEAR - I SEM</option>
        							<option value="IV-II" >IV YEAR - II SEM</option>
        							</select></TD>
 <td>
 <select name='<%=st.getRegdno()%>-section' id='<%=st.getRegdno()%>-section' disabled>
								<option></option>
									<option value="A">A</option>
									 <option value="B">B</option>
									 <option value="C">C</option>
									 <option value="D">D</option>
									 <option value="E">E</option>
									 <option value="F">F</option>
									 <option value="G">G</option>
									 <option value="H">H</option>
									 <option value="I">I</option>
									 <option value="J">J</option>
									 <option value="K">K</option>
									 <option value="L">L</option>
        							</select>
        					
 </td>
<td>
 <input type=text size=6 name='<%=st.getRegdno()%>-yoa' id='<%=st.getRegdno()%>-yoa' disabled>
								
        					
 </td>
        					
<input type="hidden" name="regdnos_option" value='<%=st.getRegdno() %>' />
</TD>
</tr>

<% }  %>
							<TR>
			<TD colspan=7 rowspan=2 align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>
							</TR>

</table>
<%
}
else
	
out.println("<center><br><br><h3>No Students for selected branch and section</h3></center>");
%>			
				
	<br></br>
	</body>
</html>
