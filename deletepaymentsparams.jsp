
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 

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

<html>
	<head>
		<title>SVCP--Examination Portal - External Examinations</title>
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>Delete Payment Details</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./deletepaymentsprogress.jsp" onsubmit="return  confirm('Are you sure')" >
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep1">
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" ><option></option>
									<option value="B.Pharmacy">B.Pharmacy</option> 
        							<option value="M.Pharmacy">M.Pharmacy</option>  
        							<option value="Pharm.D">Pharm.D</option>
        							</select>
								</TD>
							</TR>
								<TR>
								<TD  WIDTH="10%" ALIGN="right">Type: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="type">
								<option></option>
									<option value="SUPPLEMENTARY">SUPPLEMENTARY</option> 
        							<option value="REVALUATION">REVALUATION</option>
        							<option value="REGULAR">REGULAR</option>
        							<option value="SUPPLY REVALUATION">SUPPLY REVALUATION</option>
        							<option value="SPECIAL THEORY">SPECIAL THEORY</option> 
        							
        							</select></TD>
        							</TR>
        					
													
							<TR>
							    <TD colspan=2 align="center">
							    <INPUT TYPE="SUBMIT" NAME="submit" VALUE="Submit"></INPUT></TD>

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
</html>
