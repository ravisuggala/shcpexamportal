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

String exam=miscUtil.noNull(request.getParameter("examname"));
String type=miscUtil.noNull(request.getParameter("type"));
ExternalExam ee=new ExternalExamDB().getExamInfo(exam);
String time=new ExternalExamDB().getExamTime(exam);
 degree=ee.getDegree();
 sem=ee.getSem();
 ay=ee.getAy();
reg=ee.getReg();
String month=ee.getMonth();
String cdate=miscUtil.noNull(request.getParameter("cdate"));
cdate=miscUtil.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");


ArrayList sublist=new ExternalExamDB().getExamTimeTable(exam);

session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("reg",reg);
session.putValue("ay",ay);
session.putValue("time", time);
session.putValue("month",month);

session.putValue("cdate",cdate);




session.putValue("subjects", sublist);

String disp="List of Dates for "+FBSMiscUtilitiesBean.semDescription(sem,degree);

		
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
			    <center><h1>External Invigilation Preparation </h1></center>
			    <CENTER>
			    <%
			    if(sublist.size()==0)
			    {
			    	out.println("<br><br><h3>No Subjects for given course and semester</h3><br><br>");
			    }
			    else
			    {
			    	out.println("<h3>"+disp+"</h3>");
			    %>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./externalinvigreport.jsp" target="_blank">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapSubject2">
							
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <Th nowrap>Date</TH>
							    <Th nowrap>Subject Name (Code)</TH>
							    <Th nowrap>Department</TH>
							    <Th nowrap>Faculty Names</TH>
							    <Th nowrap>Selected Faculty List</TH>
							    
							    
							</TR>
							
									<%
										for(int i=0;i<sublist.size();i++)
										{
											TestDates sub=(TestDates)sublist.get(i);
											String selectName="f-"+sub.getSubcode();
									%>
									<tr>
									<td nowrap><%=sub.getExternal() %>
									<td nowrap><%=new SubjectDB().getSubjectTitle(sub.getSubcode(), reg)+"("+sub.getSubcode()+")" %>
									<td nowrap>
									<select size=1 id=dept<%=i %> name=dept<%=i %> onChange="loadfaculty(this,'<%=i%>')">
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
										<select id='fdv<%=i %>' onChange="selectFaculty('<%=i %>')"></select>
								</td>
								<td>
									<input type=text id='flist<%=i %>' name='<%=selectName %>'></td>
								</td>
									<% 		
										}
									%>
								</tr>
								<tr>
											
							<TR>
								<TD colspan=5 rowspan=2 align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>

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
