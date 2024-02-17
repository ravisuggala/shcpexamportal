
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

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
<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String examtype=new String();
String totst;
String disp="";
String fe="";
String subject="";
String examdate="";
String cdate="";
	String valtype="";
	degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 reg=miscUtil.noNull(request.getParameter("reg"));
	 ay=miscUtil.noNull(request.getParameter("ay"));
	 examtype=miscUtil.noNull(request.getParameter("examtype"));
	 subject= miscUtil.noNull(request.getParameter("subject"));
	 valtype=miscUtil.noNull(request.getParameter("valtype"));
	 cdate=miscUtil.noNull(request.getParameter("cdate"));
	 examdate=miscUtil.noNull(request.getParameter("examdate"));

	 cdate=miscUtil.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");
	 examdate=miscUtil.formatDate(examdate, "yyyy-MM-dd", "dd-MM-yyyy");
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	session.putValue("examtype",examtype);
	session.putValue("subject",subject);
	session.putValue("valtype",valtype);
	session.putValue("cdate", cdate);
	session.putValue("examdate", examdate);

%>


<html>
	<head>
		<title>SVCP--Examination Portal - Mid Examinations</title>

<script>
function facultytypeselect(selectObj) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	
	if(selectValue=='Internal Faculty')
	{
		
	document.getElementById("external").style.display = 'none';
	
	document.getElementById("internal").style.display = '';
		 
	}
	else if(selectValue=='External Faculty')
	{
		document.getElementById("external").style.display = '';
		
		document.getElementById("internal").style.display = 'none';
	}
	
	}
function loadfaculty(selectObj) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	
	
	var urlString ="./facultylist.jsp?dept="+selectValue ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#fdv").html(result);
	}
	});
}

</script>
		
	</head>
	<body>
		  <div id="centre">
	
					    <center><h1>Remuneration Bill Generation</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./rembill3.jsp">
							
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Faculty Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">For Whom:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="ftype" onChange="facultytypeselect(this);">
									<option></option> <option value="internal">Internal Faculty</option> 
        							<option value="external">External Faculty</option> 
        							 </select>
								</TD>
							</TR>
							</table>
							
							<div id=internal style="display:none">
							<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Department:</TD>
								<TD  WIDTH="10%" align="left">
									<select size=1 id=dept name=dept onChange="loadfaculty(this)">
										  <option value=""></option>
  										<option value="Pharmaceutics" >Pharmaceutics</option> 
  										<option value="Pharmacology">Pharmacology</option>
   										<option value="Pharmaceutical Chemistry">Pharmaceutical Chemistry</option> 
   										<option  value="Pharmaceutical Analysis">Pharmaceutical Analysis</option>
    									<option value="Pharmacy Practice">Pharmacy Practice</option> 
    									<option value="Others">Others</option> 
  									</select> 
        						</TD>
								</TR>
								<tr>	
								<TD  WIDTH="20%" ALIGN="right" nowrap>Name of the Faculty:</TD>
								<TD  WIDTH="10%" align="left">
									<select id='fdv' name=fname></select>
								</TD>	
								</TR>
							<tr>	
								<TD  WIDTH="20%" ALIGN="right">Designation:</TD>
								<TD  WIDTH="10%" align="left">
									<select id='desig' name=desig>
										<option value=""></option>
										<option value="Professor">Professor</option>
										<option value="Assoc.Professor">Assoc.Professor</option>
										<option value="Asst.Professor">Asst.Professor</option>
										<option value="Lecturer">Lecturer</option>
									</select>
								</TD>	
								</TR>
								<input type=hidden name="address" value="SVCP,Bhimavaram"></input>
							</table>
							</div>
							
							<div id=external style="display:none">
							<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<tr>	
								<TD  WIDTH="20%" ALIGN="right" nowrap>Name of the Faculty:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="efname"></input></TD>						
							</tr>
							<tr>	
								<TD  WIDTH="20%" ALIGN="right">Designation:</TD>
								<TD  WIDTH="10%" align="left">
									<select id='desig' name=edesig>
									<option value=""></option>
										<option value="Professor">Professor</option>
										<option value="Assoc.Professor">Assoc.Professor</option>
										<option value="Asst.Professor">Asst.Professor</option>
										<option value="Lecturer">Lecturer</option>
									</select>
								</TD>	
							</TR>
							<tr>
							<TD  WIDTH="20%" ALIGN="right">Address:</TD>
								<TD  WIDTH="10%" align="left">
								
							<textarea rows=3 cols=20 name="eaddress"></textarea>
							</TD></tr>
							<tr>	
								<TD  WIDTH="20%" ALIGN="right" nowrap>TA/DA Amount:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="tada"></input></TD>						
							</tr>
							
							
							</table>
							</div>
							<br>
						<center>							
							    <INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT>
						</center>
							</FORM>
					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	</body>
</html>
