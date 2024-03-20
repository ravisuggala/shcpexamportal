
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

Hashtable results=(Hashtable)session.getValue("results");
branch=session.getValue("branch").toString();
String examname=session.getValue("examname").toString();
ExternalExam ee=new ExternalExamDB().getExamInfo(examname);
ArrayList brresults=(ArrayList)results.get(branch);

ArrayList regdsubjects=new ExternalExamDB().getRegdTotalSubjects(brresults);

SubjectDB sdb=new SubjectDB();
ArrayList subjtitles=sdb.getSubjectCodes(ee.getDegree(), branch, ee.getSem(), ee.getReg());
subjtitles=sdb.getAllExamSubjects(subjtitles,regdsubjects);


 title=miscUtil.getYearDescription(ee.getSem(),ee.getDegree());
if(ee.getType().equals("REGULAR"))
title=title+" Regular Examination Results -"+ee.getMonth();
else if(ee.getType().equals("REVALUATION"))
title=title+" Main Revaluation Results -"+ee.getMonth();
else if(ee.getType().equals("SUPPLEMENTARY"))
title=title+" Supplementary Examination Results -"+ee.getMonth();
else if(ee.getType().equals("SUPPLY REVALUATION"))
title=title+" Supply Revaluation Examination Results -"+ee.getMonth();
else if(ee.getType().equals("SPECIAL THEORY"))
title=title+" Special Theory Examination Results -"+ee.getMonth();





int colspan=subjtitles.size()+4;
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
			    if(brresults!=null&&brresults.size()>0)
			    {
                  
                  
                  
			    %>
			    <CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="90" style="font-size: 11px;">
				<tr>
			    <th colspan=<%=colspan %> style="text-align: center;">SEVEN HILLS COLLEGE OF PHARMACY:TIRUPATHI<BR>(AUTONOMOUS) </th>
			    </tr>
				
				<tr>
			    <th colspan=<%=colspan %> style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>

			    <th colspan=2>Branch :<%=branch %>  </th>

			    <th  colspan=<%=colspan-2 %> nowrap> Regulation : <%=ee.getReg() %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Academic Year : <%=ee.getAy() %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date: <%=ee.getResultdate() %></th>
			    </tr>
			    
			    			<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap> <font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							
							<%
							for(int i=0;i<subjtitles.size();i++)
							{
								String sub=subjtitles.get(i).toString();
								Subject subject=new SubjectDB().getSubject(sub, ee.getReg());
							
							%>
							
							<th style="text-align: center;" nowrap><font size=1><%=subject.getShortname() %></font></th>
							<%
							}
							%>
							<th> <font size=1>SGPA</font>
							<!-- <th><font size=1>CGPA</font> -->
							
							</tr>
							
							<% 
							
							
							for(int i=0;i<brresults.size();i++)
							{
								NBResults nbr=(NBResults)brresults.get(i);
								String regdno=nbr.getRegdno();
								String sgpa=nbr.getSgpa();
								String cgpa=nbr.getCgpa();
								Hashtable stresults=(Hashtable)nbr.getResults();
								
							%>
								<tr >
								<td align=right ><%=i+1 %>
								<td nowrap><%=new StudentDB().getStudentName(regdno) %>
								<td ><%=regdno %>
							<% 
								
								for(int j=0;j<subjtitles.size();j++)
								{
									String sub=subjtitles.get(j).toString();
									String marks=miscUtil.noNull((String)stresults.get(sub));
									String grade=miscUtil.parseMarks(marks, 4);
									String intr=miscUtil.parseMarks(marks, 1);
									String extr=miscUtil.parseMarks(marks, 2);
									String tot=miscUtil.parseMarks(marks, 3);
									String cr=miscUtil.parseMarks(marks, 6);
									String result="";
									if(grade.equals("F"))
										result="FAIL";
									else
										result="PASS";
									String sresult=intr+"-"+extr+"-"+tot+"-"+grade+"-"+cr+"-"+result;
									
							%>
							<td align=center><%=sresult %>
							<%
								}%>
								
							<td align=center><%=sgpa %>
							<!-- <td align=center><%=cgpa %> -->
							
							<% }%> 
							
												  
					</TABLE>
					   		
						  
					    
					    <TABLE CELLSPACING="30" style="font-size: 11px;">
					    <tr>
					    <td>
					   <TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" style="font-size: 11px;">
					   <tr>
					   <th style="text-align: center;" nowrap><font size=1>Subject <br>Short Name</font></th>
					   <th style="text-align: center;" nowrap><font size=1>Name of the Subject</font></th>
					   </tr>
					    <%
					    
						for(int i=0;i<subjtitles.size();i++)
						{
							String sub=subjtitles.get(i).toString();
							Subject subject=new SubjectDB().getSubject(sub, ee.getReg());
						
						%>
						<tr>
						<td style="text-align: center;" nowrap><%=subject.getShortname() %></td>
						<td  nowrap><%=subject.getSname() %></td>
						</tr>
						<%
						}
					    %>
					   </TABLE>
					    </td>
					    <td>
					    <TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" style="font-size: 11px;">
					   <tr>
					   <th style="text-align: center;" ><font size=1>Percentage of <br>Marks Obtained</font></th>
					   <th style="text-align: center;" nowrap><font size=1>Letter Grade</font></th>
					   </tr>
					   <tr>
					   <td>90-100</td>
					   <td>O 'Outstanding'</td>
					   </tr>
					   <tr>
					   <td>80 - 89.99</td>
					   <td>A 'Excellent'</td>
					   </tr>
					   <tr>
					   <td>70 - 79.99</td>
					   <td>B 'Good'</td>
					   </tr>
					   <tr>
					   <td>60 - 69.99</td>
					   <td>C 'Fair'</td>
					   </tr>
					   <tr>
					   <td>50 - 59.99</td>
					   <td>D 'Average'</td>
					   </tr>
					   <tr>
					   <td>Less than 50</td>
					   <td>F 'Fail'</td>
					   </tr>
					    <tr>
					   <td>Absent</td>
					   <td>AB 'Absent'</td>
					   </tr>
					   </TABLE>
					   </td>
					   </tr>
					   </TABLE>
					    </CENTER>
					    <p style = "margin-left: 75px;">
					    
					    
			<table  align="center" width="100%" style="font-size: 11px;background-color:#FFFFFF;" noborder>
						<tr>
						
							<td colspan=6 width="30%" height="30%" style="background-color:#FFFFFF;">
							<!--  <img src="./excelfiles/photos/ce.jpg" height="50px" ><br>-->
							Controller of Examinations</td>
							
							<td width="30%" height="30%" style="background-color:#FFFFFF;"> 
							<!--  <img src="./excelfiles/photos/principal.jpg" height="50px" ><br>-->
							Principal</td>
							<!--<td width="30%" height="30%" style="background-color:#FFFFFF;">
							  <img src="./excelfiles/photos/director.jpg" height="50px" ><br>
							Director </td> -->
						</tr>
						</table>
					 <table>
					    	</p>
						<center>
					    	<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
						  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
						<!--   <input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlconmidmarks") ></input>
						  <input id="btnSubmit" type="button" value="Export to PDF"  onClick=selectOption("pdfconmidmarks")></input>
						-->
						  </form>
						  </center>
			     <% 		   
			        }
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
