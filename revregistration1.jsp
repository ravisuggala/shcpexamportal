
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

else if(ur.getStatus().equals("office"))
	header="./feemenuheader.jsp";


ArrayList yoas=new StudentDB().getYoas();
ArrayList regs=new StudentDB().getRegulations();
%>
<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		
		<script language=javascript>

function populateSecValues(obj){
	// use here ajax call .. which will populate second box data
	var firstBoxValue = obj.value;
	var course=document.getElementById("degree").value;
	var sem=document.getElementById("sem").value;
	var ay=document.getElementById("ay").value;
	var reg=document.getElementById("reg").value;;
	var yoa=document.getElementById("yoa").value;
	var urlString ="./revregistration2.jsp?course="+course+"&sem="+sem+"&ay="+ay+"&reg="+reg+"&yoa="+yoa ;
	
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
					
	
					    <center><h1>Revaluation Examination Registration</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./supplyregsimport.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep1">
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "xternalstep1">
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select id="degree" size="1" name="degree"><option></option>
									<option value="B.Pharmacy">B.Pharmacy</option> 
        							<option value="M.Pharmacy">M.Phrmacy</option>
        							  <option value="Pharm.D">Pharm.D</option>
        							</select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester: </TD>
								<TD  WIDTH="10%" align="left">
								<select id="sem" name="sem">
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
        						<tr>
							<TD  WIDTH="10%" ALIGN="right" nowrap>Year of Admission: </TD>
							<td WIDTH="10%" align="left">
							<select id=yoa name=yoa onchange="populateSecValues(this)">
								<option value=""></option>
								<%
										for(int i=0;i<yoas.size();i++)
										{
											String sub=yoas.get(i).toString();
											
											%>
											<option value='<%=sub %>' ><%=sub %></option>
											<%
											
										}
									%>
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
