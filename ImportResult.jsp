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
if((str=(String)session.getAttribute("importresult"))!=null)
	out.println(str);

if(session.getAttribute("target")!=null)
{
	String target=session.getAttribute("target").toString();
	
	if(target.equals("smap"))
%>
	

<br><br>
<a href="javascript:history.back();"><font size=3 color=red>&lt;&lt;Back</font></a>
<%

session.removeAttribute("target");
} %>
</h3>
</center>	
	
<br></br>
<br></br>
<br></br>





		