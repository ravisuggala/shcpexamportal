
<!DOCTYPE html>
<%@ page import = "dao.User,dao.StudentDB,java.util.ArrayList" %>


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

String odegree=request.getParameter("degree");
String obranch=request.getParameter("branch");
String oreg=request.getParameter("reg");
String osubject=request.getParameter("subject");

session.setAttribute("odegree", odegree);
session.setAttribute("obranch", obranch);
session.setAttribute("oreg", oreg);
session.setAttribute("osubject", osubject);


%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		

		
	</head>
	<body>
		  <div id="centre">
	
					    <center><h1>Open Elective Parameters</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "oeselection">
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Open Elective Parameters</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Name of the elective:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="oename" id="oename" required><option></option>
									<option value="Open Elective-I">Open Elective-I</option> 
        							<option value="Open Elective-II">Open Elective-II</option> 
        							<option value="Open Elective-III">Open Elective-III</option> 
        							<option value="Open Elective-IV">Open Elective-IV</option>
        							  </select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right" nowrap>Subject Order: </TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="suborder" id="suborder" required><option></option>
									<option value="1">1</option> 
        							<option value="2">2</option> 
        							<option value="3">3</option> 
        							<option value="4">4</option>
        							<option value="5">5</option> 
        							<option value="6">6</option>
        							<option value="7">7</option> 
        							<option value="8">8</option>
        							<option value="9">9</option>
        							<option value="10">10</option>
        							</select>
								</TD>
							</TR>
							<TR>
							    <TD colspan=2 align="center">
							    <INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>

							</TR>
							</FORM>
						</TABLE>
					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	</body>
</html>
