
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String degree="";

String yoa="";

String type="";
String yoc="";


 degree=miscUtil.noNull(request.getParameter("degree"));
 
yoa=miscUtil.noNull(request.getParameter("yoa"));
type=miscUtil.noNull(request.getParameter("selection"));
yoc= miscUtil.noNull(request.getParameter("month"));
session.putValue("degree", degree);

session.putValue("yoa", yoa);
session.putValue("type", type);
session.putValue("yoc", yoc);

ArrayList stlist=stdb.getStudentList(degree, yoa);

String disp="List of  "+yoa+" "+" Batch Students";

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
					
	
					    <center><h3>Course Completed Students</h3></center>
					    <CENTER>
				
							<FORM NAME = REGISTER METHOD = POST ACTION = "./crscompletedisplay.jsp">
<% 							
if(stlist.size()>0)
{
	
%>
<table align=center border=1>
<tr>
<td colspan=4 ><%=disp %></td>
</tr>
<tr>
<th align=center>Sl.No</td>
<th align=center>Regdno</td>
<th align=center>Name of the Student</td>
<th align=center>Check<br></br> <input type="checkbox" id ="all" onClick="toggle(this)" /></td>
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
	
out.println("<center><br><br><h3>No Students for selected degree and year</h3></center>");
%>			
				
	<br></br>
	</body>
</html>
