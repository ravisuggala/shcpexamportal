
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String degree=miscUtil.noNull(session.getValue("degree").toString());
String branch=miscUtil.noNull(session.getValue("branch").toString());
String yoa=miscUtil.noNull(session.getValue("yoa").toString());
String fromsem=miscUtil.noNull(session.getValue("fromsem").toString());
String tosem=miscUtil.noNull(session.getValue("tosem").toString());
String section=miscUtil.noNull(session.getValue("section").toString());
List <String> selectionList=new ArrayList <String>();
ArrayList detains=new ArrayList();
Enumeration<String> paramNames = request.getParameterNames();
while(paramNames.hasMoreElements()) {
    String paramName = paramNames.nextElement();

    if (!paramName.endsWith("_option")) continue; // Skip checkboxes. Only process hidden fields

    String [] options = request.getParameterValues(paramName); // All options
    String [] selections = request.getParameterValues(paramName.replace("_option", "")); // Real checkboxes

    selectionList = Arrays.asList(selections); // Easier to work with
    
    session.putValue("stlist", selectionList);

    // Iterate through checkbox group options
    int index=0;
    for (String o : options) {
        boolean contains = selectionList.contains(o);
        if(!contains)
        	detains.add(index++,o);	
        // Do something with it. Write yes/no to file for example...
    }
}

session.putValue("detains", detains);
session.putValue("prst",selectionList);
String bysm=fromsem+" "+branch+" - "+section;
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
					
				    <FORM NAME="CANCELFORM" ACTION="./promotionparam2.jsp" METHOD="POST">
					<INPUT TYPE = "HIDDEN" NAME = "modify" VALUE = "modify">
					</FORM>
	
					   <CENTER>
						<TABLE BORDER="1" >
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h2><b> Students Promotion Information </b></h2></TD>
							</TR>
							
							<TR>
								<TD ALIGN="left">Course: </TD>
								<TD  align="left">
								<%= degree %>
								</TD>
							</TR>
							
							<TR>
								<TD ALIGN="left" nowrap>Year & Branch: </TD>
								<TD  align="left">
								<%= bysm %>
								</TD>
							</TR>
							<TR>
								<TD ALIGN="left" nowrap>Promoting Semester: </TD>
								<TD  align="left">
								<%= tosem%>
								</TD>
							</TR>
							
							<TR>
								<TD ALIGN="left" nowrap>Detained Students: </TD>
								<TD  align="left">
								<%= detains.size()>0?detains.toString():"NILL" %>
								</TD>
							</TR>
							
                         	<TR>
                         	<FORM NAME = REGISTER METHOD = POST ACTION = "./promotionprogress.jsp">
							
							
							
								<TD align="center" colspan=2><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Submit"></INPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<INPUT TYPE="BUTTON" NAME="Modify" VALUE="Modify" onClick="document.CANCELFORM.submit()"></TD>
					       </FORM>
							</TR>
							
						</TABLE>
	<br></br>
	</body>
</html>
