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


String examname=request.getParameter("examname");
//System.out.println(examname);
session.putValue("examname", examname);
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
<br></br>
<br></br>
<br></br>
<center>

<form name="import" action="./supplyregsupload.jsp" method="post" enctype="multipart/form-data">

<table>
<tr>
<th colspan=2 align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Supplementary/Revaluation Registrations Import Form</th>
<tr>
<td> Excel File:</td>
<td><input type="file" name="filename"></input></td></tr>
<tr><td colspan=2 align=center>
<input type="submit" value="Import"></input>
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






		