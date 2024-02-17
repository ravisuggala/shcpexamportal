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

<head>

<style>
a.set1
{
font-size: 15px;
}
		a.set1:link {color: #9922aa;}
		a.set1:visited {color: #666699;}
		a.set1:hover {font-size:20; font-weight:bold; color: red;  background-color: #ccc;}
		a.set1:active {color: #336699;}"


</style>


</head>

<br></br>
<br></br>
<br></br>

<center><h3>
<% 
String str;
if((str=(String)session.getAttribute("importresult"))!=null)
	out.println(str);
	%>
	
<br></br>

<FORM NAME = REGISTER1 METHOD = POST ACTION = "./freelectivemapping1.jsp">
		<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "mapresult">
	</FORM>

</h3>							

<font face=tahoma size=2><a class=set1 href="#" onClick="document.REGISTER1.submit()" >Click Here for another Branch and section</a></font><br></br>


</center>	
	
<br></br>
<br></br>



		