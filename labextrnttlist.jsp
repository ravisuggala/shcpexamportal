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
String batches=miscUtil.noNull(request.getParameter("batches"));
String days=miscUtil.noNull(request.getParameter("days"));
int ibatches=Integer.parseInt(batches);
int idays=Integer.parseInt(days);

/*String tfrom=miscUtil.noNull(request.getParameter("from"));
String tto=miscUtil.noNull(request.getParameter("to"));
String fromt=new SimpleDateFormat("hh:mm a").format(new SimpleDateFormat("HH:mm").parse(tfrom));
String tot=new SimpleDateFormat("hh:mm a").format(new SimpleDateFormat("HH:mm").parse(tto));
String time=fromt+" to "+tot;*/

String cdate=miscUtil.noNull(request.getParameter("cdate"));
cdate=miscUtil.formatDate(cdate, "yyyy-MM-dd", "dd-MM-yyyy");



session.putValue("degree",degree);
session.putValue("branch",branch);
session.putValue("sem",sem);
session.putValue("reg",reg);
session.putValue("ay",ay);
session.putValue("month",month);
session.putValue("cdate",cdate);
session.putValue("batches", batches);
session.putValue("days", days);


ArrayList subjectsList=new SubjectDB().getLabSubjectsList(degree, branch, sem, reg);

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
			    <center><h1>Lab External Time Table Preparation </h1></center>
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
			    <FORM NAME = REGISTER METHOD = POST ACTION = "./labextrnttreport.jsp" target="_blank">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "MapSubject2">
							
							
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
							<TR>
							    <Th nowrap>Date</TH>
							    
							    <%for(int i=1;i<=ibatches;i++){ %>
							    	<Th nowrap>Batch <%=miscUtil.int2Roman(i) %></TH>
							    	<%} %>
							  </TR>
							  <TR>
							    <Th nowrap>Time</TH>
							    
							    <%for(int i=1;i<=ibatches;i++){ %>
							    	<Td nowrap>   <input type=time name="fromtime<%=i %>"></input> TO <input type=time name="totime<%=i %>"></input> </Td>
							    	<%} %>
							  </TR>
							
							<%for(int i=1;i<=idays;i++){ %>
							  <tr>
							  <td><input type="date" name="day<%=i %>">
							    <%for(int j=1;j<=ibatches;j++){ %>
							       
							       
							       <td> 
							       <select name="day<%=i %>batch<%=j %>">
							       <option value="-" selected>-</option>
							       <%
							       for(int k=0;k<subjectsList.size();k++){
							    	   Subject sub=(Subject)subjectsList.get(k);
							    	   String subcode=sub.getCode();
							    	   String subname=sub.getSname();
							       
							       %>
							       <option value="<%=subcode %>"><%=subname %></option>
							       <%} %>
							       </select>
							       </td>
							       <%}%>
							       </tr>
							       <%} %>
							        
																				
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
