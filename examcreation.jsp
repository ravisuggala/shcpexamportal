
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 

<%@ page import = "dao.User,java.util.*" %>
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />
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


ArrayList yoas=stdb.getYoas();
ArrayList regs=stdb.getRegulations();
%>
<jsp:include page='<%= header %>' flush="true" />

	

<html>
	<head>
		
<link rel="stylesheet" type="text/css" href="CSS/StyleCalender.css">

<script type="text/javascript" language="javascript" src="JS/CalendarControl.js"></script>
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>External Examination Creation</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "examcreate">
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option>
									<option value="B.PHARMACY">B.PHARMACY</option> 
        							<option value="M.PHARMACY">M.PHARMACY</option>  </select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester/Year: </TD>
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
        							
        					<tr>
							<td WIDTH="20%" ALIGN="right" nowrap>Month</td>
							<td>
							<input name="month" type="text" id="dpMonthYear" value="" style="width:80px;" />
							<img alt="Month/Year Picker" onclick="showCalendarControl('dpMonthYear');" 
				src="imgs/datepicker.gif" />
							</td>
							
							</tr>
        					<TR>
								<TD  WIDTH="20%" ALIGN="right">Type </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="type">
								<option></option>
									<option value="regular">Regular</option>
									 <option value="supply">Supplementary</option>
									 <option value="revaluation">Revaluation</option>
									 <option value="SUPPLY REVALUATION">Supply Revaluation</option>
									 <option value="Special Theory">Special Theory</option>
									 
								</select> 
        						</td>
        						</tr>
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Regulation </TD>
								<td WIDTH="10%" ALIGN="left">
								<select id="reg" name=reg ">
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
									</select>        						</td></tr>
							
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
								<TD  WIDTH="20%" ALIGN="right" nowrap>Admitted Batch:</TD>
								<td WIDTH="10%" ALIGN="left">
								
								<select name=yoa>
								<option value="ALL">ALL</option>
								
									<%
										for(int i=0;i<yoas.size();i++)
										{
											String sub=yoas.get(i).toString();
											
											%>
											<option value='<%=sub %>'><%=sub %></option>
											<%
											
										}
									%>
									</select>
							
								
								</td>
							</tr>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Period </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="period">
								<option></option>
									<option value="ODD">ODD Semester</option>
									 <option value="EVEN">EVEN Semester</option>
									 <option value="YEAR">Year</option>
									 
								</select> 
        						</td>
        						</tr>
        						
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
