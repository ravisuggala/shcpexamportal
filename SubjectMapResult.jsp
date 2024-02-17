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
<center><h3>
<% 
String str;
if((str=(String)session.getAttribute("subjmapresult"))!=null)
	out.println(str);
	%>
<br></br>	
<br></br>
<FORM NAME = REGISTER METHOD = POST ACTION = "./MapSubject2.jsp">
		<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "mapresult">
	</FORM>
							
<a href="#" onClick="document.REGISTER.submit()">Click Here for another subject in the same branch</a><br></br>
<a href="./MapSubject1.jsp">Click Here for another branch</a>

</h3>
</center>	
	
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>





		