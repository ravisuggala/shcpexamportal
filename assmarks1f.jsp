
<!DOCTYPE html>
<%@page import="dao.FBSMiscUtilitiesBean"%>
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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";


ArrayList regs=new StudentDB().getRegulations();
	
%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		<title>SVCP--Examination Portal - Mid Examinations</title>

<script>
function toggle(selectObj) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	var degree=document.getElementById("degree").value;
	var branch=document.getElementById("branch").value;
	var sem=document.getElementById("sem").value;
	var ay=document.getElementById("ay").value;
	var reg=document.getElementById("reg").value;
	var faculty=document.getElementById("faculty").value;
	var section=document.getElementById("section").value;

	
	var urlString ="./facultysubjects.jsp?degree="+degree+"&branch="+branch+"&sem="+sem+"&section="+section+"&ay="+ay+"&faculty="+faculty+"&reg="+reg ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#subject").html(result);
	}
	});
	
	
	document.getElementById("elerow").style.display = 'none';
	document.getElementById("hidethis").style.display = 'none';
	document.getElementById("subname").style.display = '';
		 
	
	
	}
function subjectselect(elecat)
{
	var ele=elecat.value;
	var urlString ="./electivesubjects.jsp?selele="+ele ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#subject").html(result);
	}
	});
	
	document.getElementById("subname").style.display = '';
}
function fesubjectselect(elecat)
{
	var degree=document.getElementById("degree").value;
	var branch=document.getElementById("branch").value;
	
	var reg=document.getElementById("reg").value;
	
	var ele=elecat.value;
	var urlString ="./fesubjects.jsp?selele="+ele+"&degree="+degree+"&branch="+branch+"&reg="+reg ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#subject").html(result);
	}
	});
	
	document.getElementById("subname").style.display = '';
}
</script>
		
	</head>
	<body>
		  <div id="centre">
	
					    <center><h1>Assignment Marks</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./assmarks2f.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "midstep1">
							<INPUT TYPE=HIDDEN NAME="faculty" VALUE = '<%=ur.getUname()%>' id="faculty">
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Branch Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option> 
									<option value="B.PHARMACY">B.PHARMACY</option> 
        							<option value="M.PHARMACY">M.PHARMACY</option> 
        							 </select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Branch: </TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="branch" id="branch"><option></option>
									<option value="B.Pharmacy">B.Pharmacy</option> 
									<option value="Pharmaceutics">Pharmaceutics</option> 
        							<option value="P.R.A">Pharmaceutical Regulatory Affairs</option> 
        							<option value="P.C">Pharmaceutical Chemistry</option> 
        							<option value="P.A">Pharmaceutical Analysis</option> 
        							<option value="Pharmacology">Pharmacology</option> 
        							 </select>
								</TD>
							</TR>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester: </TD>
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
        							<option value="8" >8</option>
        							</select></TD></TR>
        							
        							<TR>
								<TD  WIDTH="20%" ALIGN="right">Section </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="section" id="section">
								<option></option>
									<option value="A">A</option>
									 <option value="B">B</option>
									 <option value="C">C</option>
									 <option value="D">D</option>
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
								<select id="reg" name="reg" onChange="toggle(this);">
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
							
							
							
							
							<TR id="subname">
								<TD  WIDTH="20%" ALIGN="right" nowrap>Name of the Subject </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="subject" id="subject">
									
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
