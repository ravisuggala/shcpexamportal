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

%>
<jsp:include page='<%= header %>' flush="true" />



<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<center><h3>
<% 
String str;
if((str=(String)session.getAttribute("status"))!=null)
{
	out.println(str);
session.removeAttribute("status");
session.setAttribute("target", "status");
}
	

%>
	

<br><br>






</h3>
</center>	
	
<br></br>
<br></br>
<br></br>





		