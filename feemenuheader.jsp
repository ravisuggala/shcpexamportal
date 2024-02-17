<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "java.util.*,dao.*" %>
<html>
	<head>
		<title>SVCP---Examination Portal</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
		<link rel="stylesheet" href="./CSS/styles.css" />
		<style media="all" type="text/css">@import "./menu/menu_style.css";</style>
		
		
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
	           $("#branch").html("<option></option><option value='Pharmaceutics'>Pharmaceutics</option><option value='P.R.A'>Pharmaceutical Regulatory Affairs</option><option value='P.C'>Pharmaceutical Chemistry</option><option value='P.A'>Pharmaceutical Analysis</option><option value='Pharmacology'>Pharmacology</option>");
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
<p align=right><font face="Lucida Grande" size=2 color=green>Logged User:<%=usr.getUname() %></font></p>

<div class="menu">

<ul>
<li><a href="./regregistration1.jsp?type=REGULAR" target="_self" >Regular</a></li>
<li><a href="./registration1.jsp?type=SUPPLEMENTARY" target="_self" >Supplementary</a></li>
<li><a href="./registration1.jsp?type=REVALUATION" target="_self" >Revaluation</a></li>
<li><a href="./registration1.jsp?type=SRV" target="_self" >Supply Revaluation</a></li>
<li><a href="./registration1.jsp?type=ST" target="_self" >Special Theory</a></li>


<li><a href="#"  >File</a>
	<ul>
	<li><a href="./downloadrevapplication.jsp" target="_self" >Revaluation Application</a></li>
	<!--  <li><a href="./printreceipt1.jsp" target="_self" >Print Receipt</a></li>-->
	<li><a href="./delreg1.jsp" target="_self" >Delete Registration</a></li>
	</ul>

</li>
<li><a href="#" onClick=selectOption("logout")>Logout   </a>
</li> 
	
</ul>

</div>


<form name=optionform action="./ActionServlet" method="post">
<input type=hidden name="option"></input>
</form>		


