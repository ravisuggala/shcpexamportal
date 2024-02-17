
<head>
<script language="javascript" src="./JS/FormChek.js"></script>
<script type="text/javascript" src="./JS/jquery-1.4.2.min.js">  </script>
<script type="text/javascript" src="./JS/functions.js">  </script>

</head>
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%


/*SELECT * FROM examcell.mids where mapid in 
(select mapid from mapsubjects where 
		ay='2015-2016' and branch='MECH' and regulation='R14-R' and sem='I-I' and subcode='UGBS1T01');*/
ArrayList marksrows=new ArrayList();
String status="";
String title="";

String degree=miscUtil.noNull(request.getParameter("degree"));
String branch=miscUtil.noNull(request.getParameter("branch"));
String sem=miscUtil.noNull(request.getParameter("sem"));
String ay=miscUtil.noNull(request.getParameter("ay"));

String section=miscUtil.noNull(request.getParameter("section"));
String cat=miscUtil.noNull(request.getParameter("cat"));
String reg=miscUtil.noNull(request.getParameter("reg"));

session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("ay",ay);
session.putValue("section",section);

session.putValue("reg",reg);


String subject=request.getParameter("subject");
session.putValue("subject", subject);






%>

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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";

	
%>

<jsp:include page='<%= header %>' flush="true" />

<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><br><br><br><br><br><center><h3>Mid Marks Details are downloading....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=labexcelprogress';",150);
-->
</script>
</html>
