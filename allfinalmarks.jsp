
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
	

String ay=session.getValue("ay").toString();
String branch=session.getValue("branch").toString();
String reg=session.getValue("reg").toString();
String sem=session.getValue("sem").toString();
String section=session.getValue("section").toString();
String midno=session.getValue("midno").toString();
String degree=session.getValue("degree").toString();

ArrayList subjects=new ArrayList();
MidExamDB medb=new MidExamDB();
LinkedHashMap marksdata=new LinkedHashMap();
if(!midno.equals("direct")){
	 subjects=new SubjectDB().getAllMappedSubjectsInOrderNoLabs(degree,branch, sem, reg, section, ay);
	marksdata=medb.getAllMidMarks(degree,ay, branch, reg, sem,  midno,section);
}
	// marksdata=medb.getElectiveMidMarks(ay, branch, reg, sem,  midno,section);
else
{
	 subjects=new SubjectDB().getAllMappedSubjectsInOrder(degree,branch, sem, reg, section, ay);
	marksdata=medb.getAllFinalMarks(degree,ay, branch, reg, sem,  midno,section);
}
	 
session.putValue("marksdata", marksdata);
 
if(!midno.equals("direct"))
 title=new StudentDB().getYearDescription(sem,degree)+" Mid-"+miscUtil.getMidinFull(midno)+" Examination";
else
	title=new StudentDB().getYearDescription(sem,degree)+" Mid Examinations";
session.putValue("title", title);

ArrayList marksdataprint=new ArrayList();
branch=branch+"-"+section;
int colspan=subjects.size()+3;
%>

<%@ page import = "dao.User" %>


<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
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
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="100">
				<tr>
			    <th colspan=<%=colspan %> style="text-align: center;"><%=title %> </th>
			    </tr>
			    <tr>
			    <th colspan=2 >Branch : <%=branch %>  </th>
			    <th colspan=3 align=center nowrap> Regulation : <%=reg %> </th>
			    <th colspan=<%=colspan-5 %> nowrap> Academic Year : <%=ay %> </th>
			    </tr>
			    
			    <TR>
				   <TD COLSPAN=<%=colspan %> ALIGN="center"><h6><b> Student List</b></h6></TD>
				</TR>
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
								Set<String> mkeys=marks.keySet();
								
								for(String mkey : mkeys)
								{
									String mark=(String)marks.get(mkey);
									
							
												
							%>
							<td align=center><%=mark %>
													
							
							<%
								}
							} 
							%>
							<tr>
							<TD colspan=<%=colspan %> align="center">
							
							
								<form name=xlform METHOD = POST ACTION = "./ActionServlet" >
						  <input type="button" value="Print" onclick="printtable()"></input> &nbsp;&nbsp;
						 <input id="btnSubmit" type="button" value="Export to Excel" onClick=selectOption("xlelmidmarks") ></input>
						  <input id="btnSubmit" type="button" value="Export to PDF"  onClick=selectOption("pdfelmidmarks")></input>

						  </form>
						  
						  
						  </TD>
						  
						  	
						  	
			    			
			    			
							</tr>
													
						</TABLE>
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
