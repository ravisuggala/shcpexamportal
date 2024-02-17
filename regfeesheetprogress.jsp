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
String ay=utility.noNull(request.getParameter("ay"));

ArrayList sems=new ArrayList(Arrays.asList(request.getParameterValues("sem")));

session.setAttribute("degree", degree);

session.setAttribute("sems", sems);

session.setAttribute("ay", ay);
%>

<jsp:include page='<%= header %>' flush="true" />


<script type="text/JavaScript">
<!--
document.writeln("<br><br><br><br><br><center><h3>Student data is Generating....Please Wait..<br></br></h3></center>");
setTimeout("location.href = '././ActionServlet?option=regfeesheet';",150);
-->
</script>





		