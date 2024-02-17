
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
		
	
		
		ArrayList olrlist = (ArrayList)session.getAttribute("olrlist");
		ArrayList clslist = (ArrayList)session.getAttribute("clslist");
		ArrayList subjlist =(ArrayList)session.getAttribute("subjlist");
		
		String degree=session.getAttribute("degree").toString();
		String sem=	session.getAttribute("sem").toString();	
		String yoa=session.getAttribute("yoa").toString();
		String reg=new StudentDB().getRegulationForStudent(degree, yoa);
		
		
		
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

			   
			    <CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="90" style="font-size: 11px;">
				<tr>
			    <th colspan=4 style="text-align: center;">SHRI VISHNU COLLEGE OF PHARMACY:BHIMAVARAM<BR>(AUTONOMOUS) </th>
			    </tr>
				
				<tr>
			    <th colspan=4 style="text-align: center;">Result Analysis </th>
			    </tr>
			    <tr>

			    <th nowrap>Degree :<%=degree %>  </th>
			    <th  nowrap> Semester : <%=sem %> 
			    <th nowrap>Year of Admission : <%=yoa %> </th>
			    <th nowrap>Regulation : <%=reg %> </th>
			    </tr>
			    </table>
			    <br><br>
			    <table border=0>
			    <tr>
			    <td>
			    
			    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="90" style="font-size: 11px;">
			    	<tr>
			    	<th colspan=5 style="text-align: center;"> Aggregate Result Analysis </th>
			    	</tr>
			    	<tr>
				    	<th>Type</th>
				    	<th style="text-align: center;"> Passed Students Count</th>
				    	<th style="text-align: center;">Passed Students %</th>
				    	<th style="text-align: center;">Failed Students Count</th>
				    	<th style="text-align: center;">Failed Students % </th>
			    	</tr>
			    	<%
			    	for(int i=0;i<olrlist.size();i++){
			    		OverAllResult olr=(OverAllResult)olrlist.get(i);
			    	%>
			    	<tr>
			    	<td><%=olr.getDesc() %></td>
			    	<td><%=olr.getPc() %></td>
			    	<td><%=olr.getPp() %></td>
			    	<td><%=olr.getFc() %></td>
			    	<td><%=olr.getFp() %></td>
			    	</tr>
			    	<%} %>
			    	</TABLE>
			  </td>
			  <td>&nbsp;</td>
			  <td>
			  
			    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="90" style="font-size: 11px;">
			    	<tr>
			    	<th colspan=3 style="text-align: center;"> Division wise Analysis </th>
			    	</tr>
			    	<tr>
				    	<th>Type</th>
				    	<th style="text-align: center;"> Students Count</th>
				    	<th style="text-align: center;">SGPA Range</th>
				    	
			    	</tr>
			    	<%
			    	for(int i=0;i<clslist.size();i++){
			    		ClassAnalysis ca=(ClassAnalysis)clslist.get(i);
			    	%>
			    	<tr>
			    	<td nowrap><%=ca.getDesc() %></td>
			    	<td><%=ca.getCount() %></td>
			    	<td nowrap><%=ca.getRange() %></td>
			    	</tr>
			    	<%} %>
			    	</TABLE>
			    </td>
			    </tr>
			    </table>
				<br><br>
				<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="90" style="font-size: 11px;">
			    	<tr>
			    	<th colspan=6 style="text-align: center;"> Subject wise Analysis </th>
			    	</tr>
			    	<tr>
				    	<th>Subject</th>
				    	<th> Teacher</th>
				    	<th>Passed vs Attended</th>
				    	<th>Pass %</th>
				    	<th>Failure Count</th>
				    	<th>Failure/Absentees List </th>
			    	</tr>
			    	<%
			    	for(int i=0;i<subjlist.size();i++){
			    		SubjectAnalysis sa=(SubjectAnalysis)subjlist.get(i);
			    		String shortname=new SubjectDB().getSubjectShortName(sa.getSubject(), reg);
			    		if(shortname.contains("Lab"))continue;
			    	%>
			    	<tr>
			    	<td><%=shortname %></td>
			    	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			    	<td><%=sa.getPassedcnt() %></td>
			    	<td><%=sa.getPassedperc() %></td>
			    	<td><%=sa.getFailurecnt() %></td>
			    	<td><%=sa.getFailurelist() %></td>
			    	</tr>
			    	<%} %>
			    	</TABLE>
			    </td>
			    </tr>
				
				</TABLE>
				
				<br><br>
				<p style = "margin-left: 75px;">
					    
					    
			<table  align="center" width="100%" style="font-size: 11px;background-color:#FFFFFF;" noborder>
						<tr>
						
							<td colspan=6 width="30%" height="30%" style="background-color:#FFFFFF;">
							<!--  <img src="./excelfiles/photos/ce.jpg" height="50px" ><br>-->
							Controller of Examinations</td>
							
							<td width="30%" height="30%" style="background-color:#FFFFFF;"> 
							<!--  <img src="./excelfiles/photos/principal.jpg" height="50px" ><br>-->
							Principal</td>
							<td width="30%" height="30%" style="background-color:#FFFFFF;">
							<!--  <img src="./excelfiles/photos/director.jpg" height="50px" ><br>-->
							Director </td>
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
			    
			 </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	
	</body>
</html>
