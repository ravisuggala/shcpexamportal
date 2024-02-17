<%@ page import = "dao.User" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />


<%


	
String degree=miscUtil.noNull(request.getParameter("degree"));
String yoa=miscUtil.noNull(request.getParameter("yoa"));
String branch=miscUtil.noNull(request.getParameter("branch"));
//String udate=miscUtil.noNull(request.getParameter("udate"));

session.putValue("degree", degree);
session.putValue("yoa", yoa);
//session.putValue("sem", sem);
session.putValue("branch", branch);

%>




<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><br><center><h3>AICTE Grade Sheet is Preparing....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=aictedata'",150);
-->
</script>





		