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


String course=request.getParameter("degree");
String sem=request.getParameter("sem");
String ay=request.getParameter("ay");
String month=request.getParameter("month");

session.putValue("degree", course);
session.putValue("sem", sem);
session.putValue("ay", ay);
session.putValue("month", month);
%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><center><h3>Examination Applications are Downloading....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=downloadapplicationsprogress';",150);
-->
</script>





		