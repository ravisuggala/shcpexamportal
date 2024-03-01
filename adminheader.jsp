<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "java.util.*,dao.*" %>
<html>
	<head>
		<title>SHCP---Examination Portal</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
		<link rel="stylesheet" href="./CSS/styles.css" />
		<style media="all" type="text/css">@import "./menu/menu-style.css";</style>
		
		
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
	function facultytabChange(i) {
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
	
	
	</script>
	
	</head>
	<body>
	<div id="conteneur">
		  		  <div id="header"><center><img src="./imgs/one.jpg" width=80% height=120 align=center></center></div>
		  		  <br></br>
<%
User usr=(User)session.getAttribute("LoginRecord");
%>
<p align=left><font face="Lucida Grande" size=2 color=green>Logged User&nbsp;:&nbsp;<%=usr.getUname() %></font></p>
		  
		  

<nav>
<ul>

<li><a href="" target="_self" >New</a> 
<ul>
	<li> <a href="./importstudents.jsp" > Students</a></li>
	<li> <a href="./FacultyEntry.jsp" > Faculty</a></li>
	<li> <a href="#" > Subjects</a>
	<ul>
		<li> <a href="./importsubjects.jsp" > General Subjects</a></li>
		  <li> <a href="./importncsubjects.jsp" > Non-Credit Subjects</a></li>
		</ul>
	
	</li>
	<li> <a href="./creditsumdata.jsp" > Total Credits Data</a></li>
	
	<li> <a href="#" > Subjects Mapping</a>
		<ul>
		<li> <a href="#" onClick=selectOption('mapsub')> Common Subjects</a></li>
		<li> <a href="#" onClick=selectOption('mapelective')> Elective Subjects</a></li>
		<li> <a href="./bp8mapelective1.jsp" > VIII Sem Elective Subjects</a></li>
		<li> <a href="./importmappings1.jsp"> Upload Mapping Sheet</a></li>
		</ul>
	</li>
	<li> <a href="#" > Faculty Mapping</a>
		<ul>
		<li> <a href="./facultymap1.jsp" > New</a></li>
		<li> <a href="./facultymapupdate1.jsp" > Update</a></li>
		<li> <a href="./facultymapdelete1.jsp" > Delete</a></li>
		</ul>
	</li>
	
</ul>
</li>

<li><a href="" target="_self" >Edit</a> 
<ul>
	<li> <a href="./profileparams.jsp"> Student Profile</a></li>
	<li> <a href="./promotionparam1.jsp"> Student Promotion</a></li>
	<li> <a href="./setay.jsp"> Set Academic Year</a></li>
	<li> <a href="./readmitparam1.jsp"> Student ReAdmission</a></li>
	<li> <a href="./setregulation.jsp"> Set Regulation</a></li>
	<li> <a href="./setresultsdate.jsp">Results Declaration Date</a></li>
	<li> <a href=""> Course Completion</a>
		<ul>
		<li> <a href="./crscomplete1.jsp" > Entry</a></li>
		<li> <a href="./editcrscomplete1.jsp" >Edit</a></li>
		</ul>
	</li>
	
	<li> <a href="#"> Delete</a>
	
	<ul>
		<li> <a href="delmids.jsp" > Mids</a></li>
		<li> <a href="delmapparams.jsp" >Map Subjects</a></li>
		<li> <a href="delstparams.jsp" >Students</a></li>
		<li> <a href="./delregistration1.jsp">Exam Registration</a></li>
		
		
		</ul>
	
	
	
	</li>
	
</ul>
</li>


<li><a href="" target="_self" >Examinations</a>
<ul>
	<li> <a href="#" > Internal Examinations</a>
	<ul>
		<li><a href="#">Marks Entry</a>
		<ul>
<li> <a href="#" > B.Pharmacy</a>
<ul>

				<li> <a href="#" onClick=selectOption("mid")>Mid Marks</a></li>
				<li> <a href="./auditcrsMarksStep1.jsp">Audit Course Marks</a></li>
				<!--<li> <a href="./attendancemarks1.jsp">Attendance Marks</a></li>
				<li> <a href="./attendance1.jsp">Attended Classes</a></li>
				<li> <a href="./acaactmarks1.jsp">Academic Activity Marks</a></li>
				<li> <a href="./assmarks1.jsp">Assignment Marks</a></li>
				  <li> <a href="./LabStep1.jsp">Lab Marks</a></li>
				<li> <a href="./ps3Step1.jsp">Practice School-III Marks</a></li>-->
				<li><a href="./freezmarksparams.jsp" > Freez Marks</a>
				
				</li>
	
	
</ul>
</li>
<li> <a href="#" > M.Pharmacy</a>
<ul>

	<li> <a href="./midStep1f.jsp"> Mid Marks</a></li>
	<!-- <li><a href="./internalStep1f.jsp">Internal Evaluation Marks</a> -->
	<li> <a href="./attendance1f.jsp"> Attendance</a></li>
	<li> <a href="./labstep1f.jsp"> Lab Marks</a></li>
	
	
	
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
		<li><a href="./freezmarksparams.jsp">Freeze Mid Marks</a></li>
		
	</ul>
	</li>
	<li> <a href="#"> External Examinations</a>
	<ul>
	<li><a href="#" >Generate Exam Applications</a>
			<ul>
				<li> <a href="./examapplication1.jsp">Regular</a></li>
				<li> <a href="./supplyexamapplication1.jsp">Supplementary</a></li>
	
			</ul>	
	</li>
		<li><a href="./examcreation.jsp" >Exam Creation</a></li>
		<!--  <li><a href="#">Student Registration</a>
			<ul>
				<li> <a href="./examregistration1.jsp">Regular</a></li>
				<li> <a href="./revregistration1.jsp">Revaluation</a></li>
				<li> <a href="./supplyregistration1.jsp">Supplementary</a></li>
	
				
			</ul>
			</li> -->
		<li><a href="#">Exam TimeTable</a>
		<ul>
				<li> <a href="./examtimetableparams1.jsp">General</a></li>
	
				
			</ul>
		
		
		</li>
		<li><a href="#">Process Results</a>	
		<ul>
			<li><a href="#">B.Pharmacy</a>
				<ul>
				<li> <a href="#">Marks Entry</a>
				<ul>
					<li> <a href="./externalmarksparam1.jsp">Upload Marks</a></li>
					<li> <a href="./regexternalStep1.jsp">Theory</a></li>
					<li> <a href="./reglabStep1.jsp">Lab</a></li>
					<li> <a href="./regps3Step1.jsp">Practice School-III</a></li>
					
				</ul>
			   </li>
			   <li> <a href="bpgradecalcStep1.jsp">Grade Calculation</a></li>
			   <li> <a href="bpgraftgradesStep1.jsp">Grafting Grades</a></li>
		     </ul>
		 </li>
			<li><a href="#">M.Pharmacy</a>
				<ul>
				<li> <a href="#">Marks Entry</a>
				<ul>
				<li> <a href="./externalmarksparam1.jsp">Upload Marks</a></li>
					<li> <a href="./mpexternalStep1.jsp">Theory</a></li>
					<li> <a href="./mpexternallabStep1.jsp">Lab</a></li>
					<li> <a href="./mpseminarStep1.jsp">Seminar/Colloquium</a></li>
					<li> <a href="./mpvivaStep1.jsp">Viva Marks</a></li>
					<li> <a href="./mp50marksStep1.jsp">50 Marks Input</a></li>
					<li> <a href="./mp200marksStep1.jsp">200 Marks Input</a></li>
					<li> <a href="./mp275marksStep1.jsp">275 Marks Input</a></li>
					<li> <a href="./mpccaStep1.jsp">Co-curricular Activity Credits</a></li>
					
					
				</ul>
			   </li>
			   <li> <a href="mpgradecalcStep1.jsp">Grade Calculation</a></li>
			   <li> <a href="mpgraftgradesStep1.jsp">Grafting Grades</a></li>
		     </ul>
		 </li>
		 <li><a href="#">Pharm.D</a>
				<ul>
				<li> <a href="#">Marks Entry</a>
				<ul>
					<li> <a href="./pdregexternalStep1.jsp">Theory</a></li>
					<li> <a href="./pdreglabStep1.jsp">Lab</a></li>
				</ul>
			   </li>
			   <li> <a href="pdgradecalcStep1.jsp">Freez Marks</a></li>
			   <li> <a href="pdgraftgradesStep1.jsp">Grafting Grades</a></li>
		     </ul>
		 </li>
				
				<li> <a href="./externalmarksparam1.jsp">General</a></li>
				<li> <a href="./resultscsvupload.jsp">Compare CGPAs</a></li>
				</ul>
		
		</li>
		<li><a href="#">Delete</a>
			<ul>
				<li> <a href="./delregistration1.jsp">Student Registrations</a></li>
				
			</ul>
			</li>
		
	</ul>
	</li>
	
	
</ul>
</li>

<li><a href="" target="_self" >Downloads</a>
<ul>
	<li> <a href="#" > Circulars</a>
		<ul>
		<li> <a href="./notification.jsp" > Exam Notification</a></li>
		<li> <a href="#" > Offer Letters</a>
			<ul>
				<li> <a href="./examinerletterparams.jsp" > Internal Faculty</a></li>
				<li> <a href="./externalletterparams.jsp" > External Faculty</a></li>	
			</ul>
		</li>
		<li> <a href="#" > Time Tables</a>
			<ul>
				<li> <a href="./midtimetableparams.jsp"> Mid Time Table Report</a></li>
				<li> <a href="./labextrnttparams.jsp"> External Lab Time Table</a></li>
				<li> <a href="./externalttreport1.jsp" > External Theory TimeTable</a></li>	
			</ul>
		</li>
		<li> <a href="#" > Invigilations</a>
			<ul>
				<li> <a href="./midinvigparams.jsp"> Mid Invigilation Report</a></li>
				<li> <a href="./externalinvigparams.jsp"> External Invigilations</a></li>
			</ul>
		</li>	
		<li> <a href="./labexamfacultyparams.jsp" > Lab Exam Faculty List</a></li>
		<li> <a href="./rembill1.jsp" > Remuneration Bill</a></li>
		
		</ul>
	</li>


	<li> <a href="#" > Internal Examinations</a>
		<ul>
		<li> <a href="#" onClick=selectOption("internal")> Subject wise</a></li>
		<li> <a href="#" onClick=selectOption("cmidmarks")> Consolidated Report</a></li>

		<li> <a href="./datasheetparams.jsp"> Internal Marks Data Sheet</a></li>
		<li> <a href="./middatasheetparams.jsp"> Mid Marks Data Sheet</a></li>
		</ul>
	</li>
	<li> <a href="#" > External Examinations</a>
		<ul>
			<li><a href="#"> Registrations</a>
			<ul>
				<li> <a href="./downloadregistration1.jsp">Regular</a></li>
				<li> <a href="./revdownloadregistration1.jsp">Revaluation</a></li>
				<li> <a href="./downloadregistration1.jsp">Supplementary</a></li>
				<li> <a href="./downloadregistration1.jsp">Specal Theory</a></li>
				
			</ul>
			</li>
			<li><a href="./hallticketsparams1.jsp"> Halltickets</a></li>
			<li><a href="./mpevaluationsheetparams1.jsp"> M.Pharm Evaluations</a></li>
			<li><a href="./bpevaluationsheetparams1.jsp"> B.Pharm Evaluations</a></li>
			<li><a href="./bpevaluationsheetparams1.jsp"> Pharm.D Evaluations</a></li>
			<li><a href="#"> Results</a>
			<ul>
			<li> <a href="webresultsparam1.jsp">Website Sheet</a>
			<li> <a href="#"> Notice Board</a>
			<ul>
				<li> <a href="./nbreportparam1.jsp">Report</a></li>
				<li> <a href="nbresultsparam1.jsp">Sheets</a></li>
				
				
			</ul>
			</li>
			<li> <a href="#"> Aggregate Results</a>
			<ul>
				<li><a href="./overallresultparam1.jsp">OverAll Result</a></li>
				<li> <a href="./externalaggregateparam1.jsp">Examination Wise</a></li>
				<li> <a href="./batchresultsparam1.jsp">Batch Wise</a></li>
				<li> <a href="#"> Failure List</a>
				<ul>
					<li> <a href="./failedlistparam1.jsp">Student wise List</a></li>
					<li> <a href="./failedsubsparam1.jsp">Subject wise Failures</a></li>
				</ul>
				</li>
				<li> <a href="./resultanalysisparams.jsp">Result Analysis</a></li>
				<li> <a href="./meritlistparams.jsp">Merit List</a></li>
				<li> <a href="./markslistparams.jsp">Semester Marks Details</a></li>
			</ul>
		    
			
			</li>
			<li> <a href="#"> Marks Memos PDF</a>
			
			<ul>
				<li> <a href="#">B.Pharmacy</a>
				<ul>
				<li> <a href="./bpmemosreg1.jsp">Regular</a></li>
				<li> <a href="./bpsupplymemoparam1.jsp">Supplementary</a></li>
				</ul>
				
				</li>
				
				<li> <a href="#">M.Pharmacy</a>
				<ul>
				<li> <a href="./bpmemosreg1.jsp">Regular</a></li>
				<li> <a href="./bpsupplymemoparam1.jsp">Supplementary</a></li>
				</ul>
				
				</li>
				<li> <a href="#">Pharm.D</a>
				<ul>
				<li> <a href="./pdmemosreg1.jsp">Regular</a></li>
				<li> <a href="./bpsupplymemoparam1.jsp">Supplementary</a></li>
				</ul>
				
				</li>
				<li> <a href="#">Memos from Excel</a>
				<ul>
				<li> <a href="./bpmarksheetupload.jsp">B.Pharmacy</a></li>
				<li> <a href="./mpmarksheetupload.jsp">M.Pharmacy</a></li>
				<li> <a href="./pdmarksheetupload.jsp">Pharm.D</a></li>
				<li> <a href="./mpmarksheetR16upload.jsp">III/IV M.Pharmacy </a></li>
				</ul>
				
				
				</li>
				
			</ul>
		    </li>
			<li> <a href="#"> Marks Memo Data Sheet</a>
			
			<ul>
				<li> <a href="./exammarksmemoparam1.jsp">Examination Wise</a></li>
				<li> <a href="./marksmemoparam1.jsp">Batch Wise</a></li>
				
			</ul>
		    </li>
			<li><a href="#">  Consolidated Grade Report</a>
			<ul>
				<li> <a href="./regdinput.jsp">Student Wise</a></li>
				<li> <a href="./gradesheetparam1.jsp">Semester Wise</a></li>
				<li> <a href="./ecapsheetparam1.jsp">ECAP Data Sheet</a></li>
			</ul>
		    </li>
			<li> <a href="./mpcmmparams1.jsp"> CMM Data Sheet</a></li>
			<li>  <a href="./totmarksparam1.jsp"> Obtained Total Marks Sheet</a></li>
			<li>  <a href="./smssheetparam1.jsp"> SMS Data Sheet</a></li>
			</ul>
			</li>
			
			
			
		</ul>
		</li>
		<li> <a href="#" > Students </a>
		<ul>
		    <li><a href="#">  List</a>
			<ul>
				<li> <a href="./downloadstlist.jsp">Regular List</a></li>
				<li> <a href="#" onClick=selectOption("detainedlist")>Detained List</a></li>
				<li> <a href="#" onClick=selectOption("transferedlist")>Transferred List</a></li>
				<li> <a href="./downloadreregisterlist.jsp">Re-Registered List</a></li>
				<li> <a href="./downloadreadmittedlist.jsp">Re-Admitted List</a></li>
			</ul>
			</li>
			<li><a href="">  Credits Report</a>
			
			<ul>
				<li> <a href="./externalcreditsparam1.jsp">Total Credits Report</a></li>
				<li> <a href="./semwisecreditsparam1.jsp" >Sem wise Credits Report</a></li>
				<li> <a href="./semwisemarksparam1.jsp" >Sem wise Marks Report</a></li>
				
			</ul>
			</li>
			</ul>
		</li>
	
		<li> <a href="#"> University Sheets</a>
			<ul>
				<li> <a href="#">For PCs</a>
				<ul>
						<li> <a href="./jntuugparam1.jsp">UG</a></li>
						<li> <a href="./jntupgparam1.jsp">PG</a></li>
				</ul>
				</li>
				<li> <a href="./jntuexamsparam1.jsp">For Exams</a></li>
				<li> <a href="./nadsheetparam1.jsp">NAD Sheet</a></li>
				
			</ul>
		
		</li>
		<li> <a href="./downloadsubjectsparam1.jsp"> Subjects</a></li>
		<li> <a href="#"> Exam Fee Portal Sheet</a>
			<ul>
				<li> <a href="./downloadfeesheet1.jsp">Supplementary</a></li>
				<li> <a href="./downloadrevfeesheet1.jsp">Revaluation</a></li>
				
			</ul>
		</li>
	</ul>
</li>
<li><a href="#" >Pre Registrations</a>
<ul>
	<li> <a href="#" >Generate Students list</a> 
	
	<ul>
				<li> <a href="./downloadregfeesheet1.jsp">Regular</a></li>
				<li> <a href="./downloadsupplyfeesheet1.jsp">Supplementary</a></li>
				<li> <a href="./downloadrevfeesheet1.jsp">Revaluation</a></li>
				<li> <a href="./downloadsrvfeesheet1.jsp">Supply Revaluation</a></li>
				<li> <a href="./downloadstfeesheet1.jsp">Special Theory</a></li>
				
	</ul>
		
	</li>
	<li> <a href="#" >Payment Receipt</a> 
	
	<ul>
				<li> <a href="./regularstpayments.jsp">Regular</a></li>
				<li> <a href="./downloadsupplyfeesheet1.jsp">Supplementary</a></li>
				<li> <a href="./downloadrevfeesheet1.jsp">Revaluation</a></li>
				<li> <a href="./downloadsrvfeesheet1.jsp">Supply Revaluation</a></li>
				<li> <a href="./downloadstfeesheet1.jsp">Special Theory</a></li>
				
	</ul>
	<li> <a href="./paymentreport1.jsp" >Download Paid Students</a> </li>
	
	
	
	<li> <a href="./examregistration1.jsp"> Final Students Registration</a>	</li>
	<li> <a href="./deletepaymentsparams.jsp"> Delete PreRegistrations</a>	</li>
	
</ul>
</li>

<li><a href="#" >General</a>
<ul>
	<li> <a href="./changepass.jsp" >Change Password</a> </li>
	<li> <a href="./createuser.jsp" >User Creation</a> </li>
	<li> <a href="#"> Data Recovery</a>
			<ul>
				<li> <a href="./backupprogress.jsp" >BackUp</a> </li>
				<li> <a href="#" >Restore</a> 
				<ul>
					<li> <a href="./restoreprogress.jsp" >From DB</a> </li>
					<li> <a href="./sqlfileparam.jsp" >From File</a> </li>
				</ul>
				
				</li>
				
			</ul>
	</li>
	
</ul>
</li>


<li><a href="#" onClick=selectOption("logout")>Logout   </a>
</li>

</ul>

</nav>

<form name=optionform action="./ActionServlet" method="post">
<input type=hidden name="option"></input>
</form>		


