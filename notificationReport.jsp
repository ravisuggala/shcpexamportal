<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
 <div align="right"><button onClick="window.print()"><img alt="No Image" height="25px" width="25px" src="./imgs/print.png" ></button> </div>

<table align="center" border="1" style="border-collapse: collapse;height: 600 " height="1000" width="750">
	<tr>
		<td height=100>
			<center>
				<img src="./imgs/vishnu.png" height="100px" width="100px"><br>
				<h1>Shri Vishnu College of Pharmacy : Bhimavaram<br>
				(Autonomous)</h1>
			</center>
		</td>
	</tr>
	<tr>
		<td>
			<table align="center" style="border-collapse: collapse;border-color: black;">
				<tr>
					<td>				
						<center><%=request.getAttribute("sem")%></center>
					</td>
					
				</tr>
				<tr>
					<td>
						<center><%=request.getAttribute("regulation")%></center>
						
					</td>
				</tr>
				<tr>
					<td>
						<font size="4">
							  <center>(For <%= request.getAttribute("admit")+" " %> Admitted Batches Only)</center>
						</font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table align="center" style="border-collapse: collapse;border-color: black" height="50" width="200" border="1" >
				<tr><br>
					<td><center>
					<%=request.getAttribute("month")%>
						</center>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<font size="4"><p>
				Candidates Appearing for these examinations are informed that the applications will be accepted  as per the following Schedule:
			</p></font>
			<table align="center" border="border-collapse" style="border-collapse: collapse">
				<tr>
					<td><font size="4">Examination  registration</font></td>
					<td><font size="4"> Last date</td></font>
				</tr>
				<tr>
					<td><font size="4">Without Late Fee</font></td>
					<td><font size="4"><%=request.getAttribute("wofine") %></font></td>
				</tr>
				<tr>
					<td><font size="4">With Late Fee of Rs.100/- per day</font></td>
					<td><font size="4"><%=request.getAttribute("wfine") %></font></td>
				</tr>
			</table>
			<p>
				<font size="4">Note:  The Fee details can be obtained from the office.</font>                                                                                      
			</p><br>
			DATE: <%=request.getAttribute("date") %><br><br><br>
			<table  align="center" width="100%"><tr>
				<td width="30%" height="30%">
					
					Controller of Examinations
				</td>
				<td width="30%" height="30%" align="center">
				
					Principal
				</td>
				<td width="30%" height="30%" align="right"><br><br>
					Director
				</td>
			</tr></table>
			
		</td>
	</tr>
</table>
</body>
</html>
