
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "dao.User,dao.StudentDB,java.util.ArrayList,dao.Subject" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />

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
ArrayList regs=new StudentDB().getRegulations();

String target=miscUtil.noNull(request.getParameter("hiddenActionType"));


String degree=miscUtil.getFromSession(request, response, "degree");
String branch=miscUtil.getFromSession(request, response, "branch");
String sem=miscUtil.getFromSession(request, response, "sem");
String section=miscUtil.getFromSession(request, response, "section");
String reg=miscUtil.getFromSession(request, response, "reg");
String ay=miscUtil.getFromSession(request, response, "ay");



%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		<title>SVCP--Examination Portal - Lab Examinations</title>

<script>

</script>
		
	</head>
	<body>
	
	<%
	ArrayList slist=(ArrayList)session.getAttribute("subjects");
	%>
		  <div id="centre">
					
	
					    <center><h1>Lab Examinations Marks Entry</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./labStep2.jsp">
							
							<input type=hidden id=degree name="degree" value=<%= degree%>></input>
							<input type=hidden id=branch name="branch" value=<%= branch%>></input>
							<input type=hidden id=sem name="sem" value=<%= sem%>></input>
							<input type=hidden id=reg name="reg" value=<%= reg%>></input>
							<input type=hidden id=section name="section" value=<%= section%>></input>
							<input type=hidden id=ay name="ay" value=<%= ay%>></input>
							<input type=hidden name="hiddenActionType" value=<%=target %>></input>
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Subject Selection</b></h3></TD>
							</TR>
							
							
							<TR id="subname" >
								<TD  WIDTH="20%" ALIGN="right" nowrap>Name of the Lab </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="subject" id="subject">
											<option value="-" selected>-</option>				<%
										for(int i=0;i<slist.size();i++)
										{
											Subject sub=(Subject)slist.get(i);
											
											   String code=sub.getCode();
											   String name=sub.getSname();
											
											%>
											<option value='<%=code %>'><%=name %></option>
											<%
											
										}
									%>
			
        						</select> 
        						</td></tr>
        						
        						
							
							
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
