
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<head>

<style>
a.set1
{
font-size: 15px;
}
		a.set1:link {color: #9922aa;}
		a.set1:visited {color: #666699;}
		a.set1:hover {font-size:20; font-weight:bold; color: red;  background-color: #ccc;}
		a.set1:active {color: #336699;}"


</style>


</head>

<br></br>


<center>
<h3>
	
<br></br>
<FORM NAME = REGISTER METHOD = POST ACTION = "./grandtestStep1session.jsp">
		<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "storemarks">
	</FORM>

<FORM NAME = REGISTER1 METHOD = POST ACTION = "./grandtestStep1.jsp">
		<INPUT TYPE=HIDDEN NAME="hiddenActionType" VALUE = "storemarks">
	</FORM>

</h3>							
<font face=tahoma size=2><a  class=set1 href="#" onClick="document.REGISTER.submit()">
Click Here for another subject in the same branch</a></font><br></br>

<font face=tahoma size=2><a class=set1 href="#" onClick="document.REGISTER1.submit()" >Click Here for another Branch</a></font><br></br>


</center>	
	
<br></br>
<br></br>
