<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "java.util.*,dao.*" %>
<html>
	<head>
		<title>SVECW---Examination Portal</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
		<link rel="stylesheet" href="./CSS/styles.css" />
		<style media="all" type="text/css">@import "./menu/menu-style.css";</style>
		
		
				<script src="JS/jquery-1.4.2.min.js"></script>
	<script language="javascript">
	$(document).ready(function () {
	    $("#degree").change(function () {
	        var val = $(this).val();
	        if (val == "M.TECH") {
	           $("#branch").html("<option></option><option value='MT-GI'>MT-GI</option><option value='MT-PE'>MT-PE</option><option value='MT-VLSID'>MT-VLSID</option><option value='MT-CSE'>MT-CSE</option><option value='MT-SE'>MT-SE</option>");
	        }
	        if (val == "B.TECH") {
		           $("#branch").html("<option></option><option value='E.E.E'>E.E.E</option><option value='E.C.E'>E.C.E</option> <option value='C.S.E'>C.S.E</option> <option value='I.T'>I.T</option> <option value='MECH'>MECH</option> <option value='CIVIL'>CIVIL</option><option value='all'>All</option>");
		        }
	        if (val == "M.B.A") {
		           $("#branch").html("<option value='M.B.A'>M.B.A</option>");
		        }
	        if (val == "M.C.A") {
		           $("#branch").html("<option value='M.C.A'>M.C.A</option>");
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
<p align=right><font face="Lucida Grande" size=2 color=green>Logged User:<%=usr.getUname() %></font></p>
<nav>
<ul>

<li><a href="" target="_self" >New</a> 
<ul>
	<li> <a href="#" onClick=selectOption("newst")> Students</a></li>
	<li> <a href="#" onClick=selectOption("newsub")> Subjects</a></li>
	
</ul>
</li>

<li><a href="" target="_self" >Edit</a> 
<ul>
	<li> <a href="./profileparams.jsp"> Student Profile</a></li>
	<li> <a href="./promotionparam1.jsp"> Student Promotion</a></li>
	
</ul>
</li>



<li><a href="" target="_self" >Examinations</a>
<ul>
	<li> <a href="#"> Internal Examinations</a>
	<ul>
				<li> <a href="#" onClick=selectOption("mid")>Mid Marks</a></li>
				<li> <a href="./assignmentStep1.jsp">Assignment Marks</a></li>
				<li> <a href="./LabStep1.jsp">Lab Marks</a></li>
				<li> <a href="#">Grand Test Marks</a>
					<ul>
						<li> <a href="./grandtestStep1.jsp">General Subjects</a></li>
						<li> <a href="./fegtstep1.jsp">Free Electives</a></li>
					</ul>
				
				</li>
			</ul>
	
	</li>
	<li> <a href="#"> External Examinations</a>
	<ul>
	<li><a href="#">Student Registration</a>
			<ul>
				<li> <a href="./examregistration1.jsp">Regular</a></li>
				<li> <a href="./revregistration1.jsp">Revaluation</a></li>
				<li> <a href="./supplyregistration1.jsp">Supplementary</a></li>
			</ul>
	</li>
	</ul>
		</li>
	
</ul>
</li>

<li><a href="" target="_self" >Downloads</a>
<ul>
	<li> <a href="#" > Internal Examinations</a>
		<ul>
		<li> <a href="#" onClick=selectOption("internal")> Subject wise</a></li>
		<li> <a href="#" onClick=selectOption("cmidmarks")> Consolidated Report</a></li>
		</ul>
	</li>
	
	<li> <a href="#" > External Examinations</a>
		<ul>
			<li><a href="downloadexamregs1.jsp"> Registrations</a></li>
		</ul>
	</li>
	<li><a href="#">  Aggregate Grade Report</a>
			<ul>
				<li> <a href="./regdinput.jsp">Student Wise</a></li>
				<li> <a href="./gradesheetparam1.jsp">Semester Wise</a></li>
				
			</ul>
	  </li>
	<li> <a href="#"> Failure List</a>
				<ul>
					<li> <a href="./failedlistparam1.jsp">Student wise List</a></li>
					<li> <a href="./failedsubsparam1.jsp">Subject wise Failures</a></li>
				</ul>
	</li>
</ul>

</li>

<li><a href="#" >General</a>
<ul>
     <li> <a href="./changepass.jsp">Change Password </a> </li>
</ul>

</li>


<li><a href="#" onClick=selectOption("logout")>Logout   </a>
</li>

</ul>

</nav>

<form name=optionform action="./ActionServlet" method="post">
<input type=hidden name="option"></input>
</form>		


