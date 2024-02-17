
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "dao.User,dao.StudentDB,java.util.ArrayList" %>


<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
if(ur.getStatus().equals("admin"))
	header="./adminheader.jsp";
else if(ur.getStatus().equals("clerk"))
	header="./mainmenuheader.jsp";
ArrayList regs=new StudentDB().getRegulations();
	
%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		<title>SVECW--Examination Portal - Mid Examinations</title>


		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>Seminar Marks Entry</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./seminarStep2.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "seminarstep1">
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Branch Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option><option value="B.TECH">B.TECH</option> 
        							<option value="M.TECH">M.TECH</option> <option value="M.B.A">M.B.A</option> <option 
        							value="M.C.A">M.C.A</option>  </select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Branch: </TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="branch" id="branch"><option></option><option value="E.E.E">E.E.E</option> 
        							<option value="E.C.E">E.C.E</option> <option value="C.S.E">C.S.E</option> <option 
        							value="I.T">I.T</option> <option value="MECH">MECH</option> <option 
        							value="CIVIL">CIVIL</option>
        							<option value="M.B.A">M.B.A</option> <option 
        							value="M.C.A">M.C.A</option>
        							 </select>
								</TD>
							</TR>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="sem" id="sem">
								<option></option>
									<option value="I-I">I YEAR - I SEM</option> 
        							<option value="I-II">I YEAR - II SEM</option> <option value="II-I">II YEAR - I SEM</option> <option 
        							value="II-II">II YEAR - II SEM</option> 
        							<option value="III-I">III YEAR - I SEM</option>
        							<option value="III-II">III YEAR - II SEM</option>
        							<option value="IV-I">IV YEAR - I SEM</option>
        							<option value="IV-II">IV YEAR - II SEM</option>
        							</select></TD></TR>
        							
        							<TR>
								<TD  WIDTH="20%" ALIGN="right">Section </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="section">
								<option></option>
									<option value="A">A</option>
									 <option value="B">B</option>
									 <option value="C">C</option>
									 <option value="D">D</option>
									 <option value="E">E</option>
									 
        							</select>
        						</td>
        						</tr>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Academic Year:<br>(yyyy-yyyy)</br> </TD>
								<td WIDTH="10%" ALIGN="left"><input maxlength="10" name="ay"></td></tr>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Regulation </TD>
								<td WIDTH="10%" ALIGN="left">
								<select id="reg" name=reg " onChange="toggle(this);">
								<option value="-">-</option>
								
									<%
										for(int i=0;i<regs.size();i++)
										{
											String sub=regs.get(i).toString();
											
											%>
											<option value='<%=sub %>'><%=sub %></option>
											<%
											
										}
									%>
									</select> 
        						</td></tr>
							
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
