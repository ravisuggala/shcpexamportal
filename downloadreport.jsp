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
else if(ur.getStatus().equals("office"))
	header="./feemenuheader.jsp";
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";


%>

<%

String report=session.getAttribute("report").toString();
String filename="http://localhost:8080/shcpexamportal/"+session.getAttribute("filename").toString();
//String filename="http://10.0.12.222/svcpexamportal/"+session.getAttribute("filename").toString();
%>



<jsp:include page='<%= header %>' flush="true" />

<br></br>
<br></br>
<br></br>
<center>
<font face="tahoma" size=3 color=red><%=report %><br> <a href=<%=filename %> target="_blank"> <br><br><img src="./imgs/download.jpg" align=center width=150 height=40></img></a></font> 

</center>	
	
<br></br>
<br></br>
<br></br>





		