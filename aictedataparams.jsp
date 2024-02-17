
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
		<script language="javascript" src="./JS/datetimepicker.js"></script>
</head>	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
ArrayList yoas=stdb.getYoas();

%>	

	
	
	<body>
		  <div id="centre">
					
	
					    <center><h3>AICTE Grade Sheet Download</h3></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./aictedataprogress.jsp">
							
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Course Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree">
									<option></option>
									<option value="B.PHARMACY">B.PHARMACY</option> 
        							<option value="M.PHARMACY">M.PHARMACY</option>
        							</select>
								</TD>
							<tr>
							<TD  WIDTH="10%" ALIGN="right" nowrap>Year of Admission: </TD>
							<td WIDTH="10%" align="left">
							
							<select name=yoa>
								<option value=""></option>
								
									<%
										for(int i=0;i<yoas.size();i++)
										{
											String sub=yoas.get(i).toString();
											
											%>
											<option value='<%=sub %>' ><%=sub %></option>
											<%
											
										}
									%>
									</select>
								
							
							</td>
							</tr>
								<TR>
								<TD  WIDTH="10%" ALIGN="right">Branch: </TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="branch" id="branch">
									<option></option>
									<option value="B.Pharmacy">B.Pharmacy</option> 
									<option value="Pharmaceutics">Pharmaceutics</option> 
        							<option value="P.R.A">Pharmaceutical Regulatory Affairs</option> 
        							<option value="P.C">Pharmaceutical Chemistry</option> 
        							<option value="P.A">Pharmaceutical Analysis</option> 
        							<option value="Pharmacology">Pharmacology</option> 
        							 </select>
								</TD>
							</TR>
							
        						<TR>
							    <TD colspan=2 align="center">
							    <INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT></TD>
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
