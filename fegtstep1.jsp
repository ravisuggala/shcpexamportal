
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
ArrayList regs=new StudentDB().getRegulations();
	
%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		

<script>
function toggle(selectObj) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	var degree=document.getElementById("degree").value;
	var branch=document.getElementById("branch").value;
	var sem=document.getElementById("sem").value;
	var reg=document.getElementById("reg").value;
	
	if(selectValue=='Common')
		{
		var urlString ="./commonsubjects.jsp?degree="+degree+"&branch="+branch+"&sem="+sem+"&reg="+reg ;
		$.ajax({
		type: "POST",
		url: urlString ,
		success: function(result) {
		console.info("result"+result);
		$("#subject").html(result);
		}
		});
		
		
		document.getElementById("elerow").style.display = 'none';
		document.getElementById("subname").style.display = '';
			 
		}
	else if(selectValue=='Elective')
		{
		document.getElementById("subname").style.display = 'none';
		
		var urlString ="./eletypes.jsp?degree="+degree+"&branch="+branch+"&sem="+sem+"&reg="+reg ;
		$.ajax({
		type: "POST",
		url: urlString ,
		success: function(result) {
		console.info("result"+result);
		$("#elecat").html(result);
		}
		});
		
		document.getElementById("elerow").style.display = '';
		
		}
	else
		{
		document.getElementById("elerow").style.display = 'none';
		document.getElementById("subname").style.display = 'none';
		}
		
	
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
</script>
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>Free Eletive Grand Test Marks Entry</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./fegtstep2.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "fegtstep2">
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Course Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option>
									<option value="B.PHARMACY">B.PHARMACY</option> 
        							<option value="M.PHARMACY">M.PHARMACY</option>  </select>
								</TD>
							
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
