
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

String degree=request.getParameter("degree");
String branch=request.getParameter("branch");
String sem=request.getParameter("sem");
String reg=request.getParameter("reg");

session.setAttribute("degree", degree);
session.setAttribute("branch", branch);
session.setAttribute("sem", sem);
session.setAttribute("reg", reg);

	
%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		

<script>
function toggle(selectObj) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	if(selectValue=='Free Elective')
		{
			   document.getElementById("hidethis").style.display = '';
			 
		}
	else
		document.getElementById("hidethis").style.display = 'none';
	
}
function populateSecValues(obj){
	// use here ajax call .. which will populate second box data
	var reg = obj.value;
	var degree=document.getElementById("degree").value;
	var branch=document.getElementById("branch").value;
	var urlString ="./openelectivesubjects.jsp?reg="+reg+"&degree="+degree+"&branch="+branch ;
	//alert(urlString);
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	//console.info("result"+result);
	$("#subject").html(result);
	}
	});
	}
</script>
		
	</head>
	<body>
		  <div id="centre">
	
					    <center><h1>Open Elective Selection</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./oeselection3.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "midstep1">
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Open Elective Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option>
									<option value="B.PHARMACY">B.PHARMACY</option> 
        							<option value="M.PHARMACY">M.PHARMACY</option>  </select>
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
								<TD  WIDTH="20%" ALIGN="right">Regulation </TD>
								<td WIDTH="10%" ALIGN="left">
								<select id="reg" name="reg" onchange="populateSecValues(this)">
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
							
							<tr>
							<td nowrap align=right> List of the Subjects:
							
							<td colspan=2>
							<select id=subject name="subject">
							</select>
						</td>
						</tr>				
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
