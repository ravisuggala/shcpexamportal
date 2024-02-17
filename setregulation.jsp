
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	
	<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<%
ArrayList degrees=stdb.getDegrees();
ArrayList yoas=stdb.getYoas();

ArrayList regs=subdb.getRegulations();

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
	<script>
	function handleClick(myRadio) {
	    
	    var s=myRadio.value;
	  
	    if(s=="old")
	    	{
	    
	    	document.getElementById("hidethis1").style.display = '';
	    	document.getElementById("hidethis2").style.display = 'none';
	    	}
	    else if(s=="new")
	    {
	    	
	    	document.getElementById("hidethis2").style.display = '';
	    	document.getElementById("hidethis1").style.display = 'none';
	    }
	
	}
	</script>
	
	<body>
		  <div id="centre">
					
	
					    <center><h3>Setting Regulation to Students</h3></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./regulationset.jsp">
							
							
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Course Selection</b></h3></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select name=degree>
								<option value=""></option>
								
									<%
										for(int i=0;i<degrees.size();i++)
										{
											String degree=degrees.get(i).toString();
											
											%>
											<option value='<%=degree %>' ><%=degree %></option>
											<%
											
										}
									%>
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
							<tr>
							<TD  WIDTH="10%" ALIGN="right" nowrap>Type: </TD>
							<td WIDTH="10%" align="left" nowrap>
							<input type="radio" name="type" value="old" onClick="handleClick(this)"> Existing
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  							<input type="radio" name="type" value="new" onClick="handleClick(this)"> New
  
							</tr>
							<tr id="hidethis1" style="display:none;">
							<TD  WIDTH="10%" ALIGN="right" nowrap>Regulation: </TD>
							<td WIDTH="10%" align="left">
							
							<select name=reg>
								<option value=""></option>
								
									<%
										for(int i=0;i<regs.size();i++)
										{
											String reg=regs.get(i).toString();
											
											%>
											<option value='<%=reg %>' ><%=reg %></option>
											<%
											
										}
									%>
									</select>
							</td>
							</tr>
							<tr id="hidethis2" style="display:none;">
							<TD  WIDTH="10%" ALIGN="right" nowrap>Regulation: </TD>
							<td WIDTH="10%" align="left">
							<input type="text" name="regtext" size=5></input>
  							</tr>
	
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
