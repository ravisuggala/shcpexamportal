
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "dao.User,dao.StudentDB,java.util.ArrayList" %>
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

String degree=session.getValue("degree").toString();
String branch=session.getValue("branch").toString();
String sem=session.getValue("sem").toString();

String reg=session.getValue("reg").toString();
String ay=session.getValue("ay").toString();
//System.out.println(degree+branch+sem+reg);


String target=miscUtil.noNull(request.getParameter("hiddenActionType"));


	
%>

<jsp:include page='<%= header %>' flush="true" />

<html>
	<head>
		<title>SVCP--Examination Portal - External Examinations</title>

<script>
function toggle(selectObj) {
	var selectIndex=selectObj.selectedIndex; 
	var selectValue=selectObj.options[selectIndex].text;
	var degree=document.getElementById("degree").value;
	var branch=document.getElementById("branch").value;
	var sem=document.getElementById("sem").value;
	var reg=document.getElementById("reg").value;
	
	if(selectValue=='Common')
	{
	var urlString ="./commonsubjects.jsp?degree="+degree+"&branch="+branch+"&sem="+sem+"&reg="+reg ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#subject").html(result);
	}
	});
	
	
	document.getElementById("elerow").style.display = 'none';
	
	document.getElementById("subname").style.display = '';
		 
	}
	else if(selectValue=='Elective')
	{
	document.getElementById("subname").style.display = 'none';
	
	
	var urlString ="./eletypes.jsp?degree="+degree+"&branch="+branch+"&sem="+sem+"&reg="+reg ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#elecat").html(result);
	}
	});
	
	document.getElementById("elerow").style.display = '';
	
	}
	
	else
		{
		document.getElementById("elerow").style.display = 'none';
	
		document.getElementById("subname").style.display = 'none';
		}
	}
function subjectselect(elecat)
{
	var ele=elecat.value;
	var urlString ="./electivesubjects.jsp?selele="+ele ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#subject").html(result);
	}
	});
	
	document.getElementById("subname").style.display = '';
}

</script>
		
	</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>External Examinations Marks Entry</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./mp50marksStep2.jsp">
							
							<input type=hidden id=degree value=<%= degree%>></input>
							<input type=hidden id=branch value='<%= branch%>'></input>
							<input type=hidden id=sem value=<%= sem%>></input>
							<input type=hidden id=reg value=<%= reg%>></input>
							<input type=hidden name="hiddenActionType" value=<%=target %>></input>
							<TR>
							    <TD COLSPAN="2" ALIGN="center"><h3><b> Subject Selection</b></h3></TD>
							</TR>
							
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Subject Category </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="cat" onChange="toggle(this);">
								<option value="-">-</option>
								<option value="common">Common</option>
								<option value="elective">Elective</option>
								
								
								</select>
								</td></tr>
							<TR id="elerow" style="display:none">
								<TD  WIDTH="20%" ALIGN="right" nowrap>Elective Category </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="elecat" id="elecat" onChange="subjectselect(this);">
								</select> 
        						</td></tr>
							
        						
							<TR id="subname" style="display:none">
								<TD  WIDTH="20%" ALIGN="right" nowrap>Name of the Subject </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="subject" id="subject">
									
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
