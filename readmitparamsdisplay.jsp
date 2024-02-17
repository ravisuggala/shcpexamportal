
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String degree=miscUtil.noNull(session.getValue("degree").toString());
String yoa=miscUtil.noNull(session.getValue("yoa").toString());
String fromsem=miscUtil.noNull(session.getValue("fromsem").toString());
String ay=miscUtil.noNull(session.getValue("ay").toString());

List <String> selectionList=new ArrayList <String>();
ArrayList detains=new ArrayList();
Enumeration<String> paramNames = request.getParameterNames();
ArrayList readmitlist=new ArrayList();
while(paramNames.hasMoreElements()) {
    String paramName = paramNames.nextElement();

    if (!paramName.endsWith("_option")) continue; // Skip checkboxes. Only process hidden fields

    String [] options = request.getParameterValues(paramName); // All options
    String [] selections = request.getParameterValues(paramName.replace("_option", "")); // Real checkboxes

    selectionList = Arrays.asList(selections); // Easier to work with
    
    session.putValue("stlist", selectionList);

    ArrayList dtlist=(ArrayList)session.getValue("dtlist");
    int i=0;
    for( i=0;i<selectionList.size();i++)
    {
    	Student st=miscUtil.getStudentFromList(dtlist,selectionList.get(i).toString());
    	String admitsem=request.getParameter(st.getRegdno()+"-admitsem");
    	String section=request.getParameter(st.getRegdno()+"-section");
    	String reyoa=request.getParameter(st.getRegdno()+"-yoa");
    	st.setReadmitSem(admitsem);
    	st.setSection(section);
    	st.setReadmitay(ay);
    	st.setReadmityoa(reyoa);
    	readmitlist.add(st);
    	
    }
    if(i>=selectionList.size()) break;
    
    // Iterate through checkbox group options
    
}

session.putValue("readmitlist", readmitlist);


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
					
				    <FORM NAME="CANCELFORM" ACTION="./readmitparam2.jsp" METHOD="POST">
					<INPUT TYPE = "HIDDEN" NAME = "modify" VALUE = "modify">
					</FORM>
	
					   <CENTER>
						<TABLE BORDER="1" >
							<TR>
							    <TD COLSPAN="7" ALIGN="center"><h2><b> Students ReAdmission Information </b></h2></TD>
							</TR>
							
							<TR>
								<Th ALIGN="center">Regdno </TD>
								<Th ALIGN="center">Name </TD>
								<Th ALIGN="center">Detained Semester </TD>
								<Th ALIGN="center">ReAdmit Semester </TD>
								<Th ALIGN="center">Section </TD>
								<Th ALIGN="center">Branch </TD>
								<Th ALIGN="center">Academic Year </TD>
								<Th ALIGN="center">ReAdmit Year </TD>
								
							</TR>
							
							<%
							for(int i=0;i<readmitlist.size();i++)
							{
								Student std=(Student)readmitlist.get(i);
								
								%>
								
								<tr>
								<td align=left nowrap><%=std.getRegdno() %></td>
								<td align=left nowrap><%=std.getName() %></td>
								<td align=left nowrap><%=std.getSem() %></td>
								<td align=left nowrap><%=std.getReadmitSem() %></td>
								<td align=left nowrap><%=std.getSection() %></td>
								<td align=left nowrap><%=std.getBranch() %></td>
								<td align=left nowrap><%=std.getReadmitay() %></td>
								<td align=left nowrap><%=std.getReadmityoa() %></td>
								</tr>
							<%} %>
							
							
							
							
							
							
                         	<TR>
                         	<FORM NAME = REGISTER METHOD = POST ACTION = "./readmitprogress.jsp">
							
							
							
								<TD align="center" colspan=8><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="Submit"></INPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<INPUT TYPE="BUTTON" NAME="Modify" VALUE="Modify" onClick="document.CANCELFORM.submit()"></TD>
					       </FORM>
							</TR>
							
						</TABLE>
	<br></br>
	</body>
</html>
