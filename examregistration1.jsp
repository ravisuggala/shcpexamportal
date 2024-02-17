
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 

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

ArrayList regs=new StudentDB().getRegulations();

%>
<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		<script>
		function populateSecValues(obj){
			// use here ajax call .. which will populate second box data
			var firstBoxValue = obj.value;
			var course=document.getElementById("degree").value;
			var sem=document.getElementById("sem").value;
			var type=document.getElementById("type").value;
			var ay=document.getElementById("ay").value;
			var reg=document.getElementById("reg").value;
			var period=document.getElementById("period").value;
			
			
			var urlString ="./examnames.jsp?course="+course+"&sem="+sem+"&ay="+ay+"&reg="+reg+"&type="+type+"&period="+period ;
			
			$.ajax({
			type: "POST",
			url: urlString ,
			success: function(result) {
			
				$("#exam").html(result);
			}
			});
			}

		
		
		</script>
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>External Examination Registration</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./registrationprogress.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep1">
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "examregistration">
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
								<select name="sem" id="sem">
								<option></option>
									<option value="1" >1</option> 
        							<option value="2" >2</option> 
        							<option value="3" >3</option> 
        							<option value="4" >4</option> 
        							<option value="5" >5</option>
        							<option value="6" >6</option>
        							<option value="7" >7</option>
        							<option value="8" >8</option>	</select></TD></TR>
        							
        					
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Type </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="type" id="type">
								<option></option>
									<option value="regular">Regular</option>
									 <option value="supply">Supplementary</option>
									 <option value="revaluation">Revaluation</option>
									 <option value="SUPPLY REVALUATION">Supply Revaluation</option>
									 <option value="SPECIAL THEORY">Special Theory</option>
								</select> 
        						</td>
        						</tr>
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
								<TD  WIDTH="20%" ALIGN="right">Regulation </TD>
								<td WIDTH="10%" ALIGN="left">
								<select id="reg" name="reg">
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
								<TD  WIDTH="20%" ALIGN="right">Period </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="period" id="period" onchange="populateSecValues(this)">
								<option></option>
									<option value="ODD">ODD Semester</option>
									 <option value="EVEN">EVEN Semester</option>
									 <option value="YEAR">Year </option>
									 
								</select> 
        						</td>
        						</tr>
        						<tr>
							<td nowrap align=right> Name of the Examination:
							
							<td colspan=2>
							<select id=exam name="examname">
							
							
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
