<%@ page import = "java.util.*,dao.*" %>


<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%

String sno=request.getParameter("fno").toString().toUpperCase();
int result=new FacultyDB().deleteFacultyInfo(sno);

%>
		    
			    <%
			    if(result>0)
			    {
			    out.println("<h4><center>Faculty Information is Successfully deleted</center></h4>");
			    }
			    else {
			    	out.println("<h4><center>Faculty Information is not deleted</center></h4>");
			    }
			    %>
			    
	
		  
		  
		  
