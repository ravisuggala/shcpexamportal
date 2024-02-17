
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "middb" scope="session" class="dao.MidExamDB" />
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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";

%>


<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String cat=new String();
String midno=new String();
String section=new String();
String totst;
String disp="";
ArrayList students=new ArrayList();
ArrayList subjectsList=new ArrayList();
String target=miscUtil.noNull(request.getParameter("hiddenActionType"));
String fe="";
String subject="";
String elecat="";
String fid="";
String testno="";
	degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 reg=miscUtil.noNull(request.getParameter("reg"));
	 ay=miscUtil.noNull(request.getParameter("ay"));
	// cat=miscUtil.noNull(request.getParameter("cat"));
	// midno=miscUtil.noNull(request.getParameter("midno"));
	 section=miscUtil.noNull(request.getParameter("section"));
	 subject= miscUtil.noNull(request.getParameter("subject"));
	// elecat=miscUtil.noNull(request.getParameter("elecat"));
	 fid=miscUtil.noNull(request.getParameter("faculty"));
	 testno=miscUtil.noNull(request.getParameter("testno"));
	 
	 

	 students=stdb.getStudentList(degree, branch, sem,section); 
	 
	 
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	session.putValue("section",section);
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	//session.putValue("cat",cat);
	//session.putValue("fe",fe);
	//session.putValue("midno",midno);
	session.putValue("students", students);
	//session.putValue("elecat",elecat);
	session.putValue("subject",subject);
	session.putValue("faculty",fid);
	session.putValue("testno",testno);


	boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

	if(!validsec)
	{
		session.setAttribute("error", "No students for selected branch and section");
		response.sendRedirect("./errors.jsp");
	}
   
	String utype=ur.getStatus();
	TestDates td=middb.findTestDates(degree, branch, sem, section, ay, subject);	
	//session.putValue("option", "internalstep2f");
		
		//response.sendRedirect("./ActionServlet");
	
%>
<jsp:include page='<%= header %>' flush="true" />
	<head>
		<title>SVCP--Examination Portal - Mid Examinations</title>
		<script language="javascript" src="./JS/functions.js"></script>
		<script language="javascript" src="./JS/datetimepicker.js"></script>
	</head>

<body>
		  <div id="centre">
	
					    <center><h1>Internal Assessment Details</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./testmarks3f.jsp">
							
							<INPUT TYPE=HIDDEN NAME="faculty" VALUE = '<%=ur.getUname()%>' id="faculty">
							
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Test Date: </TD>
								<td WIDTH="10%" ALIGN="left">
<input id='demo1' type="text" value='<%=td.getTest(testno) %>' size="10" name='date1'><a href="javascript:NewCal('demo1','ddMMMyyyy')"><img src="./imgs/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
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


