
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
	
	
	 //var asspatt = generateRegex(max);
	 if(id1=="dm")
	 {
		 
		 var max=document.getElementById('midmax').value;
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
	 else if(id1=="at"){
		 var max=document.getElementById('attmax').value;
		 var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
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
		 
	 }
	else if(id1=="ac"){
		var max=document.getElementById('actmax').value;
		var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
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
		 
	 }
	 
	else if(id1=="as"){
		var max=document.getElementById('assmax').value;
		 var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
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
		 
	 }
	 
	 if(!res)
	{
		alert("Invalid Marks");
		return true;
	 }
    
	 return false;
	 

   //  document.forms['REGISTER'].submit();
	
}
/* function validateMarks(field) 
{
	var i;
	 if(!checkString(field,"\" Student Marks \"",false)) 
            return true;
	 
	 
	 var value=field.value;
	 
	 var id=field.id;
	 var id1=id.substr(0,2);
	 
	 var max=document.getElementById('max').value;
	 var patt1 = generateRegex(max);
	 //var patt1 = new RegExp("^(a|A|[0-9]|1[0-9]|2[0-9]|30|0\.5|1\.5|2\.5|3\.5|4\.5|5\.5|6\.5|7\.5|8\.5|9\.5|10\.5|11\.5|12\.5|13\.5|14\.5|15\.5|16\.5|17\.5|18\.5|19\.5|20\.5|21\.5|22\.5|23\.5|24\.5|25\.5|26\.5|27\.5|28\.5|29\.5)$");
	 var patt2 = new RegExp("^(a|A|[0-9]|10)$");
	 var patt3 = new RegExp("^(a|A|[0-9]|1[0-9]|20)$");
	 var patt4 = new RegExp("^(a|A|[0-9]|1[0-9]|2[0-9]|3[0-9]|40)$");
	 
	 if(id1=="dm")
	 	res = patt1.test(value);
	
	 if(!res)
		 {
		   alert("Invalid Marks");
		   return true;
		 }
	    
    
	 return false;
	 

   //  document.forms['REGISTER'].submit();
	
}
 */
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
<style>
input:focus {
  background-color: grey;
  color: white;
}
</style>
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
String midno=new String();
String midmax=miscUtil.getFromSession(request, response,"midmax");


if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");
     session.removeAttribute("marksinput");
	 
	
	 out.println("<center><h6>"+status+"</h6></center>");
		%>
		 <jsp:include page='./storemarksstatus.jsp' flush="true" />
	    <% 
	 
		 
	 

}
else
{
 subject=miscUtil.getFromSession(request, response,"subject");
ArrayList students=(ArrayList)session.getValue("students");
SubjectDB subdb=new SubjectDB();

ArrayList mapids=(ArrayList)session.getValue("mapids");
String sem=session.getValue("sem").toString();
String branch=session.getValue("branch").toString();
midno=session.getValue("midno").toString();
String section=session.getValue("section").toString();

title=miscUtil.getFromSession(request, response, "title");

MidExamDB medb=new MidExamDB();

for(int i=0;i<mapids.size();i++)
{
	MarksRow mr=new MarksRow();
	
	String mapid=mapids.get(i).toString();
	MidExam attempted=medb.findSemMapidinMid(mapid);
	String regdno=mapid.substring(0,mapid.indexOf('-'));
	String sname=new StudentDB().getStudentName(regdno);
	String dmbox=new String();
	String attbox=new String();
	String actvtsbox=new String();
	String assbox=new String();
	String atbox=new String();
	//System.out.println("jsp:"+attempted.getDm());
	if(attempted.isMidExisted())
	{
		
			dmbox="<input id=dm"+i+" type=text size=3 maxlength=5 name="+mapid+"-"+midno+" value="+attempted.getDm()+"></input>";
		
			
		atbox="<input type=hidden size=3 name=h"+mapid+"-"+midno+" value=true></input>";
			 
	}
	else
	{
			
				dmbox="<input id=dm"+i+"  type=text maxlength=5 size=3 name="+mapid+"-dm"+midno+"></input>";
				
				
		 atbox="<input type=hidden size=3 name=h"+mapid+"-"+midno+" value=false></input>";
			
		
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	mr.setDmbox(dmbox);
	mr.setAttbox(attbox);
	mr.setQmbox(actvtsbox);
	mr.setAssbox(assbox);
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
							
							<input type=hidden id="midmax" value='<%=midmax %>'></input>
							
							
							
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap><font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<th><font size=1>Descriptive Marks<br>(<%=midmax %>)</font>
							
							
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
							<TD colspan=4 align="center">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "midmarks">
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
