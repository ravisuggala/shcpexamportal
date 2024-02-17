
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
		

String examname=request.getParameter("examname").toString();
ExternalExam ee=new ExternalExamDB().getExamInfo(examname);

ArrayList meritlist=new MasterMarksDB().getMeritList(examname);




String  title=miscUtil.getYearDescription(ee.getSem(),ee.getDegree())+" External Examination- Merit List Report";


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
			    if(meritlist.size()>0)
			    {
                  
                  
                  
			    %>
			    <CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="90" style="font-size: 11px;">
				<tr>
			    <th colspan=<%=5 %> style="text-align: center;">SHRI VISHNU COLLEGE OF PHARMACY:BHIMAVARAM<BR>(AUTONOMOUS) </th>
			    </tr>
				
				<tr>
			    <th colspan=<%=5 %> style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>
     		    <th  colspan=<%=5 %> nowrap> Regulation : <%=ee.getReg() %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Academic Year : <%=ee.getAy() %> </th>
			    </tr>
			    
			    			<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap> <font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<th><font size=1>SGPA</font>
							<th><font size=1>CGPA</font>
						</tr>
							
							<% 
							
							
							for(int i=0;i<meritlist.size();i++)
							{
								ECRecord nbr=(ECRecord)meritlist.get(i);
								String regdno=nbr.getSht();
								String name=nbr.getSname();		
								String sgpa=nbr.getSsgpa();
								String cgpa=nbr.getCgpa();
							%>
								<tr >
								<td align=right ><%=i+1 %>
								<td nowrap><%=name%>
								<td ><%=regdno %>
								<td align=center><%=sgpa %>
							    <td align=center><%=cgpa %>
							
							<% }%> 
							
												  
					</TABLE>
					   		<br><br><br>
						  
					     <p style = "margin-left: 75px;">
					    <table  align="center" width="100%" style="font-size: 11px;">
						<tr>
						
							<td width="30%" height="30%">Controller of Examinations</td>
							<td></td><td></td><td></td><td></td><td></td>
							<td width="30%" height="30%"> Principal</td>
							<td width="30%" height="30%">Director </td>
						</tr>
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
