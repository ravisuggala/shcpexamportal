<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%

String subjs[]=request.getParameterValues("fmapid");
int cnt=0;
if(subjs.length!=0)
{
	for(int i=0;i<subjs.length;i++)
	{
		String subcode=subjs[i].split("-")[1];
		String subvalue=miscUtil.noNull(request.getParameter(subcode+"f"));
		int ret=new FacultyDB().updateMapping(subjs[i],subvalue);
		if(ret>0)
			cnt++;
	}   
}

String status=cnt+" Faculty mapping(s) are updated successfully";

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

	
%>

<jsp:include page='<%= header %>' flush="true" />


<html>
	
	<body>
		  <div id="centre">
		<center>	    <br><br><br>
			   <h3> <%=status %></h3>
				</center>	   
		  </div>
		<div id="pied"></div>
	</div>
	</body>
</html>
