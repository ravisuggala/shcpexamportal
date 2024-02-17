
<head>
<style>
input:focus {
  background-color: blue;
  color: white;
}
</style>
<script language="javascript" src="./JS/FormChek.js"></script>
<script type="text/javascript" src="./JS/jquery-1.4.2.min.js">  </script>

<script type="text/javascript">
        $(function() {
            $('input:text:first').focus();
            var $inp = $('input:text');
            $inp.bind('keydown', function(e) {
                //var key = (e.keyCode ? e.keyCode : e.charCode);
                var key = e.which;
                if (key == 13) {
                	if(!validateMarks(this))
                	
                     {
                    e.preventDefault();
                    var nxtIdx = $inp.index(this) + 1;
                    $(":input:text:eq(" + nxtIdx + ")").focus();
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
	 
	 var id=field.id;
	 var id1=id.substr(0,4);
	
	 var attpatt = new RegExp("^(0|1|2|3)$");
	 var asspatt = new RegExp("^([0-5]|0\.5|1\.5|2\.5|3\.5|4\.5)$");
	 var testpatt = new RegExp("^([0-9]|0\.5|1\.5|2\.5|3\.5|4\.5|5\.5|6\.5|7\.5|8\.5|9\.5|10|A|a)$");
	 
	 var recpatt2 = /^(0|1|2|3|4|5|6|7)$/g;
	 var recpatt1 = /^(0\.\d{1,2}|1\.\d{1,2}|2\.\d{1,2}|3\.\d{1,2}|4\.\d{1,2}|5\.\d{1,2}|6\.\d{1,2})$/g;
	 
	 
	 
	 if(id1=="attd")
		 {
		 value=parseInt(value);
		 	if(value<conducted) res=true;
		 	else res=false;
		 }
	 else if(id1=="test")
			 res=testpatt.test(value);
		 else if(id1=="asst")
			 {
			 res1=recpatt1.test(value);
			  res2=recpatt2.test(value);
			 res=res1||res2;
			 
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
String midno=new String();
String conducted="";
if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");
     session.removeAttribute("marksinput");
	 
	
	 out.println("<center><h6>"+status+"</h6></center>");
		%>
		 <jsp:include page='./storeinternalmarksstatus.jsp' flush="true" />
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
//midno=session.getValue("midno").toString();
String section=session.getValue("section").toString();


title=miscUtil.getFromSession(request, response, "title");

MidExamDB medb=new MidExamDB();
for(int i=0;i<mapids.size();i++)
{
	MarksRow mr=new MarksRow();
	
	String mapid=mapids.get(i).toString();
	MidExam attempted=medb.findMapidForInternal(mapid);
	String regdno=mapid.substring(0,mapid.indexOf('-'));
	String sname=new StudentDB().getStudentName(regdno);
	
	String attbox=new String();
	String atbox=new String ();
	String test1box=new String();
	String test2box=new String();
	String test3box=new String();
	String test4box=new String();
	String asstbox=new String();
	
	//System.out.println("jsp:"+attempted.getDm());
	if(attempted.isMidExisted())
	{
		
		asstbox="<input id=asst"+i+" type=text size=3 maxlength=5 name="+mapid+"-asst value="+attempted.getActvts() +"></input>";
		
		 
		 atbox="<input type=hidden size=3 name=h"+mapid+"-internal value=true></input>";
			 
	}
	else
	{
		
		asstbox="<input id=asst"+i+" type=text size=3 maxlength=5 name="+mapid+"-asst ></input>";
			
		 atbox="<input type=hidden size=3 name=h"+mapid+"-internal value=false></input>";
			
		
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	
	mr.setAssbox(asstbox);
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
							
							
							
							<tr>
							<th class=label><font size=1>Sl.No</font>
							<th class=label nowrap><font size=1>Name of the Student</font>
							<th class=label><font size=1>Regd.No</font>
							<th class=label nowrap><font size=1>Daily Assessment Marks<br>(7)</font>
							
							<%
							
							for(int i=0;i<marksrows.size();i++)
							{
								MarksRow mr=(MarksRow)marksrows.get(i);					
							%>
							<tr>
							<td align=right><%=mr.getSlno() %>
							<td NOWRAP><%=mr.getName() %>
							<td align=center><%=mr.getRegdno() %>
	
							<td align=center><%=mr.getAssbox() %>
							<%=mr.getHidden() %>
							</tr>
							<%} %>
							<tr>
							<TD colspan=9 align="center">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "internalevmarks">
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
