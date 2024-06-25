
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

function validateMarks(field) 
{
	var i;
	
	 if(!checkString(field,"\" Student Marks \"",false)) 
           return true;
	 
	 
	 var value=field.value;
	 var midmax=document.getElementById('midmax').value;
	 var quizmax=document.getElementById('quizmax').value;
	 var assmax=document.getElementById('assmax').value;
	 
	 
	 var id=field.id;
	 var id1=id.substr(0,2);
	
	
	 //var asspatt = generateRegex(max);
	 if(id1=="dm")
	 {
		 var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
		 if (regex.test(value)) {
		 	//res=asspatt.test(value);
		 	if(value.toUpperCase()=="A") res=true;
		 	else
		 		{
		 		var floatValue = parseFloat(value);
			 	if (floatValue <= midmax) {
			 		res=true;
			 	}
			 	else
			 		res=false;
		 		}
		 	
		 }
		 else
			 res=false;
		 	
			 
	 }
	 else if(id1=="qm"){
		 var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
		 if (regex.test(value)) {
		 	//res=asspatt.test(value);
		 	if(value.toUpperCase()=="A") res=true;
		 	else
		 		{
		 		var floatValue = parseFloat(value);
			 	if (floatValue <= quizmax) {
			 		res=true;
			 	}
			 	else
			 		res=false;
		 		}
		 	
		 }
		 else
			 res=false;
		 
	 }
	 else if(id1=="am"){
		 var regex = /^(\d+(\.\d{1,2})?|[Aa])$/;
		 if (regex.test(value)) {
		 	//res=asspatt.test(value);
		 	if(value.toUpperCase()=="A") res=true;
		 	else
		 		{
		 		var floatValue = parseFloat(value);
			 	if (floatValue <= assmax) {
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
	var inputs = document.querySelectorAll('input[type="text"]');
    var isValid = true;

    inputs.forEach(function(input) {
        if (!input.value.trim().match(/^\d+$/)) {
            isValid = false;
        }
    });

    if (!isValid) {
        alert("Please enter numbers in all text boxes.");
    } else {
    	document.forms['REGISTER'].submit();
    }
    
    
    
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
String type=new String();
String midmax=miscUtil.getFromSession(request, response,"midmax");
String quizmax=miscUtil.getFromSession(request, response,"quizmax");
String assmax=miscUtil.getFromSession(request, response,"quizmax");
if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");
	
	 out.println("<center><h6>"+status+"</h6></center>");
		%>
		 <jsp:include page='./storemarksstatus.jsp' flush="true" />
	    <% 
	 
		 
	 session.removeAttribute("marksinput");
	 session.removeAttribute("invalidmarks");

}
else
{
 subject=miscUtil.getFromSession(request, response,"subject");
ArrayList students=(ArrayList)session.getValue("students");
SubjectDB subdb=new SubjectDB();

ArrayList mapids=(ArrayList)session.getValue("mapids");
String sem=session.getValue("sem").toString();
String branch=session.getValue("branch").toString();
type=session.getValue("midno").toString();
String section=session.getValue("section").toString();

title=miscUtil.getFromSession(request, response, "title");

MidExamDB medb=new MidExamDB();
for(int i=0;i<mapids.size();i++)
{
	MarksRow mr=new MarksRow();
	
	String mapid=mapids.get(i).toString();
	MidExam attempted=medb.mapidSearchinMid(mapid,type);
	String regdno=mapid.substring(0,mapid.indexOf('-'));
	String sname=new StudentDB().getStudentName(regdno);
	String dmbox=new String();
	String qmbox=new String();
	String ambox=new String();
	String atbox=new String();
	String assbox=new String();
	//System.out.println("jsp:"+attempted.getDm());
	if(!attempted.isMidExisted())
	{
		
		 
			 dmbox="<input id=dm"+i+"  type=text maxlength=5 size=3 name="+mapid+"-dm"+type+"></input>";
			 //qmbox="<input id=qm"+i+" type=text maxlength=5 size=3 name="+mapid+"-qm"+type+" ></input>";
			 //ambox="<input id=am"+i+" type=text maxlength=5 size=3 name="+mapid+"-am"+type+" ></input>";
			 //assbox="<input id=as"+i+" type=hidden size=5 maxlength=5 name="+mapid+"-as"+type+" ></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+"-"+type+" value=false></input>";	
		
	
		 
		 
		 
	}
	else
	{
		
			dmbox="<input id=dm"+i+" type=text size=3 maxlength=5 name="+mapid+"-dm"+type+" value="+attempted.getValue(attempted.getDmno())+"></input>";
			 //qmbox="<input id=qm"+i+" type=text size=3 maxlength=5 name="+mapid+"-qm"+type+" value="+attempted.getValue(attempted.getActvtsno())+" ></input>";
			 //ambox="<input id=am"+i+" type=text maxlength=5 size=3 name="+mapid+"-am"+type+" value="+attempted.getValue(attempted.getAsstno()) +" ></input>";
			 //assbox="<input id=as"+i+" type=hidden size=5 maxlength=5 name="+mapid+"-as value="+attempted.getValue(attempted.getAttno())+"></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+"-"+type+" value=true></input>";
		 
		 
		
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	mr.setDmbox(dmbox);
	mr.setQmbox(qmbox);
	mr.setAmbox(ambox);
	mr.setAssbox(assbox);
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
							<input type=hidden id="midmax" value='<%=midmax %>'></input>
							<input type=hidden id="quizmax" value='<%=quizmax %>'></input>
							<input type=hidden id="assmax" value='<%=assmax %>'></input>
							
							<TR>
							    <TD COLSPAN="6" ALIGN="center"><h6><b> Student List</b></h6></TD>
							</TR>
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap><font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<th><font size=1>Marks (<%=midmax %>)</font>
							
							
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
