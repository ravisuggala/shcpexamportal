
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String degree=miscUtil.noNull(session.getValue("degree").toString());
String yoa=miscUtil.noNull(session.getValue("yoa").toString());
String type=miscUtil.noNull(session.getValue("type").toString());

ArrayList <String> selectionList=new ArrayList <String>();
ArrayList unselect=new ArrayList();
Enumeration<String> paramNames = request.getParameterNames();
while(paramNames.hasMoreElements()) {
    String paramName = paramNames.nextElement();

    if (!paramName.endsWith("_option")) continue; // Skip checkboxes. Only process hidden fields

    String [] options = request.getParameterValues(paramName); // All options
    String [] selections = request.getParameterValues(paramName.replace("_option", "")); // Real checkboxes

    selectionList = new ArrayList(Arrays.asList(selections)); // Easier to work with
    
    

    // Iterate through checkbox group options
    int index=0;
    for (String o : options) {
        boolean contains = selectionList.contains(o);
        if(!contains)
        	unselect.add(index++,o);	
        // Do something with it. Write yes/no to file for example...
    }
    
}
if(type.equals("completed"))
{
	session.putValue("completed", selectionList);
	session.putValue("notcompleted", unselect);
}
else if(type.equals("not_completed"))
{
	session.putValue("notcompleted", selectionList);
	session.putValue("completed", unselect);
}

ArrayList displaylist=new ArrayList();
String title="";
if(selectionList.size()<=unselect.size())
{
	displaylist=new ArrayList(selectionList);
	title=(type.equals("completed"))?"Completed Students":"Not Completed List";
}
else
{
	displaylist=new ArrayList(unselect);
	title=(type.equals("completed"))?"Not Completed Students":"Completed List";
}
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
						<TABLE BORDER="1" >
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> Course Completed Students Information </b></h2></TD>
							</TR>
							
							<TR>
								<TD ALIGN="left">Course: </TD>
								<TD  align="left">
								<%= degree %>
								</TD>
							</TR>
							
							<TR>
								<TD ALIGN="left" nowrap>Admitted Year: </TD>
								<TD  align="left">
								<%= yoa %>
								</TD>
							</TR>
							
							<TR>
								<TD ALIGN="left" nowrap><%=title %>: </TD>
								<TD  align="left">
								<%= displaylist.toString() %>
								</TD>
							</TR>
							
                         	<TR>
                         	<FORM NAME = REGISTER METHOD = POST ACTION = "./crscompletprogress.jsp">
							   <TD align="center" colspan=2><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Submit"></INPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</FORM>
							</TR>
							
						</TABLE>
	<br></br>
	</body>
</html>
