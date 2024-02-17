<%@ page import = "dao.User" %>
<%@ page import = "dao.User,dao.StudentDB,java.util.ArrayList" %>

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

ArrayList regs=new StudentDB().getRegulations();
	
%>

<jsp:include page='<%= header %>' flush="true" />



<html>
	<head>
		
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h3>Payment Receipts for Regular Examination</h3></center>
					    <CENTER><br></br>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./regulatstpayments2.jsp" >
							
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Branch Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree"><option></option>
									<option value="B.Pharmacy">B.Pharmacy</option> 
        							<option value="M.Pharmacy">M.Pharmacy</option>  
        							<option value="Pharm.D">Pharm.D</option>
        							</select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester/Year: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="sem">
								<option></option>
									<option value="1" >1</option> 
        							<option value="2" >2</option> 
        							<option value="3" >3</option> 
        							<option value="4" >4</option> 
        							<option value="5" >5</option>
        							<option value="6" >6</option>
        							<option value="7" >7</option>
        							<option value="8" >8</option>	</select></TD></TR>
        							
        							
							
							
							
							<TR>
							    <TD colspan=2 align="center">
							<input type=hidden name="option" value="regularpayments1"></input>
							    <INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"  ></INPUT></TD>

							</TR>
							</FORM>
						</TABLE>
					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	</body>
</html>
