
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 

<%@ page import = "dao.User,java.util.*" %>
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />
<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
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
		<title>SVECW--Examination Portal - External Examinations</title>
<link rel="stylesheet" type="text/css" href="CSS/StyleCalender.css">

<script type="text/javascript" language="javascript" src="JS/CalendarControl.js"></script>
		<script language=javascript>

function populateSecValues(obj){
	// use here ajax call .. which will populate second box data
	var firstBoxValue = obj.value;
	var course=document.getElementById("degree").value;
	var sem=document.getElementById("sem").value;
	var ay=document.getElementById("ay").value;
	var reg=document.getElementById("reg").value;;
	var type=document.getElementById("type").value;;
	var period=document.getElementById("period").value;
	
	var urlString ="./examslist.jsp?course="+course+"&sem="+sem+"&ay="+ay+"&reg="+reg+"&type="+type+"&period="+period ;
	//alert(urlString);
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
					
	
					    <center><h1>External Examination Results Declaration Date</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "examresultsdate">
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option><option value="B.TECH">B.TECH</option> 
        							<option value="M.TECH">M.TECH</option> <option value="M.B.A">M.B.A</option> <option 
        							value="M.C.A">M.C.A</option>  </select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="sem" id="sem">
								<option></option>
									<option value="1">1</option> 
        							<option value="2">2</option>
        							 <option value="3">3</option>
        							  <option value="4">4</option> 
        							<option value="5">5</option>
        							<option value="6">6</option>
        							<option value="7">7</option>
        							<option value="8">8</option>
        							</select></TD></TR>
        							
        					<TR>
								<TD  WIDTH="20%" ALIGN="right">Type </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="type" id="type">
								<option></option>
									<option value="REGULAR">Regular</option>
									 <option value="SUPPLEMENTARY">Supplementary</option>
									 <option value="REVALUATION">Revaluation</option>
									 <option value="SUPPLY REVALUATION">Supply Revaluation</option>
									 <option value="SPECIAL THEORY">Special Theory</option>
									 
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
									</select>        						
									</td></tr>
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Academic Year:<br>(yyyy-yyyy)</br> </TD>
								<td WIDTH="10%" ALIGN="left"><input maxlength="10" name="ay" id="ay"></td>
							</tr>
							
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Period </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="period" id="period" onchange="populateSecValues(this)">
								<option></option>
									<option value="ODD">ODD Semester</option>
									 <option value="EVEN">EVEN Semester</option>
									<option value="YEAR">Year</option>
									 
								</select> 
        						</td>
        						</tr>
        						  <TR>
							<tr>
							<td nowrap align=right> Name of the Examination:
							
							<td colspan=2 align=left>
							<select id=exam name="examname">
							<option value="ALL">ALL</option>
							
							</select>
						</td>
						</tr>
        						<tr>
							<td nowrap>Results Declaration Date:</td>
							<td><input type="date" name="resultdate"></td>
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
