<head>
<style type="text/css">
<!--

.pos_fixed {
    position: fixed;
    top: 350px;
    right: 80px;
    border-collapse: collapse;
	border: 2px solid GREY;
    
}
.menu {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #000000;
}

.border {
	border: #867F45;
	border-style: solid;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	padding: 2px;
}

.tableborder {
	border-collapse: collapse;
	border: 2px solid GREY;
}

}
.cnttxt {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #000000;
	text-align: center;
	text-decoration: none;
}

.lblb {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #00000;
	text-align: center;
	text-decoration: none;
}

.btnb {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #00000;
	text-decoration: none;
	text-align: center;
}

.selb {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: normal;
	color: #00000;
	text-decoration: none;
}

.headertxt {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #003333;
	text-align: justify;
}
-->
</style>

</head>
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

<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb1" scope="session" class="dao.MapSubjectDB" />

<%
Student st=(Student)session.getAttribute("profile");
TreeMap results=(TreeMap)session.getAttribute("marks");
%>


	<body>
		  <div id="centre">
		  <center><h3>Aggregate Grades Report</h3></center>
		  
		  <center>
		  <TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="100">
		  <tr align=center>
		  <th colspan=2 ><p align=center style="{margin:0;}">STUDENT PROFILE</th>
		  </tr>
		  <tr>
		  	
		  	<td nowrap>Regd. Number:&nbsp;&nbsp;&nbsp;<%=st.getRegdno() %>
		  	<td nowrap>Name:&nbsp;&nbsp;&nbsp;<%=st.getName() %>
		  </tr>
		  <tr>
		  	<td nowrap>Course:&nbsp;&nbsp;&nbsp;<%=st.getDegree() %>
		  	<td nowrap>Branch:&nbsp;&nbsp;&nbsp;<%=st.getBranch() %>	
		  </tr>
		  <tr>
		  	<td nowrap>Section:&nbsp;&nbsp;&nbsp;<%=st.getSection() %>
		  	<td nowrap>Regulation:&nbsp;&nbsp;&nbsp;<%=st.getRegulation() %>
		  </tr>
		  <tr>
		  	<td nowrap>Current Semester:&nbsp;&nbsp;&nbsp;<%=st.getSem() %>
		  	<td nowrap>Admitted Batch:&nbsp;&nbsp;&nbsp;<%=st.getYoa() %>
		  </tr>
		  </TABLE>
		  <br>
		  <TABLE BORDER="0" CELLPADDING="2" CELLSPACING="2" WIDTH="100">
		  <tr align=center>
		  <th colspan=2 ><p align=center>AGGREGATE GRADE REPORT</th>
		  </tr>
		  
		  <%
		  ArrayList sems=new ArrayList(results.keySet());
		  Collections.sort(sems);
		  for(int i=0;i<sems.size();i++)
		  {
			  String scode=sems.get(i).toString();
			  String sem=scode;
			  ExternalMarks em=(ExternalMarks)results.get(scode);
			  String sgpa=em.getSgpa();
			  String cgpa=em.getCgpa();
			  if(i%2==0)out.println("<tr>");  
		%>
		  <td>
			<TABLE class=tableborder BORDER="1"  width=50% class=tableborder valign= middle  cellspacing= 0  cellpadding= 0  align= center    bgcolor= #e4f6f8  bordercolor= #ffffff   >
		  <tr class=tableborder align=center>
		  <th class=tableborder colspan=6 ><p align=center><%=miscUtil.getSemDescription(sem) %></th>
		  </tr>
		  
		    <tr class=tableborder>
		   
		    <th class=tableborder width=10 height=20 style="font-size:xx-small;">Subject Name</th>
		    <th class=tableborder width=10 height=20 style="font-size:xx-small;">Internal</th>
		    <th class=tableborder width=10 height=20 style="font-size:xx-small;"> External</th>
		    <th class=tableborder width=10 height=20 style="font-size:xx-small;"> Total</th>
		    <th class=tableborder width=10 height=20 style="font-size:xx-small;">Grade</th>
		    </tr>
		    <% 
		    if(!em.getSub1().equals(""))
		    {
		    	String subdetails=em.getSub1();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder   nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder  height=10 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=10 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder  height=10 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder   height=10 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%>
		    <% 
		    if(!em.getSub2().equals(""))
		    {
		    	String subdetails=em.getSub2();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    <td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub3().equals(""))
		    {
		    	String subdetails=em.getSub3();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    <td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub4().equals(""))
		    {
		    	String subdetails=em.getSub4();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub5().equals(""))
		    {
		    	String subdetails=em.getSub5();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub6().equals(""))
		    {
		    	String subdetails=em.getSub6();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    <td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub7().equals(""))
		    {
		    	String subdetails=em.getSub7();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub8().equals(""))
		    {
		    	String subdetails=em.getSub8();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub9().equals(""))
		    {
		    	String subdetails=em.getSub9();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub10().equals(""))
		    {
		    	String subdetails=em.getSub10();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub11().equals(""))
		    {
		    	String subdetails=em.getSub11();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		   <%  }%> <% 
		    if(!em.getSub12().equals(""))
		    {
		    	String subdetails=em.getSub12();
		    	String subcode=miscUtil.parseMarks(subdetails, 0);
		    	String intr=miscUtil.parseMarks(subdetails, 1);
		    	String extr=miscUtil.parseMarks(subdetails, 2);
		    	String tot=miscUtil.parseMarks(subdetails, 3);
		    	String grade=miscUtil.parseMarks(subdetails, 4);
		    
		    	%>
		    	<tr class=tableborder>
		    
		    	<td class=tableborder  height=20 nowrap style="font-size:xx-small;"><%=new SubjectDB().getSubjectTitle(subcode, st.getRegulation()) %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=intr %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=extr %></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;"><%=tot %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;"><%=grade %></td>
		    	</tr>
		    	
		    	
		   <%  }%>
		   <tr>
		    	<td class=tableborder  height=20 ></td>
		    	<td class=tableborder height=20 style="font-size:xx-small;" colspan=2>SGPA :: <%=sgpa %></td>
		    	<td class=tableborder  height=20 style="font-size:xx-small;" colspan=2>CGPA :: <%=cgpa  %></td>
		    	
		    	</tr>
		   </TABLE>
		   
		   </td>
		   
		   
		   
		   
		   
		
		<%  }  %>
		  </TABLE>
		  
		  </center>