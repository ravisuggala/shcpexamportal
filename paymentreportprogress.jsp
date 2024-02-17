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
else if(ur.getStatus().equals("ace"))
	header="./aceheader.jsp";


String degree=request.getParameter("degree");
String sem=request.getParameter("sem");
String examtype=request.getParameter("type");

session.setAttribute("degree", degree);
session.setAttribute("sem", sem);
session.setAttribute("examtype", examtype);


%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><center><h3>Registration Details Report is Downloading....Please Wait..<br></br></h3></center>");
setTimeout("location.href = './ActionServlet?option=paymentreport';",150);
-->
</script>





		