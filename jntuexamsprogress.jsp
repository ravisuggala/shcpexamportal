<%@ page import = "dao.User" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />


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


	
String degree=miscUtil.noNull(request.getParameter("degree"));
String ay=miscUtil.noNull(request.getParameter("ay"));
String period=miscUtil.noNull(request.getParameter("period"));
String type=miscUtil.noNull(request.getParameter("type"));



session.putValue("degree", degree);
session.putValue("ay", ay);
session.putValue("period", period);
session.putValue("type", type);



%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><br><center><h3>JNTU Examination Details are downloading....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=downloadjntuexams';",150);
-->
</script>





		