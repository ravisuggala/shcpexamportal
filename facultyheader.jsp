<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "java.util.*,dao.*" %>
<html>
	<head>
		<title>SHCP---Examination Portal</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
		<link rel="stylesheet" href="./CSS/styles.css" />
		<style media="all" type="text/css">@import "./menu/menu_style.css";</style>
	<style>
	<style>
#nav {
list-style:none inside;
margin:0;
padding:0;
text-align:center;
}
#nav li {
display:block;
position:relative;
float:left;
background: #24af15; /* menu background color */
}
#nav li a {
display:block;
padding:0;
text-decoration:none;
width:200px; /* this is the width of the menu items */
line-height:35px; /* this is the hieght of the menu items */
color:#ffffff; /* list item font color */
}
#nav li li a {font-size:90%;} /* smaller font size for sub menu items */
#nav li:hover {background:#003f20;} /* highlights current hovered list item and the parent list items when hovering over sub menues */
#nav ul {
position:absolute;
padding:0;
left:0;
display:none; /* hides sublists */
}
#nav li:hover ul ul {display:none;} /* hides sub-sublists */
#nav li:hover ul {display:block;} /* shows sublist on hover */
#nav li li:hover ul {
display:block; /* shows sub-sublist on hover */
margin-left:200px; /* this should be the same width as the parent list item */
margin-top:-35px; /* aligns top of sub menu with top of list item */
}
	</style>	
		
	<script src="JS/jquery-1.4.2.min.js"></script>
	<script language="javascript">
	$(document).ready(function () {
		var resultData=["","B.Pharmacy","M.Pharmacy","Pharm.D"]
		 var myselect = $('<select>');
	     $.each(resultData, function(index, key) {
		     myselect.append( $('<option></option>').val(key).html(key) );
	       });
	      $('#degree').html(myselect.html());
	      
	    $("#degree").change(function () {
	        var val = $(this).val();
	        if (val == "M.Pharmacy") {
		           $("#branch").html("<option></option><option value='Pharmaceutics'>Pharmaceutics</option><option value='Regulatory Affairs'>Regulatory Affairs</option><option value='Pharmaceutical Chemistry'>Pharmaceutical Chemistry</option><option value='Pharmaceutical Analysis'>Pharmaceutical Analysis</option><option value='Pharmacology'>Pharmacology</option><option value='Pharmaceutical Quality Assurance'>Pharmaceutical Quality Assurance</option>");
		        }
		        if (val == "B.Pharmacy") {
			           $("#branch").html("<option></option><option value='B.Pharmacy'>B.Pharmacy</option>");
			        }
		        if (val == "Pharm.D") {
			           $("#branch").html("<option></option><option value='Pharm.D'>Pharm.D</option>");
			 }
	    });
	});

	
	function selectOption(opt)
	{
		document.forms[0].option.value=opt;
		document.forms[0].submit();
		
	}
	function repwin()
	{
		
		document.REGISTER.submit();
		
	}
	function printtable()
	{
		var printContent = document.getElementById("centre");

		var windowUrl = 'about:blank';
		var num;

		var uniqueName = new Date(); 
		var windowName = 'Print' + uniqueName.getTime();
		var printWindow = window.open(num, windowName, 'left=50,top=50,width=800,height=900');

		printWindow.document.write(printContent.innerHTML);

		printWindow.document.close();

		printWindow.focus();

		printWindow.print();

		

		 
	}

	function tabChange(i) {
	      for ( var j = 1; j <= 3; j++) {
	           if (i == j) {
	                document.getElementById("Page" + j).style.display = "block";
	                document.getElementById("Page" + j).className = "box";
	                document.getElementById("Tab" + j).className = "tabSelect";
	           } else {
	                document.getElementById("Page" + j).style.display = "none";
	                document.getElementById("Tab" + j).className = "tab";
	                
	           }
	      }
	}
		
	function entrytabChange(i) {
	      for ( var j = 1; j <= 2; j++) {
	           if (i == j) {
	                document.getElementById("Page" + j).style.display = "block";
	                document.getElementById("Page" + j).className = "box";
	                document.getElementById("Tab" + j).className = "tabSelect";
	           } else {
	                document.getElementById("Page" + j).style.display = "none";
	                document.getElementById("Tab" + j).className = "tab";
	                
	           }
	      }
	}
	</script>
	
	</head>
	<body>
	
	<div id="conteneur">
		  		  <div id="header"><img src="./imgs/one.jpg" width=100% height=150 align=left></div>
	<%
User usr=(User)session.getAttribute("LoginRecord");
%>
<p align=left><font face="Lucida Grande" size=2 color=green>Logged User&nbsp;:&nbsp;<%=usr.getUname() %></font></p>

		  

<ul id="nav">

<li><a href="#">&nbsp;&nbsp;&nbsp;Marks Entry&nbsp;&nbsp;&nbsp;</a>
<ul>
<li> <a href="#" > B.Pharmacy</a>
<ul>

	<li> <a href="./midStep1f.jsp"> Mid Marks</a></li>
	<li> <a href="./labstep1f.jsp"> Lab Marks</a></li>
	<!-- <li><a href="./internalStep1f.jsp">Internal Evaluation Marks</a> 
	<li> <a href="./attendance1f.jsp"> Attendance</a></li>
	<li> <a href="./acaactmarks1f.jsp"> Academic Activities</a></li>
	<li> <a href="./assmarks1f.jsp"> Assignment Marks</a></li>
	<li> <a href="./labstep1f.jsp"> Lab Marks</a></li>
	<li> <a href="./frezass1f.jsp"> Freez Continues Assessment Marks</a></li>-->
	
	
</ul>
</li>
<li> <a href="#" > M.Pharmacy</a>
<ul>

	<li> <a href="./midStep1f.jsp"> Mid Marks</a></li>
	<!-- <li><a href="./internalStep1f.jsp">Internal Evaluation Marks</a> -->
	<!--<li> <a href="./attendance1f.jsp"> Attendance</a></li>
	<li> <a href="./labstep1f.jsp"> Lab Marks</a></li>-->
	
	
	
</ul>
</li>
<li> <a href="#" > Pharm.D</a>
<ul>

	<li> <a href="./midStep1f.jsp"> Mid Marks</a></li>
	<!-- <li><a href="./internalStep1f.jsp">Internal Evaluation Marks</a> -->
	<li> <a href="./attendance1f.jsp"> Attendance</a></li>
	<li> <a href="./internalStep1f.jsp"> Assessment Marks</a></li>
	<li> <a href="./labstep1f.jsp"> Lab Marks</a></li>
	
	
	
</ul>
</li>

</ul>

</li>
	
<li><a href="" target="_self" >Reports</a> 
	<ul>
	<li> <a href="./midreportfaculty.jsp"> Mid Marks</a></li>
	<li> <a href="./intrassreportfaculty.jsp"> Internal Assessment Marks</a></li>
	<!--  <li> <a href="./labreportfaculty.jsp"> Lab Marks</a></li>-->
	<li> <a href="./grandmidreportfaculty.jsp"> Consolidated Marks</a></li>
	<!-- <li><a href="" target="_self" >Excel Reports</a>
	<ul>
		<li> <a href="./midexcelparam1.jsp">Mid Marks</a></li>
		<li> <a href="./labexcelparam1.jsp"> Lab Marks</a></li>
	
	</ul>
	</li> -->
	</ul>
 </li>


<li><a href="" target="_self" >Edit</a> 
<ul>
	<li> <a href="./changepass.jsp"> Change Password</a></li>
</ul>
</li>
<li><a href="#" onClick=selectOption("logout")>&nbsp;&nbsp;&nbsp;Logout&nbsp;&nbsp;&nbsp;</a> </li>
</ul>

<br></br><br></br>


<form name=optionform action="./ActionServlet" method="post">
<input type=hidden name="option"></input>
</form>		


