
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
	 
	 var id=field.id;
	 var id1=id.substr(0,2);
	 
	 var patt1 = new RegExp("^(a|A|[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|60)$");
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

	
%>

<jsp:include page='<%= header %>' flush="true" />


<%

ArrayList marksrows=new ArrayList();
String status="";
String title="";
String subject=new String();
String type=new String();
if (session.getAttribute("marksinput")!=null)
{
     status=(String)session.getAttribute("marksinput");
	
	 out.println("<center><h6>"+status+"</h6></center>");
		%>
		 <jsp:include page='./storegtmarksstatus.jsp' flush="true" />
	    <% 
	 
		 
	 session.removeAttribute("marksinput");
	 session.removeAttribute("invalidmarks");

}
else
{

ArrayList students=(ArrayList)session.getValue("students");
SubjectDB subdb=new SubjectDB();

ArrayList mapids=(ArrayList)session.getValue("students");
String sem=session.getValue("sem").toString();
String ay=session.getValue("ay").toString();
String reg=session.getValue("reg").toString();
//type=session.getValue("type").toString();
//String section=session.getValue("section").toString();

title=ay+" "+sem+" Free Electives <br> Grand Test Marks";

MidExamDB medb=new MidExamDB();
for(int i=0;i<mapids.size();i++)
{
	MarksRow mr=new MarksRow();
	
	String mapid=mapids.get(i).toString();
	MidExam attempted=medb.findMapidinGrandTest(mapid);
	String regdno=mapid.substring(0,mapid.indexOf('-'));
	String subcode=mapid.substring(mapid.indexOf('-')+1);
	String subname=subdb.getSubjectTitle(subcode, reg);
	Student st=new StudentDB().getStudent(regdno);
	String sname=st.getName();
	String branch=st.getBranch();
	String section=st.getSection();
	String dmbox=new String();
	String atbox=new String();
	 type="fegt";
	//System.out.println("jsp:"+attempted.getDm());
	if(attempted==null)
	{
		  
			 dmbox="<input id=dm"+i+"  type=text maxlength=2 size=3 name="+mapid+"-dm"+type+"></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+"-"+type+" value=false></input>";	 
		 
		 
		 
	}
	else
	{
		 
			dmbox="<input id=dm"+i+" type=text size=3 maxlength=2 name="+mapid+"-dm"+type+" value="+attempted.getDm()+"></input>";
			// qmbox="<input id=qm"+i+" type=text size=3 maxlength=2 name="+mapid+"-qm"+type+" value="+attempted.getQm()+" ></input>";
			 //ambox="<input id=am"+i+" type=hidden size=3 maxlength=2 name="+mapid+"-am"+type+" value="+attempted.getAm()+" ></input>";
			 atbox="<input type=hidden size=3 name=h"+mapid+"-"+type+" value=true></input>";
		
	}
	
	mr.setSlno((i+1)+"");
	mr.setName(sname);
	mr.setRegdno(regdno);
	mr.setDmbox(dmbox);
	//mr.setQmbox(qmbox);
	//mr.setAmbox(ambox);
	mr.setHidden(atbox);
	mr.setBranch(branch);
	mr.setSection(section);
	mr.setSubject(subname);
	
	marksrows.add(i, mr);
}
}
%>


<html>
	<head>
		<title>SVECW - Examination Portal - Mid Examinations</title>
		
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
							    <TD COLSPAN="7" ALIGN="center"><h6><b> Student List</b></h6></TD>
							</TR>
							<tr>
							<th><font size=1>Sl.No</font>
							<th nowrap><font size=1>Name of the Student</font>
							<th><font size=1>Regd.No</font>
							<th><font size=1>Branch</font>
							<th><font size=1>Section</font>
							<th><font size=1>Subject</font>
							<th><font size=1>Descriptive Marks(60)</font>
							
							<%
							
							for(int i=0;i<marksrows.size();i++)
							{
								MarksRow mr=(MarksRow)marksrows.get(i);					
							%>
							<tr>
							<td align=right><%=mr.getSlno() %>
							<td NOWRAP><%=mr.getName() %>
							<td align=center><%=mr.getRegdno() %>
							<td align=center><%=mr.getBranch() %>
							<td align=center><%=mr.getSection() %>
							<td align=center nowrap><%=mr.getSubject() %>
							<td align=center><%=mr.getDmbox() %>
							<%=mr.getHidden() %>
							</tr>
							<%} %>
							<tr>
							<TD colspan=7 align="center">
							
							<INPUT TYPE=HIDDEN NAME="option" VALUE = "fegtmarks">
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
