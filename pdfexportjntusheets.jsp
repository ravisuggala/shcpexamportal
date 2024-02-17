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




String fname=miscUtil.noNull(miscUtil.getFromSession(request, response, "fname"));
String filepath = "./excelfiles/"+fname;
%>

<jsp:include page='<%= header %>' flush="true" />



<br></br>
<br></br>
<br></br>
<center>
<font face="tahoma" size=3 color=red>JNTU PDF Sheets. <a href="<%=filepath %>" target="_blank"> <img src="./imgs/download.jpg" align=center width=150 height=40></img></a></font> 

</center>	
	
<br></br>
<br></br>
<br></br>





		