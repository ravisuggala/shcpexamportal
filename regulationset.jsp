
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%

String degree=miscUtil.noNull(request.getParameter("degree"));
String yoa=miscUtil.noNull(request.getParameter("yoa"));
String type=miscUtil.noNull(request.getParameter("type"));
String reg="";
if(type.equals("old"))
 reg=miscUtil.noNull(request.getParameter("reg"));
else if(type.equals("new"))
	reg=miscUtil.noNull(request.getParameter("regtext"));
String res=stdb.setRegulation(degree,yoa,reg);


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
	
	
	<body>
		  <div id="centre">
					
	
					    
					    <CENTER>
					    <br></br>
					    <br></br>
					    <br></br>

						<h3><%=res %></h3>	

					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	</body>
</html>
