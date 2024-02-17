<head>
<script src="JS/jquery-1.4.2.min.js"></script>
<script language=javascript>

function deleteFaculty(){
	// use here ajax call .. which will populate second box data
	var ret=confirm("Are you Sure?");
	if(ret==true)
		{
		var firstBoxValue = document.getElementById("fno").value;
		
		var urlString ="./ftdeleted.jsp?fno="+firstBoxValue ;
		$.ajax({
		type: "POST",
		url: urlString ,
		success: function(result) {
		console.info("result"+result);
		$("#delstatus").html(result);
		}
		});
			
		}
	
	}

</script>


<%@ page import = "java.util.*" %>
<%@ page import = "java.util.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />



		  
			    <center><h3>Faculty Deletion</h3></center>
			    <CENTER>
			    
			    <br></br>
			             	<FORM NAME = stdelete>
						<TABLE border=1>
							
							<TR>
								<TD   ALIGN="left">Faculty Login ID: </TD>
								<TD   align="left">
								<input type=text id="fno" name=fno size=15></input>
								
								<TD align="center"><INPUT TYPE="BUTTON" NAME="Submit" VALUE="Delete" onClick="deleteFaculty()"></INPUT></TD>
								
							</TR>
						</TABLE>
						</FORM>
					<br> <div id="delstatus"></div>
					    </CENTER>			  
					   
					 
					   
					   
		 
