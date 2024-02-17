
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
else if(ur.getStatus().equals("ACE"))
	header="./aceheader.jsp";

%>
<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		<title>SVCP--Examination Portal - External Examinations</title>
		<script language="javascript" src="./JS/functions.js"></script>
		<script language="javascript" src="./JS/datetimepicker.js"></script>
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>Generate Fee Portal Sheet for Regular Examination</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./regfeesheetprogress.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep1">
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "feesheet">
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" ><option></option><option value="B.Pharmacy">B.PHARMACY</option> 
        							<option value="M.Pharmacy">M.PHARMACY</option>
        							<option value="Pharm.D">Pharm.D</option> 
        							 </select>
								</TD>
							</TR>
							
							
						  	<TR>
								<TD  WIDTH="20%" ALIGN="right">Semester:</TD>
								<TD  WIDTH="10%" align="left" nowrap>
									<input type=checkbox value='1' name=sem>&nbsp;&nbsp;1</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='2' name=sem>&nbsp;&nbsp;2</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='3' name=sem>&nbsp;&nbsp;3</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='4' name=sem>&nbsp;&nbsp;4</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='5' name=sem>&nbsp;&nbsp;5</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='6' name=sem>&nbsp;&nbsp;6</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='7' name=sem>&nbsp;&nbsp;7</input>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=checkbox value='8' name=sem>&nbsp;&nbsp;8</input>&nbsp;&nbsp;&nbsp;&nbsp;
								</TD>
							</TR>
							<TR>
                                <TD  WIDTH="20%" ALIGN="right" nowrap>Academic Year:<br>(yyyy-yyyy)</br> </TD>
								<td WIDTH="10%" ALIGN="left">
								<%String ay=new dao.SubjectDB().getCurrentAY(); %>
								<input list="ay1" maxlength="10" name="ay" id="ay">
								<datalist id="ay1">
    							<option value="<%=ay%>">
    							</datalist>
								</td>
                                </TR>
													
							<TR>
							    <TD colspan=2 align="center">
							    <INPUT TYPE="SUBMIT" NAME="submit" VALUE="Submit"></INPUT></TD>

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
