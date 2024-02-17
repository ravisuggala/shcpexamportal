<!DOCTYPE html>

<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />



<%
String degree=miscUtil.getFromSession(request, response, "degree");
String branch=miscUtil.getFromSession(request, response, "branch");
String sem=miscUtil.getFromSession(request, response, "sem");
String reg=miscUtil.getFromSession(request, response, "reg");
String ay=miscUtil.getFromSession(request, response, "ay");
String examtype=miscUtil.getFromSession(request, response, "examtype");
String subject=miscUtil.getFromSession(request, response, "subject");
String valtype=miscUtil.getFromSession(request, response, "valtype");
String cdate=miscUtil.getFromSession(request, response, "cdate");
String examdate=miscUtil.getFromSession(request, response, "examdate");
String fname=miscUtil.getFromSession(request, response, "fname");
String desig=miscUtil.getFromSession(request, response, "desig");
String address=miscUtil.getFromSession(request, response, "address");
String tada=miscUtil.initializeMark(miscUtil.getFromSession(request, response, "tada"));
String ftype=miscUtil.getFromSession(request, response, "ftype");
String valdesc=miscUtil.getFromSession(request, response, "valdesc");


ArrayList valuations=(ArrayList)session.getValue("valuations");
if(ftype.equals("external")) valuations.add(valuations.size(),"TA/DA");
ArrayList list=new ArrayList();
String purpose="For "+degree+" "+miscUtil.semDescription(sem, degree)+"( "+ay+" )-"+valdesc+" Remuneration";

subject=subdb.getSubjectTitle(subject, reg)+"("+subject+")";

address=address.replaceAll("\n", "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

String labscripts="",labrate="",labamount="";
String theoryscripts="",theoryrate="",theoryamount="";
String mcqscripts="",mcqrate="",mcqamount="";
double sum=0.0;
for(int i=0;i<valuations.size();i++)
{
	String desc=valuations.get(i).toString();
	Valuation v=new Valuation();
	v.setSno((i+1)+"");
	v.setNature(desc);
	v.setNop(miscUtil.getRemunerationMeasurment(desc));
	if(desc.contains("Lab"))
	{
		labscripts=miscUtil.noNull(request.getParameter("labscripts"));
		labrate=miscUtil.noNull(request.getParameter("labrate"));
		labamount=miscUtil.initializeMark(request.getParameter("labamount"));
		v.setCnt(labscripts);
		v.setRate(labrate);
		v.setTotal(labamount);
		sum=sum+Double.parseDouble(labamount);
	}
	else if(desc.contains("Theory"))
	{
		theoryscripts=miscUtil.noNull(request.getParameter("theoryscripts"));
		theoryrate=miscUtil.noNull(request.getParameter("theoryrate"));
		theoryamount=miscUtil.initializeMark(request.getParameter("theoryamount"));
		v.setCnt(theoryscripts);
		v.setRate(theoryrate);
		v.setTotal(theoryamount);
		sum=sum+Double.parseDouble(theoryamount);
	}
	else if(desc.contains("MCQs"))
	{
		mcqscripts=miscUtil.noNull(request.getParameter("mcqscripts"));
		mcqrate=miscUtil.noNull(request.getParameter("mcqrate"));
		mcqamount=miscUtil.initializeMark(request.getParameter("mcqamount"));
		v.setCnt(mcqscripts);
		v.setRate(mcqrate);
		v.setTotal(mcqamount);
		sum=sum+Double.parseDouble(mcqamount);
	}
	else if(desc.contains("TA/DA"))
	{
		v.setCnt("-");
		v.setRate("-");
		v.setTotal(tada);
		sum=sum+Double.parseDouble(tada);
	}
	
	list.add(i,v);
	
	
}
String suminwords=miscUtil.convertToIndianCurrency(sum+"");

%>




<html>
<head>
	<title></title>
</head>
<body>
<button onClick="window.print()" style="float: right;">
		<img alt="No Image" height="25px" width="25px" src="./imgs/print.png">
	</button>

<img src="./imgs/letterhead.jpg"></img>
<h4><b>Purpose:</b> <%=purpose %> </h4>
<h4>Name of the Subject: <%=subject %></h4>
<h4>Date of the Exam: <%=examdate %></h4>
<h4>Name of the Staff: <%=fname %></h4>
<h4>Designation: <%=desig %></h4>
<h4>Address: <%=address %></h4>
<center><table border="1" style="width: 800px">
	<tr><th>S.No</th><th>Nature of Work</th><th colspan="2">Number</th><th>Rate(rs)</th><th>Total(rs)</th></tr>
	<%
	for(int i=0;i<list.size();i++){
		Valuation v=(Valuation)list.get(i);
	
	%>
	<tr><td><%=v.getSno() %></td><td><%=v.getNature() %></td><td><%=v.getNop() %></td> <td><%=v.getCnt() %></td> 
	  <td><center><%=v.getRate() %></center></td> <td><center><%=v.getTotal() %></center></td> </tr>
	  
	  <%} %>
	<tr><td colspan="5"><center>Grand Total</center></td><td><%=sum %></td></tr>
</table></center>
<br>
Received  <b><%= suminwords %></b>
<br>
I certify that the work assigned is completed and this bill is not claimed earlier from any source.<br><br>
Station: Bhimavaram<br>
Date:<%=cdate %>              
 <p style="text-align: right"> Signature</p>

<hr>
<center><b>For Office Use Only</b></center><br>
The bill is passed for <b><%=suminwords %></b><br>
<br><br><br>

<p style = "margin-left: 35px;">
<table  align="center" width="100%">
<tr>
<td width="30%" height="30%">Office asst.</td>
<td width="30%" height="30%"> A.O</td>
<td width="30%" height="30%">Controller of Examination </td>

</table>
</p>



</body>
</html>