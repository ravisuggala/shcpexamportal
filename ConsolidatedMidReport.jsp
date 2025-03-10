
<head>
<script language="javascript" src="./JS/FormChek.js"></script>
<script type="text/javascript" src="./JS/jquery-1.4.2.min.js">  </script>
<script type="text/javascript" src="./JS/functions.js">  </script>

</head>
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%


/*SELECT * FROM examcell.mids where mapid in 
(select mapid from mapsubjects where 
		ay='2015-2016' and branch='MECH' and regulation='R14-R' and sem='I-I' and subcode='UGBS1T01');*/
		
ArrayList marksrows=new ArrayList();
String status="";
String title="";
String branch=new String();
String sem=new String();
String ay=new String();
String degree=new String();
String midno=new String();
String section=new String();
String totst;
String cat=new String();
String fe="";
String reg="";	

degree=miscUtil.noNull(request.getParameter("degree"));
branch=miscUtil.noNull(request.getParameter("branch"));
sem=miscUtil.noNull(request.getParameter("sem"));
ay=miscUtil.noNull(request.getParameter("ay"));
midno=miscUtil.noNull(request.getParameter("midno"));
section=miscUtil.noNull(request.getParameter("section"));
cat=miscUtil.noNull(request.getParameter("cat"));
reg=miscUtil.noNull(request.getParameter("reg"));

ArrayList subjects=new ArrayList();
MidExamDB medb=new MidExamDB();
LinkedHashMap marksdata=new LinkedHashMap();
if(midno.equals("mid1")||midno.equals("mid2")||midno.equals("remid")||midno.equals("totda")||midno.equals("mid3")){
	 subjects=new SubjectDB().getAllMappedSubjectsInOrder(degree,branch, sem, reg, section, ay);
	marksdata=medb.getAllMidMarks(degree,ay, branch, reg, sem,  midno,section);
}
	// marksdata=medb.getElectiveMidMarks(ay, branch, reg, sem,  midno,section);
else if(midno.equals("total")&&!degree.equals("Pharm.D")){
	 subjects=new SubjectDB().getAllMappedSubjectsInOrder(degree,branch, sem, reg, section, ay);
	marksdata=medb.getAllMidFinalMarks(degree,ay, branch, reg, sem,  midno,section);
}
else if(midno.equals("total")&&degree.equals("Pharm.D")){
	System.out.println("in jsp");
	 subjects=new SubjectDB().getAllMappedSubjectsInOrder(degree,branch, sem, reg, section, ay);
	marksdata=medb.getFinalInternalMarks(ay, branch, reg,  sem, midno,section,subjects);
}
	
//else if(midno.equals("labfinal"))
//{
	// subjects=new SubjectDB().getAllMappedLabSubjectsInOrder(degree,branch, sem, reg, section, ay);
	//marksdata=medb.getFinalLabMarks( degree,ay,branch,  reg, sem,section);
//}
session.putValue("subjects", subjects);	 
session.putValue("marksdata", marksdata);
 
if(midno.equals("mid1")||midno.equals("mid2")||midno.equals("remid")||midno.equals("totda"))
 title=miscUtil.getYearDescription(sem,degree)+miscUtil.getMidinFull(midno)+" Examination";
 else if(midno.equals("total"))
	title=miscUtil.getYearDescription(sem,degree)+" Mid Examinations";
 else if(midno.equals("labfinal"))
	 title=miscUtil.getYearDescription(sem,degree)+" Lab Examinations";
session.putValue("title", title);

ArrayList marksdataprint=new ArrayList();
branch=branch+"-"+section;
int colspan=subjects.size()+3;
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
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="1" WIDTH="100">
				<tr>
			    <th colspan=<%=colspan %> style="text-align: center;">SEVEN HILLS COLLEGE OF PHARMACY:TIRUPATHI<BR>(AUTONOMOUS) </th>
			    </tr>
				
				<tr>
			    <th colspan=<%=colspan %> style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>
			    <th  colspan=2 nowrap>Branch : <%=branch %>  </th>
			    <!--  <th nowrap><%=branch %>  </th>-->
			    <th  align=center nowrap> Regulation : <%=reg %> </th>
			    <th  colspan=<%=colspan-3 %> nowrap> Academic Year : <%=ay %> </th>
			    </tr>
			    
			    			<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap> <font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							
							<%
							for(int i=0;i<subjects.size();i++)
							{
								Subject sub=(Subject)subjects.get(i);	
							
							%>
							
							<th style="text-align: center;" nowrap><font size=1><%=sub.getShortname() %></font></th>
							<%
							}
							%>
							</tr>
							
							<% 
							int i=1;
							Set<String> regdnos=marksdata.keySet();
							for(String key:regdnos)
							{
							%>
								<tr>
								<td align=right><%=i++ %>
								<td nowrap><%=new StudentDB().getStudentName(key) %>
								<td align=center><%=key %>
							<% 
								LinkedHashMap marks=(LinkedHashMap)marksdata.get(key);
								//Set<String> mkeys=marks.keySet();
								
								for(int k=0;k<subjects.size();k++)
								{
									Subject sub=(Subject)subjects.get(k);
									String mark=miscUtil.noNull(marks.get(sub.getCode()));
									if(mark.equals("-1"))mark="";
									
							
												
							%>
							<td align=center><%=mark %>
													
							
							<%
								}
							} 
							%>
							</td>
							</tr>
							</table>
							<br>
							<p style = "margin-left: 35px;">
			
<table  border=0 align="center" width="100%">
<tr><td><td><td><td><td><td><Td>
<td width="45%" height="30%">Controller of Examinations</td>
<td width="45%" height="30%"> Principal</td>


</table>
</p>
							
							
								<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
						  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
						 <!--<input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlconmidmarks") ></input>
						  <input id="btnSubmit" type="button" value="Export to PDF"  onClick=selectOption("pdfconmidmarks")></input>
							!-->
						  </form>
						  
						  
						   </CENTER>
						   		
					    <%}
			    else
			    	out.println("<center><h4><b>No Marks data for selected branch and subject</b></h4></center>");
			    	  %>	  
					   
								   
					   
		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	
	</body>
</html>
