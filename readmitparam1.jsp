
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
ArrayList yoas=stdb.getYoas();
String degree="";
String branch="";
String yoa="";
String fromsem="";
String tosem="";
String section="";

String status=miscUtil.noNull(session.getValue("fromstatus"));

if(status.equals("fromstatus"))
{
	 degree=miscUtil.noNull(session.getValue("degree").toString());
	 branch=miscUtil.noNull(session.getValue("branch").toString());
	yoa=miscUtil.noNull(session.getValue("yoa").toString());
	 fromsem=miscUtil.noNull(session.getValue("fromsem").toString());
	tosem=miscUtil.noNull(session.getValue("tosem").toString());
	 section=miscUtil.noNull(session.getValue("section").toString());

}
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
					
	
					    <center><h3>Student ReAdmission</h3></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./readmitparam2.jsp">
							
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Branch Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select size="1" name="degree" id="degree"><option></option><option value="B.TECH" <%=degree.equals("B.TECH")?"SELECTED":"" %>>B.TECH</option> 
        							<option value="M.TECH" <%=degree.equals("M.TECH")?"SELECTED":"" %>>M.TECH</option> <option value="M.B.A" <%=degree.equals("M.B.A")?"SELECTED":"" %>>M.B.A</option> <option 
        							value="M.C.A" <%=degree.equals("M.C.A")?"SELECTED":"" %>>M.C.A</option>  </select>
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
											<option value='<%=sub %>' <%=sub.equals(yoa)?"SELECTED":"" %>><%=sub %></option>
											<%
											
										}
									%>
									</select>
								
							
							</td>
							
							</tr>
							<TR>
								<TD  WIDTH="10%" ALIGN="right"> Detained Semester: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="fromsem">
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
								<TD  WIDTH="20%" ALIGN="right" nowrap>ReAdmit Year:<br>(yyyy-yyyy)</br> </TD>
								<td WIDTH="10%" ALIGN="right"><input maxlength="10" name="ay"></td></tr>
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
