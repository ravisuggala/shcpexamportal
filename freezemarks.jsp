<%@ page import = "dao.*,java.util.*" %>



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

String status=session.getValue("status").toString()	;	
%>

<jsp:include page='<%= header %>' flush="true" />



<br></br>
<br></br>
<center><h5><%=status %></h5>	
	
<br>




