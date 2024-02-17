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

	
String eid=miscUtil.noNull(request.getParameter("examname"));
String rcode=miscUtil.noNull(request.getParameter("rcode"));
String revdate=miscUtil.noNull(request.getParameter("revdate"));
String stype=miscUtil.noNull(request.getParameter("stype"));


session.putValue("eid", eid);
session.putValue("stype", stype);
session.putValue("rcode", rcode);
session.putValue("revdate", revdate);

%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><br><center><h3>Website Data Sheet is Preparing....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=websitesheet';",150);
-->
</script>





		