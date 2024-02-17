
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

String modify=miscUtil.noNull(request.getParameter("modify"));

if(!modify.equals("modify"))
{
 degree=miscUtil.noNull(request.getParameter("degree"));
 branch=miscUtil.noNull(request.getParameter("branch"));
yoa=miscUtil.noNull(request.getParameter("yoa"));
 fromsem=miscUtil.noNull(request.getParameter("fromsem"));
 tosem=miscUtil.noNull(request.getParameter("tosem"));
 section=miscUtil.noNull(request.getParameter("section"));

session.putValue("degree", degree);
session.putValue("branch", branch);
session.putValue("yoa", yoa);
session.putValue("fromsem", fromsem);
session.putValue("tosem", tosem);
session.putValue("section", section);
}
else
{
	 degree=miscUtil.noNull(session.getValue("degree").toString());
	 branch=miscUtil.noNull(session.getValue("branch").toString());
	yoa=miscUtil.noNull(session.getValue("yoa").toString());
	 fromsem=miscUtil.noNull(session.getValue("fromsem").toString());
	tosem=miscUtil.noNull(session.getValue("tosem").toString());
	 section=miscUtil.noNull(session.getValue("section").toString());

}
ArrayList stlist=stdb.getStudentList(degree, branch, fromsem, section,yoa);

String disp="List of  "+fromsem+" "+branch+" Students";

%>	
	
	<script language=javascript>

function toggle(source) {
	  checkboxes = document.getElementsByName('regdnos');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	

function untoggleall(source) {
	var flg=0;
	all=document.getElementById('all');
	  checkboxes = document.getElementsByName('regdnos');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
		  if(checkboxes[i].checked==false)
			  {
			  flg=1;
			  break;
			  }
	  }
	  if(flg==0)
		  all.checked=true;
	  else
		  all.checked=false;
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
					
	
					    <center><h3>Student Promotions</h3></center>
					    <CENTER>
				
							<FORM NAME = REGISTER METHOD = POST ACTION = "./promotionparamsdisplay.jsp">
<% 							
if(stlist.size()>0)
{
	
%>
<table align=center border=1>
<tr>
<td align=center>Sl.No</td>
<td align=center>Regdno</td>
<td align=center>Name of the Student</td>
<td align=center>Check<br></br> <input type="checkbox" id ="all" onClick="toggle(this)" /></td>
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
<TD align=center><input type="checkbox" name="regdnos" value='<%=st.getRegdno() %>' onclick="untoggleall(this)"></input>
<input type="hidden" name="regdnos_option" value='<%=st.getRegdno() %>' />
</TD>
</tr>

<% }  %>
							<TR>
			<TD colspan=4 rowspan=2 align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>
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
