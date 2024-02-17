
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
	 

	 var patt = new RegExp("^(a|A|[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9]|100)$");
	 var res = patt.test(value);
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

	
%>

<jsp:include page='<%= header %>' flush="true" />


<%

ArrayList marksrows=new ArrayList();
String status="";
String title="";
if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");

	 out.println("<center><h6>"+status+"</h6></center>");
		 
	 session.removeAttribute("marksinput");


}
else
{
String subject=miscUtil.getFromSession(request, response,"subject");
ArrayList students=(ArrayList)session.getValue("students");
SubjectDB subdb=new SubjectDB();

ArrayList mapids=(ArrayList)session.getValue("mapids");
String sem=session.getValue("sem").toString();
String branch=session.getValue("branch").toString();
String type=session.getValue("type").toString();
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
	String qmbox=new String();
	String ambox=new String();
	String atbox=new String();
	if(attempted==null)
	{
		  if(branch.equals("M.B.A"))
		 {
			 dmbox="<input type=text maxlength=2 size=3 name="+mapid+"-dm"+"></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+" value=false></input>";
		 }
		 else
		 {
			 dmbox="<input type=text maxlength=2 size=3 name="+mapid+"-dm"+"></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+" value=false></input>";	 
		 }
		 
		 
	}
	else
	{
		 if(branch.equals("M.B.A"))
		 {
			 dmbox="<input type=text size=3 maxlength=2 name="+mapid+"-dm"+" value="+attempted.getDm()+"></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+" value=true></input>";
		 }
		else
		{
			dmbox="<input type=text size=3 maxlength=2 name="+mapid+"-dm"+" value="+attempted.getDm()+"></input>";
		    atbox="<input type=hidden size=3 name=h"+mapid+" value=true></input>";
		}
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	mr.setDmbox(dmbox);
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
							
							
							<TR>
							    <TD COLSPAN="6" ALIGN="center"><h6><b> Student List</b></h6></TD>
							</TR>
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap><font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<th><font size=1>Seminar<br>Marks</font>
							
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
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "miniprojectmarks">
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
