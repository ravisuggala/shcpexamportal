
<script language="javascript">
function optiondisplay()
{
	document.cmbentry.submit();
	
}
</script>

	<%
	String sem=request.getParameter("sem");
	session.putValue("sem", sem);
	%>

<body>


<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<center>

<form name="import" action="./oldmarksupload.jsp" method="post" enctype="multipart/form-data">

<table>
<tr>
<th colspan=2 align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Students Data Import Form</th>
<tr>
<td> CSV File:</td>
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






		