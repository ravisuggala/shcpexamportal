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
String branch=miscUtil.noNull(request.getParameter("branch"));
String sem=miscUtil.noNull(request.getParameter("sem"));
String reg=miscUtil.noNull(request.getParameter("reg"));
String ay=miscUtil.noNull(request.getParameter("ay"));
String eid=miscUtil.noNull(request.getParameter("examname"));


session.putValue("degree", degree);
session.putValue("branch", branch);
session.putValue("sem", sem);
session.putValue("reg", reg);
session.putValue("ay", ay);
session.putValue("examname", eid);


%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><br><center><h3>M.Pharmacy Evaluations Sheet is Preparing....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=mpevaluationsheet';",150);
-->
</script>





		