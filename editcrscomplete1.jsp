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


<script language="javascript">
function optiondisplay()
{
	document.cmbentry.submit();
	
}
</script>

	

<body>


<br></br>
<br></br>
<center>

<form name="import" action="./ActionServlet" method="post" >
<INPUT TYPE=HIDDEN NAME="option" VALUE = "editcrscomplete">
<table>
<tr>
<th colspan=2 align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Course Completion Edit Form</th>
<tr>
<td> Student Registration Number:</td>
<td><input type="text" name="regdno"></input></td></tr>
<tr><td colspan=2 align=center>
<input type="submit" value="Edit"></input>
</td></tr>
</table>
</form>
</center>

<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>






		