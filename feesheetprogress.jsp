<%@ page import = "dao.User,dao.FBSMiscUtilitiesBean,java.util.*" %>


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

FBSMiscUtilitiesBean utility=new FBSMiscUtilitiesBean();

String degree=utility.noNull(request.getParameter("degree"));
String examtype=utility.noNull(request.getParameter("examtype"));
String type=utility.noNull(request.getParameter("type"));

ArrayList sems=new ArrayList(Arrays.asList(request.getParameterValues("sem")));
String ldate1=utility.noNull(request.getParameter("ldate1"));
String ldate2=utility.noNull(request.getParameter("ldate2"));
String ldate3=utility.noNull(request.getParameter("ldate3"));

session.setAttribute("degree", degree);
session.setAttribute("type", type);
session.setAttribute("sems", sems);
session.setAttribute("examtype", examtype);
session.setAttribute("ldate1", ldate1);
session.setAttribute("ldate2", ldate2);
session.setAttribute("ldate3", ldate3);
%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><center><h3>Fee Portal Sheet is Downloading....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=feesheet';",150);
-->
</script>





		