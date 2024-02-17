
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />
<jsp:useBean id = "middb" scope="session" class="dao.MidExamDB" />
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
String type=new String();
String section=new String();
String conducted="";
String disp="";
ArrayList students=new ArrayList();

	degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 reg=miscUtil.noNull(request.getParameter("reg"));
	 ay=miscUtil.noNull(request.getParameter("ay"));
	// cat=miscUtil.noNull(request.getParameter("cat"));
	 //type=miscUtil.noNull(request.getParameter("type"));
	 section=miscUtil.noNull(request.getParameter("section"));
//System.out.println(degree+branch+sem+reg+ay+section);
    students=stdb.getStudentList(degree, branch, sem,section); 
	String subject= miscUtil.noNull(request.getParameter("subject"));
	String faculty=miscUtil.noNull(request.getParameter("faculty"));
	//conducted=miscUtil.noNull(request.getParameter("conducted"));
	//System.out.println(subject);
	
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	session.putValue("section",section);
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	session.putValue("faculty",faculty);
	//session.putValue("conducted",conducted);
	//session.putValue("cat",cat);
	
	//session.putValue("type",type);
	
	session.putValue("subject",subject);
	
	session.putValue("students", students);

	boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

	if(!validsec)
	{
		session.setAttribute("error", "No students for selected branch and section");
		response.sendRedirect("./errors.jsp");
	}
	else
	{
   
	String utype=ur.getStatus();
	boolean freez=false;
	if(!utype.equals("admin"))
		 freez=new MidExamDB().isMidFreeze(sem,degree,ay,type);
	
	if(freez)
	{
		 ServletContext sc = getServletContext();
		    RequestDispatcher rd = sc.getRequestDispatcher("/statusinfo.jsp");
		    request.setAttribute("status", "Mid Marks are freezed for the selected branch and section");
			rd.forward(request, response);
	}

	else
	{
	TestDates td=middb.findTestDates(degree, branch, sem, section, ay, subject);
	%>
	
<jsp:include page='<%= header %>' flush="true" />
	<head>
		<title>SVCP--Examination Portal - Mid Examinations</title>
		<script language="javascript" src="./JS/functions.js"></script>
		<script language="javascript" src="./JS/datetimepicker.js"></script>
	</head>

<body>
		  <div id="centre">
	
					    <center><h1>Lab Attendance Details</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./labStep3f.jsp">
							
							<INPUT TYPE=HIDDEN NAME="faculty" VALUE = '<%=ur.getUname()%>' id="faculty">
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
	<%
}
	}
%>