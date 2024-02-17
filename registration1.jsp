
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
else if(ur.getStatus().equals("office"))
	header="./feemenuheader.jsp";

String type=request.getParameter("type");
if(type.equals("SRV"))
	type="SUPPLY REVALUATION";
else if(type.equals("ST"))
	type="SPECIAL THEORY";

session.setAttribute("type", type);
%>
<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h2><%=type %> Examination Registration Process</h2></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./registration2.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapElective1">
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Student Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Regd.No</br> </TD>
								<td WIDTH="10%" ALIGN="left"><input maxlength="10" name="regdno"></td></tr>
							
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="sem">
								<option></option>
										<option value="1" >1</option> 
        							<option value="2" >2</option> 
        							<option value="3" >3</option> 
        							<option value="4" >4</option> 
        							<option value="5" >5</option>
        							<option value="6" >6</option>
        							<option value="7" >7</option>
        							<option value="8" >8</option>
        							</select></TD></TR>
        					
							
							
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
