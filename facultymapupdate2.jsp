<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

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
section=miscUtil.noNull(request.getParameter("section"));
reg=miscUtil.noNull(request.getParameter("reg"));
ay=miscUtil.noNull(request.getParameter("ay"));

 boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

 if(!validsec)
 {
 	session.setAttribute("error", "No students for selected branch and section");
 	response.sendRedirect("./errors.jsp");
 }

 
session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("reg",reg);
session.putValue("ay",ay);
session.putValue("section", section);

ArrayList subjectsList = new FacultyDB().getMappedFacultyList( degree,branch, sem,  reg, ay, section);
session.putValue("subjects", subjectsList);

String disp="List of Subjects for "+FBSMiscUtilitiesBean.semDescription(sem,degree)+"- "+branch+"-"+section+" Section";
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

</script>		
	</head>
	<body>
		  <div id="centre">
			    <center><h1>Subjects with Faculty Mapping </h1></center>
			    <CENTER>
			    <%
			    if(subjectsList.size()==0)
			    {
			    	out.println("<br><br><h3>Subjects are not yet mapped with the students</h3><br><br>");
			    }
			    else
			    {
			    	out.println("<h3>"+disp+"</h3>");
			    %>
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./FinalFacultyMapUpdate.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapSubject2">
							
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <th>Select</th>
							    <Th nowrap>Subject code</TH>
							    <Th nowrap>Name of the Subject</TH>
							    <Th nowrap>Department of Faculty</TH>
							    <Th nowrap>Name of the Faculty</TH>
							</TR>
							
									<%
										for(int i=0;i<subjectsList.size();i++)
										{
											FacultyMap sub=(FacultyMap)subjectsList.get(i);
											String selectName=sub.getSubcode()+"f";
											String dept=sub.getDept();
									%>
									<tr>
									<td><input type=checkbox name=fmapid value=<%=sub.getFmapid() %>>
									<td><%=sub.getSubcode() %>
									<td nowrap><%=sub.getSubname() %>
									<td nowrap><select size=1 id=dept<%=i %> name=dept<%=i %> onChange="loadfaculty(this,'<%=i%>')">
										  <option value=""></option>
  										<option value="Pharmaceutics" <%=dept.equals("Pharmaceutics")?"SELECTED":"" %>>Pharmaceutics</option> 
  										<option value="Pharmacology" <%=dept.equals("Pharmacology")?"SELECTED":"" %>>Pharmacology</option>
   										<option value="Pharmaceutical Chemistry" <%=dept.equals("Pharmaceutical Chemistry")?"SELECTED":"" %>>Pharmaceutical Chemistry</option> 
   										<option  value="Pharmaceutical Analysis" <%=dept.equals("Pharmaceutical Analysis")?"SELECTED":"" %>>Pharmaceutical Analysis</option>
    									<option value="Pharmacy Practice" <%=dept.equals("Pharmacy Practice")?"SELECTED":"" %>>Pharmacy Practice</option> 
    									<option value="Others"  <%=dept.equals("Others")?"SELECTED":"" %>>Others</option> 
  									</select>
									<td nowrap>
									<div>
									<select id='fdv<%=i %>' name='<%=selectName %>'>
									<option value=<%=sub.getFid() %> selected><%=sub.getFacultyname() %>
									</select>
									</div>
									<% 		
										}
									%>
									
								
													
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
