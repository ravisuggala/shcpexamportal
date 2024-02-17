
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 

<%@ page import = "dao.User,java.util.*" %>

<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

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

ArrayList yoas=stdb.getYoas();
ArrayList regs=stdb.getRegulations();
%>
<jsp:include page='<%= header %>' flush="true" />


<script language=javascript>

function CheckLength(Obj) {
    if (Obj.value.length == 10) {
        doSubmit('bafrm');
    }
}
function populateSecValues(obj){
	// use here ajax call .. which will populate second box data
	var yoa = obj.value;
	var degree=$("#degree").val();
	var sem=$("#sem").val();
	var ay=$("#ay").val();
	var type=$("#type").val();
	var reg=$("#reg").val();
	
	var urlString ="./getexamslist.jsp?degree="+degree+"&sem="+sem+"&ay="+ay+"&type="+type+"&reg="+reg+"&yoa="+yoa ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#exam").html(result);
	}
	});
	}
function IsNumeric(sText)
{
   var ValidChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
   var IsNumber=true;
   var Char;
   for (i = 0; i < sText.length && IsNumber == true; i++)
   {
      Char = sText.charAt(i);
      if(ValidChars.indexOf(Char) == -1)
      {
       IsNumber = false;
      }
   }
   return IsNumber;
}

function doSubmit(operation)
{
  if(operation == "bafrm")
{
  if(document.getElementById("bafrm").regdno.value != "" && IsNumeric(document.getElementById("bafrm").regdno.value))
  {
	   var code=$("#exam").val();
	   var regdno=$("#regdno").val();
	   var sUrl ="./getregisteredsubjects.jsp?regdno=" + regdno+"&exam="+code;
	   $.ajax({
			type: "POST",
			url: urlString ,
			success: function(result) {
			console.info("result"+result);
			$("#subject").html(result);
			}
			});
  }
}
}
</script>
</head>
	<body>
		  <div id="centre">
					
	
					    <center><h1>Examination Registration Deletion</h1></center>
					    <CENTER>
					    	<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							<FORM name="bafrm" id="bafrm" METHOD = POST ACTION = "./delexamregistration3.jsp">
							<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "xternalstep1">
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "xternalstep1">
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Course:</TD>
								<TD  WIDTH="10%" align="left">
									<select id="degree" size="1" name="degree"><option></option>
									<option value="B.PHARMACY">B.PHARMACY</option> 
        							<option value="M.PHARMACY">M.PHARMACY</option>  </select>
								</TD>
							<TR>
								<TD  WIDTH="10%" ALIGN="right">Semester: </TD>
								<TD  WIDTH="10%" align="left">
								<select name="sem" id="sem">
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
                                <TD  WIDTH="20%" ALIGN="right" nowrap>Academic Year:<br>(yyyy-yyyy)</br> </TD>
								<td WIDTH="10%" ALIGN="left">
								<%String ay=new dao.SubjectDB().getCurrentAY(); %>
								<input list="ay1" maxlength="10" name="ay" id="ay">
								<datalist id="ay1">
    							<option value="<%=ay%>">
    							</datalist>
								</td>
                                </TR>
								<TR>
								<TD  WIDTH="20%" ALIGN="right">Type </TD>
								<td WIDTH="10%" ALIGN="left">
								<select name="type" id="type">
								<option></option>
									<option value="regular">Regular</option>
									 <option value="supply">Supplementary</option>
									 <option value="revaluation">Revaluation</option>
								</select> 
        						</td>
        						</tr>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Regulation </TD>
								<td WIDTH="10%" ALIGN="left">
								<select id="reg" name=reg ">
								<option value="-">-</option>
								
									<%
										for(int i=0;i<regs.size();i++)
										{
											String sub=regs.get(i).toString();
											
											%>
											<option value='<%=sub %>'><%=sub %></option>
											<%
											
										}
									%>
									</select>
								</td></tr>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Admitted Batch:</TD>
								<td WIDTH="10%" ALIGN="left">
								
								<select id="yoa" name=yoa onchange="populateSecValues(this)">
								<option value="-">-</option>
								
									<%
										for(int i=0;i<yoas.size();i++)
										{
											String sub=yoas.get(i).toString();
											
											%>
											<option value='<%=sub %>'><%=sub %></option>
											<%
											
										}
									%>
									</select>
								</td>
							</tr>
							<tr>
							<td nowrap align=right> Name of the Examination:
							
							<td colspan=2>
							<select id=exam name="exam">
							
							
							</select>
						</td>
						</tr>										
						<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Regd. Number:</TD>
								<td WIDTH="10%" ALIGN="left"><input id="regdno" maxlength="10" name="regdno" maxlength="10" size="10" onkeyup="javascript: CheckLength(this);"></td>
							</tr>
						<TR>
							    <TD colspan=2 align="center">
							    <INPUT TYPE="SUBMIT" NAME="submit" VALUE="Next"></INPUT></TD>

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
