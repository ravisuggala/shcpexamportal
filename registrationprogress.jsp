<%@ page import = "dao.User" %>
<jsp:useBean id="miscUtil" scope="session"
	class="dao.FBSMiscUtilitiesBean" />


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

String eid=miscUtil.noNull(request.getParameter("examname"));
System.out.println(eid);
session.putValue("examname", eid);
	
%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><center><h3>Examination Registrations is in Progress....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=registrationprogress';",150);
-->
</script>





		