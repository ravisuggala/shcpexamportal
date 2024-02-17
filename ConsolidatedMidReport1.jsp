<%@ page import = "dao.User" %>
<%@ page autoFlush="true" buffer="1094kb"%>

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



<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb1" scope="session" class="dao.MapSubjectDB" />


<%
String branch=new String();
String sem=new String();
String ay=new String();
String degree=new String();
String midno=new String();
String section=new String();
String totst;
String reg=new String();
String br1=new String();
	//System.out.println("in else");
SubjectDB sdb=new SubjectDB();
 degree=miscUtil.noNull(request.getParameter("degree"));
 branch=miscUtil.noNull(request.getParameter("branch"));
 sem=miscUtil.noNull(request.getParameter("sem"));
 ay=miscUtil.noNull(request.getParameter("ay"));
 midno=miscUtil.noNull(request.getParameter("midno"));
 section=miscUtil.noNull(request.getParameter("section"));
 reg=miscUtil.noNull(request.getParameter("reg"));
 boolean validsec=new StudentDB().isValidSection(degree,branch,sem,section);

 if(!validsec)
 {
 	session.setAttribute("error", "No students for selected branch and section");
 	//response.sendRedirect("./errors.jsp");
 	%>
 	<jsp:forward page="./errors.jsp" /> 
 	<% 
 }
  else
 {
	  %>
	  <jsp:include page='<%= header %>' flush="true" />
	  <% 
ArrayList subjects=new ArrayList();
int cntsubj=0;
if(midno.equals("labfinal")||midno.equals("seminarfinal"))
  subjects=subdb1.getConsolidatedLabSubjects(degree,branch, sem,ay,section,midno);
else if(midno.equals("final"))

	  subjects=subdb1.getConsolidatedSubjectsForInternal(degree,branch, sem,ay,section,reg);
else if(midno.equals("assfinal"))

	  subjects=subdb1.getConsolidatedSubjectsForAssignment(degree,branch, sem,ay,section,reg);
else if(midno.equals("gtfinal"))
{
	  subjects=subdb1.getConsolidatedSubjectsForGrandTest(degree,branch, sem,ay,section,reg);
}

else
	subjects=subdb1.getConsolidatedSubjectsListForMid(degree,branch, sem,ay,section,midno,reg);
 

 //reg=new StudentDB().getRegulationForStudent(degree, sem, ay);

//String subjtitle=(new SubjectDB().getSubjectTitle(subject, reg))+" ("+subject+")";
MidExamDB medb=new MidExamDB();
LinkedHashMap marksdata=new LinkedHashMap();
String title=new StudentDB().getYearDescription(sem,degree);
if(midno.equals("labfinal")||midno.equals("seminarfinal"));
	//marksdata=medb.getFinalLabMarks(ay, branch, reg, sem,midno,section,subjects);
else if(midno.equals("assfinal"))
	marksdata=medb.getFinalAssignmentMarks(ay, branch, reg, sem, midno,section,subjects);
else if(midno.equals("gtfinal"))
{
	marksdata=medb.getGrandTestMarks(ay, branch, reg, sem,subjects);
	
	title=title+" Grand Test Marks";
	session.putValue("marksdata", marksdata);
	session.putValue("title", title);
	//response.sendRedirect("./displaygtmarks.jsp");
	%>
 	<jsp:forward page="./displaygtmarks.jsp" /> 
 	<%
}

else if(midno.equals("final"))
	marksdata=medb.getFinalInternalMarks(ay, branch, reg, sem, midno,section,subjects);

else
	marksdata=medb.getFinalMidMarks(ay, branch, reg, sem, midno,section,subjects);
//session.putValue("marksdata", marksdata);


if(midno.equals("labfinal"))
 title=title+" Lab Examinations";
else if(midno.equals("seminarfinal"))
	title=title+" Seminar Marks";
else if(midno.equals("final"))
	title=title+" Internal Marks";

else
	title=title+" "+midno+" - Mid Examinations";
//session.putValue("title", title);

ArrayList marksdataprint=new ArrayList();
br1=branch;
branch=branch+"-"+section;

session.putValue("subjects", subjects);
%>



	<body>
		  <div id="centre">
			    <%
			    if(marksdata.size()>0)
			    {
			    	 marksdataprint.add(0, title);
	                  marksdataprint.add(1,branch);
	                  marksdataprint.add(2,reg);
	                  marksdataprint.add(3,ay);
	                  
	                  marksdataprint.add(4,marksdata);
	                  session.setAttribute("marksdataprint", marksdataprint);
			    
			    
			    %>
		<CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="100">
				<tr>
			    <th colspan=8 style="text-align: center;" nowrap><%=title %> </th>
			    </tr>
			    <tr>
			    <th colspan=2 nowrap>Branch : <%=branch %>  </th>
			    <th colspan=2 nowrap align=center> Regulation : <%=reg %> </th>
			    <th colspan=4 nowrap> Academic Year : <%=ay %> </th>
			    </tr>
		    
			<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="100">
		
			<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap> <font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
						
		<%
		for(int i=0;i<subjects.size();i++)
		{
		  Subject subject=(Subject)subjects.get(i);
		  if(br1.equals("M.B.A")&&(sem.equals("II-I")||sem.equals("II-II"))&&subject.getCode().equals("")){
		%>	
		<th colspan=2><font size=1><%=subject.getShortname() %>
		<%
		  }else{%>
		<th nowrap><font size=1><%=subject.getShortname() %>
		
		</font></th>
		
		<%}}
		%>
		</tr>	
		<%
		Set<String> keys = marksdata.keySet(); 
		int index=1;
		for(String k:keys)
		{
			ArrayList marks=(ArrayList)marksdata.get(k);
		
		%>
		
		<tr>
		<td nowrap><%=index++ %></td>
		<td nowrap><%=new StudentDB().getStudentName(k) %></td>
		<td nowrap><%=k %>	
		
		<%
		for(int j=0;j<marks.size();j++)
		{
		%>
			<td nowrap><%= marks.get(j).toString() %></td>
			
			<%}}
				%>
		</tr>
		
		</TABLE>
		<br>
				<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
				  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
				 <input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlconmidmarks") ></input>
				  <input id="btnSubmit" type="button" value="Export to PDF"  onClick=selectOption("pdfconmidmarks")></input>
				  </form>
				  <br>
						  
	    <%}
			    else
			    	out.println("<center><h4><b>No Marks data for selected branch and subject</b></h4></center>");
			    	  %>	  
				
				
					   
					   
		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	
	<%} %>
	</body>
</html>
						