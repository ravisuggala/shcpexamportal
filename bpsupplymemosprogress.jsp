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

String examname=request.getParameter("examname");
String branch=request.getParameter("branch");
String degree=request.getParameter("degree");

session.putValue("examname", examname);
session.putValue("branch", branch);
session.putValue("degree", degree);


	
String slno=miscUtil.noNull(request.getParameter("slno"));
String prdate=miscUtil.noNull(request.getParameter("prdate"));
session.putValue("slno", slno);
session.putValue("prdate", prdate);

%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><br><center><h3>Marks Memo Data Sheet is Preparing....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=bpsupplymemospdf';",150);
-->
</script>





		