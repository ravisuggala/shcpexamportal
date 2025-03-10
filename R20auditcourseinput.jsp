
<head>
<script language="javascript" src="./JS/FormChek.js"></script>
<script type="text/javascript" src="./JS/jquery-1.4.2.min.js">  </script>

<script type="text/javascript">
$(function() {
    $('input:text:first').focus();
    
    var $inp = $('input:text');
    
    // Automatically select the text when a textbox gains focus
    $inp.focus(function() {
        $(this).select();
    });

    $inp.bind('keydown', function(e) {
        var key = e.which;
        
        // On 'Tab' key press
        if (key === 9) {
            e.preventDefault();
            $(this).focus();
        }
        
        // On 'Enter' key press
        if (key == 13) {
            e.preventDefault();
            
            if (!validateMarks(this)) {
                var nxtIdx = $inp.index(this) + 1;
                $(":input:text:eq(" + nxtIdx + ")").select().focus();
            } else {
                // Select the entire text in the current textbox
                $(this).select();
            }
        }
    });
});

        
        
        
            </script>

   
<script language="javascript">

function generateRegex(maxMarks) {
	  // Build the regex pattern dynamically
	  var regexPattern = '^(a|A';
	  
	  // Allow any digit from 0 to the maximum marks
	  
	  
	  // Allow double-digit numbers less than or equal to the maximum marks
	  for (var i = 0; i <= maxMarks; i += 1) {
	    regexPattern += '|' + i.toString();
	  }
	  
	  // Close the regex pattern
	  regexPattern += ')$';

	  // Create a RegExp object with the generated pattern
	  const regex = new RegExp(regexPattern);

	  return regex;
	}
function validateMarks(field) 
{
	var i;
	
	 if(!checkString(field,"\" Student Marks \"",false)) 
          return true;
	 
	 
	 var value=field.value;
	 
	 
	 var id=field.id;
	 var id1=id.substr(0,2);
	
	
	 //var asspatt = generateRegex(max);
	 if(id1=="dm")
	 {
		 var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
		 var max=document.getElementById('midmax').value;
		 if (regex.test(value)) {
		 	//res=asspatt.test(value);
		 	if(value.toUpperCase()=="A") res=true;
		 	else
		 		{
		 		var floatValue = parseFloat(value);
			 	if (floatValue <= max) {
			 		res=true;
			 	}
			 	else
			 		res=false;
		 		}
		 	
		 }
		 else
			 res=false;
		 	
			 
	 }
	 
	 
	 if(!res)
	{
		alert("Invalid Marks");
		return true;
	 }
  
	 return false;
	 

 //  document.forms['REGISTER'].submit();
	
}
function formsubmit()
{
    var form1 = document.forms['REGISTER'];
    var flag=0;
    //formName being the name of the form
    for (i = 0; i < form1 .length; i++) {
    inp= form1 .elements[i];
    if (inp.value.length == 0){
    	flag=1;
    alert("Please enter marks in all text boxes");
    break;
    }
    }
    if(flag==0)
	document.forms['REGISTER'].submit();
}

</script>

</head>
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%@ page import = "dao.User" %>


<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
if(ur.getStatus().equals("admin"))
	header="./adminheader.jsp";
else if(ur.getStatus().equals("clerk"))
	header="./mainmenuheader.jsp";

	
%>

<jsp:include page='<%= header %>' flush="true" />


<%

ArrayList marksrows=new ArrayList();
String status="";
String title="";
String subject=new String();
String type=new String();
String maxmarks="";
if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");
	
	 out.println("<center><h6>"+status+"</h6></center>");
		
		 
	 session.removeAttribute("marksinput");
	 

}
else
{
 subject=miscUtil.getFromSession(request, response,"subject");
ArrayList students=(ArrayList)session.getValue("students");
SubjectDB subdb=new SubjectDB();

ArrayList mapids=(ArrayList)session.getValue("mapids");
String sem=session.getValue("sem").toString();
String branch=session.getValue("branch").toString();

String section=session.getValue("section").toString();

title=miscUtil.getFromSession(request, response, "title");
maxmarks=miscUtil.getFromSession(request, response, "maxmarks");

MidExamDB medb=new MidExamDB();
for(int i=0;i<mapids.size();i++)
{
	MarksRow mr=new MarksRow();
	
	String mapid=mapids.get(i).toString();
	MidExam attempted=medb.findMapidinAudit(mapid);
	String regdno=mapid.substring(0,mapid.indexOf('-'));
	String sname=new StudentDB().getStudentName(regdno);
	String dmbox=new String();
	String qmbox=new String();
	String ambox=new String();
	String atbox=new String();
	//System.out.println("jsp:"+attempted.getDm());
	if(attempted==null)
	{
			 dmbox="<input id=dm"+i+"  type=text maxlength=2 size=3 name="+mapid+"-dm"+"></input>";
			 qmbox="<input id=qm"+i+" type=hidden maxlength=2 size=3 name="+mapid+"-qm"+" ></input>";
			 ambox="<input id=am"+i+" type=hidden maxlength=2 size=3 name="+mapid+"-am"+" ></input>";	
			 atbox="<input type=hidden size=3 name=h"+mapid+" value=false></input>";	 
		 
		 
		 
	}
	else
	{
		 
			dmbox="<input id=dm"+i+" type=text size=3 maxlength=2 name="+mapid+"-dm"+" value="+attempted.getDm()+"></input>";
			 qmbox="<input id=qm"+i+" type=hidden size=3 maxlength=2 name="+mapid+"-qm"+" value="+attempted.getQm()+" ></input>";
			 ambox="<input id=am"+i+" type=hidden maxlength=2 size=3 name="+mapid+"-am"+" ></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+" value=true></input>";
		
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	mr.setDmbox(dmbox);
	mr.setQmbox(qmbox);
	mr.setAmbox(ambox);
	mr.setHidden(atbox);
	
	marksrows.add(i, mr);
}
}
%>


<html>
	<head>
		<title>SHCP - Examination Portal - Mid Examinations</title>
		
	</head>
	<body>
		  <div id="centre">
			    <center><h3><%=title %></h3></center>
			    
			    <% 
			    if(marksrows.size()>0)
			    {
			    	
			    %>
			    <CENTER>
						<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="300">
							<FORM NAME = REGISTER METHOD = POST ACTION = "./ActionServlet" >
							
							<input type=hidden id="midmax" value='<%=maxmarks %>'></input>
							<TR>
							    <TD COLSPAN="6" ALIGN="center"><h6><b> Student List</b></h6></TD>
							</TR>
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap><font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							
							<th><font size=1>Descriptive<br>Marks(<%=maxmarks %>)</font>
							
							
							</tr>
							<%
							
							for(int i=0;i<marksrows.size();i++)
							{
								MarksRow mr=(MarksRow)marksrows.get(i);					
							%>
							<tr>
							<td align=right><%=mr.getSlno() %>
							<td NOWRAP><%=mr.getName() %>
							<td align=center><%=mr.getRegdno() %>
							<td align=center><%=mr.getDmbox() %>
							
							
							<%=mr.getHidden() %>
							</tr>
							<%} %>
							<tr>
							<TD colspan=6 align="center">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "auditmarks">
							<input id="btnSubmit" type="button" value="Submit" onclick="formsubmit()"></input></TD>
							
							</FORM>
						</TABLE>
					    </CENTER>		
					    <%} %>	  
					   
					   
					   
		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	
	</body>
</html>
