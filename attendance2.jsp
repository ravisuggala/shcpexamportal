
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
	
	
	


	boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

	if(!validsec)
	{
		session.setAttribute("error", "No students for selected branch and section");
		response.sendRedirect("./errors.jsp");
	}
   
	String utype=ur.getStatus();
	TestDates td=middb.findTestDates(degree, branch, sem, section, ay, subject);	
	//session.putValue("option", "attendancef");
		
		//response.sendRedirect("./ActionServlet");
	
%>

<jsp:include page='<%= header %>' flush="true" />
	<head>
		<title>SHCP--Examination Portal - Mid Examinations</title>
		<script language="javascript" src="./JS/functions.js"></script>
		<script language="javascript" src="./JS/datetimepicker.js"></script>
	</head>

<body>
		  <div id="centre">
	
					    <center><h1>Attendance Details</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./attendance3.jsp">
							
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Conducted classes: </TD>
								<td WIDTH="10%" ALIGN="left"><input maxlength="10" name="conducted" value=<%=td.getConducted() %>></td></tr>
							
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


