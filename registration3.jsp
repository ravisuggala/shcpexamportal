<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> SVECW -- External Examinations Registrations</title>
 <script type="text/javascript">
    function EnableDisableTextBox(chkPassport) {
        var txtPassportNumber = document.getElementById("txtPassportNumber");
        txtPassportNumber.disabled = chkPassport.checked ? false : true;
        if (!txtPassportNumber.disabled) {
            txtPassportNumber.focus();
        }
    }
</script>
</head>
<body>
<%@ page import = "dao.*,java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />


<%@ page import="dao.User"%>


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

else if(ur.getStatus().equals("office"))
	header="./feemenuheader.jsp";
	
%>

<jsp:include page='<%= header %>' flush="true" />




<%
Student st=(Student)session.getValue("student");

String subs[]=request.getParameterValues("subjects");
String out1=new String();
String selsubjects="";
String amount="";
int subcount=0;
String type=session.getAttribute("type").toString();
if (subs != null) 
{
	
	for(int i=0;i<subs.length;i++)
	{
		String sub=subs[i];
		out1=out1+sub+"<br>";
		selsubjects=selsubjects+sub+"#";
	}
	//System.out.println(selsubjects);
	subcount=subs.length;
	if(type.equals("SUPPLEMENTARY"))
	{
		if(subcount==1) amount="750";
		else if(subcount==2) amount="1500";
		else if(subcount==3) amount="2250";
		else if(subcount>=4) amount="3000";	
	}
	else if(type.equals("REVALUATION"))
	{
		if(subcount==1) amount="750";
		else if(subcount==2) amount="1500";
		else if(subcount==3) amount="2250";
		else if(subcount>=4) amount="3000";	
	}
	else if(type.equals("SUPPLY REVALUATION"))
	{
		if(subcount==1) amount="750";
		else if(subcount==2) amount="1500";
		else if(subcount==3) amount="2250";
		else if(subcount>=4) amount="3000";	
	}
	else if(type.equals("SPECIAL THEORY"))
	{
		if(subcount==1) amount="15000";
		else if(subcount==2) amount="30000";
			
	}
	
	
	st.setSubcount(subcount+"");
	st.setSelsubjects(selsubjects);
	st.setAmount(amount);
	session.setAttribute("student",st);
}
else
out.println("<br><br><center><font color=green><h4> No Subject Selection made for Registrations</h4></font></center><br>");

%>
	<div id="centre">
<center>
			<h2>External Examinations Registration</h2>
		</center>
		<CENTER>
			<FORM NAME=REGISTER METHOD=POST ACTION="./ActionServlet"  >
				<INPUT TYPE=HIDDEN NAME="option" VALUE="receipt">

				<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="500">
					<TR>
						<TD COLSPAN="3" ALIGN="center"><h5>	<b> List of Selected Subjects for Regd.No.<%= st.getRegdno() %></b></h2></TD>
					</TR>
					<TR>
						<th nowrap>Selected Subjects List</th>
						<td nowrap><%=out1 %></td>
					</tr>
				<!--  	<TR>
						<th nowrap>Amount to be paid for <%=subs.length %> subjects</th>
						<td><%=amount %> /-</td>
					</tr>
					<TR>
						<th nowrap>Late Fee Amount</th>
						<td> 
						 
    					<input type="checkbox" id="chkPassport" onclick="EnableDisableTextBox(this)" />
    						Late Fee?
						
						&nbsp;&nbsp;&nbsp;
						<input type="text" id="txtPassportNumber" name="latefee" disabled="disabled" size=10  />
						
						
						</td>
					</tr>
				-->	
	    			<tr>
						<td colspan=2 align=center><input type=submit value=Continue></td>
						</tr>
				</table>
			</FORM>
		</CENTER>



	</div>


</html>