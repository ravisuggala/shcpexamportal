<%@ page import = "java.util.*,dao.*,java.text.SimpleDateFormat" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String totst;
String section=new String();

degree=miscUtil.noNull(request.getParameter("degree"));
branch=miscUtil.noNull(request.getParameter("branch"));
sem=miscUtil.noNull(request.getParameter("sem"));
reg=miscUtil.noNull(request.getParameter("reg"));
ay=miscUtil.noNull(request.getParameter("ay"));

String month=miscUtil.noNull(request.getParameter("month"));
month = miscUtil.getMonthInWords(month);

String cdate=miscUtil.noNull(request.getParameter("cdate"));
cdate=miscUtil.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");



session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("reg",reg);
session.putValue("ay",ay);

session.putValue("month",month);

session.putValue("cdate",cdate);


ArrayList subjectsList=new SubjectDB().getLabSubjectsList(degree, branch, sem, reg);

session.putValue("subjects", subjectsList);

String disp="List of Laborataries for "+FBSMiscUtilitiesBean.semDescription(sem,degree)+"- "+branch;

		
%>

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
		<title>Subjects Mapping</title>
<script language=javascript>

function toggle(source) {
	  checkboxes = document.getElementsByName('subject');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
function loadfaculty(selectObj,index) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	
	
	var urlString ="./facultylist.jsp?dept="+selectValue ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#fdv"+index).html(result);
	}
	});
}
function selectFaculty(index)
{
 var selvalue=document.getElementById('fdv'+index).value;
	var txt =  document.getElementById('flist'+index);
	   txt.value = txt.value+"+"+selvalue;
}
</script>		
	</head>
	<body>
		  <div id="centre">
			    <center><h1>External Lab Faculty List </h1></center>
			    <CENTER>
			    <%
			    if(subjectsList.size()==0)
			    {
			    	out.println("<br><br><h3>No Subjects for given course and semester</h3><br><br>");
			    }
			    else
			    {
			    	out.println("<h3>"+disp+"</h3>");
			    %>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./labexamfacultyreport.jsp" target="_blank">
							
							
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <Th nowrap>Dates</TH>
							    <Th nowrap>Subject Name (Code)</TH>
							    <Th nowrap>No.of Batches</TH>
							    <Th nowrap>Department</TH>
							    <Th >Internal Faculty</TH>
							    <Th >Name of the External Examiner & Address</TH>
							    
							    
							</TR>
							
									<%
										for(int i=0;i<subjectsList.size();i++)
										{
											Subject sub=(Subject)subjectsList.get(i);
											String subcode=sub.getCode();
									%>
									<tr>
									<td><input type="date" name="<%=subcode %>-date1"><br>
									<input type="date" name="<%=subcode %>-date2"><br>
									<input type="date" name="<%=subcode %>-date3"><br>
									<input type="date" name="<%=subcode %>-date4">
									<td nowrap><%=sub.getSname()+"("+sub.getCode()+")" %>
									<td>
									<select size=1 name="<%=subcode %>-batch">
										  <option value=""></option>
  										<option value="1" >1</option> 
  										<option value="2">2</option>
   										<option value="3">3</option> 
   										<option  value="4">4</option>
    									<option value="5">5</option> 
    									 
  									</select></td>
									<td nowrap>
									<select size=1 id=dept<%=i %> name="<%=subcode %>-dept" onChange="loadfaculty(this,'<%=i%>')">
										  <option value=""></option>
  										<option value="Pharmaceutics" >Pharmaceutics</option> 
  										<option value="Pharmacology">Pharmacology</option>
   										<option value="Pharmaceutical Chemistry">Pharmaceutical Chemistry</option> 
   										<option  value="Pharmaceutical Analysis">Pharmaceutical Analysis</option>
    									<option value="Pharmacy Practice">Pharmacy Practice</option> 
    									<option value="Others">Others</option> 
  									</select>
								</td>
								<td>
										<select id='fdv<%=i %>' name="<%=subcode %>-if"   onChange="selectFaculty('<%=i %>')"></select>
								</td>
								<td>
									<textarea rows=3 cols=20 name="<%=subcode %>-address"></textarea>
								</td>
								
								
									<% 		
										}
									%>
								</tr>
								<tr>
											
							<TR>
								<TD colspan=6 rowspan=2 align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>

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
	<% 		
	}
	%>
	</body>
</html>
