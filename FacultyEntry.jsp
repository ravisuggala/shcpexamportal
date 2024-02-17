<%@ include file="./adminheader.jsp" %>

	

<body>

	
<h3><center>Faculty Entry Form</center></h3>

<center>
<div id="centre">
		  
<div>
       <a id="Tab1" href="javascript:facultytabChange(1)" class="tab">Import From Excel</a>
       <a id="Tab2" href="javascript:facultytabChange(2)" class="tab">Manual Entry</a>
       <a id="Tab4" href="javascript:facultytabChange(3)" class="tab">Delete Faculty Data</a>
</div>
<div id="Page1" class="box" style="display: none;">
     <%@ include file="./ImportFacultyForm.jsp" %>
</div>
<div id="Page2" style="display: none;">
     <%@ include file="./ManualFacultyForm.jsp" %>
</div>

<div id="Page3" style="display: none;">
     <%@ include file="./fdelete.jsp" %>
</div>


</div>

</center>
			    					   

		<div id="pied"></div>
	</div>
	</body>
</html>








		