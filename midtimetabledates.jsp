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
String midno=miscUtil.noNull(request.getParameter("midno"));
String month=miscUtil.noNull(request.getParameter("month"));
String tfrom=miscUtil.noNull(request.getParameter("from"));
String tto=miscUtil.noNull(request.getParameter("to"));
String fromt=new SimpleDateFormat("hh:mm a").format(new SimpleDateFormat("HH:mm").parse(tfrom));
String tot=new SimpleDateFormat("hh:mm a").format(new SimpleDateFormat("HH:mm").parse(tto));
String time=fromt+" to "+tot;

String cdate=miscUtil.noNull(request.getParameter("cdate"));
cdate=miscUtil.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");
month = miscUtil.getMonthInWords(month);


session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("reg",reg);
session.putValue("ay",ay);
session.putValue("time",time);
session.putValue("month",month);
session.putValue("midno",midno);
session.putValue("cdate",cdate);

ArrayList subjectsList = new SubjectDB().getSubjectsListNoLabs(degree, branch, sem, reg);

session.putValue("subjects", subjectsList);

String disp="List of Subjects for "+FBSMiscUtilitiesBean.semDescription(sem,degree)+"- "+branch;
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

</script>		
	</head>
	<body>
		  <div id="centre">
			    <center><h1>Mid Timetable Preparation </h1></center>
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
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./midtimetablereport.jsp" target="_blank">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapSubject2">
							
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <Th nowrap>Subject code</TH>
							    <Th nowrap>Name of the Subject</TH>
							    <Th nowrap>Date</TH>
							    
							</TR>
							
									<%
										for(int i=0;i<subjectsList.size();i++)
										{
											Subject sub=(Subject)subjectsList.get(i);
											String selectName="date-"+sub.getCode();
									%>
									<tr>
									<td><%=sub.getCode() %>
									<td nowrap><%=sub.getSname() %>
									<td nowrap>
									<input type=date name='<%=selectName %>'></td>
									
									<% 		
										}
									%>
									
							<TR>
								<TD colspan=4 rowspan=2 align="center"><INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>

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
