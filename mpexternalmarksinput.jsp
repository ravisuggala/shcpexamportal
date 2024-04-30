
<head>
<script language="javascript" src="./JS/FormChek.js"></script>
<script type="text/javascript" src="./JS/jquery-1.4.2.min.js">  </script>

<script type="text/javascript">
        $(function() {
            $('input:text:first').focus();
            
            var $inp = $('input:text');
            
            $inp.bind('keydown', function(e) {
            	 //var key = (e.keyCode ? e.keyCode : e.charCode);
                var key = e.which;
                if (key === 9) {
                    e.preventDefault();
                    $(this).focus();
                }
                if (key == 13) {
                	if(!validateMarks(this))
                	
                     {
                    e.preventDefault();
                    var nxtIdx = $inp.index(this) + 1;
                    $(":input:text:eq(" + nxtIdx + ")").select();
                    $(":input:text:eq(" + nxtIdx + ")").focus();
                    
                    }
                	else{
                		e.preventDefault();
                		var currentTextboxValue = $(this).val();
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
	 
	 var patt1 = new RegExp("^(a|A|[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|6[0-9]|70)$");
	 
	 var patt2 = new RegExp("^(a|A|[0-9]|1[0-9]|20)$");
	 var patt4 = new RegExp("^(a|A|[0-9]|1[0-9]|2[0-9]|3[0-9]|40)$");
	 
	 var max=document.getElementById('maxmarks').value;
	 
	 if(id1=="dm")
	 {
		// var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
		 var regex = generateRegex(max);
		 if (regex.test(value)) {
		 	//res=asspatt.test(value);
		 	if(value.toUpperCase()=="A") res=true;
		 	else
		 		{
		 		var floatValue = parseInt(value);
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
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";
	
%>

<jsp:include page='<%= header %>' flush="true" />


<%

ArrayList marksrows=new ArrayList();
String status="";
String title="";
String subject=new String();
String maxmarks=miscUtil.getFromSession(request, response,"maxmarks");
String examname="";
if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");
     session.removeAttribute("marksinput");
	 
	
	 out.println("<center><h6>"+status+"</h6></center>");
		%>
		 <jsp:include page='./mpexternalmarksstatus.jsp' flush="true" />
	    <% 
}
else
{
 subject=miscUtil.getFromSession(request, response,"subject");
 examname=miscUtil.getFromSession(request, response,"examname");
ArrayList students=(ArrayList)session.getValue("students");
SubjectDB subdb=new SubjectDB();

ArrayList mapids=(ArrayList)session.getValue("mapids");
String sem=session.getValue("sem").toString();
String branch=session.getValue("branch").toString();

title=miscUtil.getFromSession(request, response, "title");

MidExamDB medb=new MidExamDB();
for(int i=0;i<mapids.size();i++)
{
	MarksRow mr=new MarksRow();
	
	String mapid=mapids.get(i).toString();
	//System.out.println(mapid);
	MidExam attempted=medb.findMapidinMPExternal(mapid,examname);
	String regdno=mapid.substring(0,mapid.indexOf('-'));
	String sname=new StudentDB().getStudentName(regdno);
	String dmbox=new String();
	String qmbox=new String();
	
	String atbox=new String();
	//System.out.println("jsp:"+attempted.isMidExisted());
	if(attempted.isMidExisted())
	{
		dmbox="<input id=dm"+i+" type=text size=3 maxlength=5 name="+mapid+"-dm-"+examname+" value="+attempted.getDm()+"></input>";
		qmbox="<input id=qm"+i+" type=hidden size=3 maxlength=5 name="+mapid+"-qm-"+examname+" value="+attempted.getQm()+"></input>";
		atbox="<input type=hidden size=3 name=h"+mapid+"-"+examname+" value=true></input>";
			 
	}
	else
	{
	     dmbox="<input id=dm"+i+"  type=text maxlength=5 size=3 name="+mapid+"-dm-"+examname+"></input>";
	     qmbox="<input id=qm"+i+"  type=hidden maxlength=5 size=3 name="+mapid+"-qm-"+examname+"></input>";
		 atbox="<input type=hidden size=3 name=h"+mapid+"-"+examname+" value=false></input>";
			
		
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	mr.setDmbox(dmbox);
	mr.setQmbox(qmbox);
	mr.setHidden(atbox);
	marksrows.add(i, mr);
}
}
%>


<html>
	<head>
		
		
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
							
							<input type=hidden id="maxmarks" value='<%=maxmarks %>'></input>
							<TR>
							    <TD COLSPAN="6" ALIGN="center"><h6><b>External Marks Entry</b></h6></TD>
							</TR>
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap><font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<th nowrap><font size=1>Marks<br>(<%=maxmarks %>)</font>
							
							
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
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "mpexternalmarks">
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
