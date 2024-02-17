<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="dao.User,dao.StudentDB,java.util.ArrayList"%>
<%
	String header = new String();
	User ur = (User) session.getAttribute("LoginRecord");
	if (ur == null) {
%>
<jsp:forward page="./index.jsp"></jsp:forward>
<%
	}
	if (ur.getStatus().equals("admin"))
		header = "./adminheader.jsp";
	else if (ur.getStatus().equals("clerk"))
		header = "./mainmenuheader.jsp";
	else if (ur.getStatus().equals("ACE"))
		header = "./aceheader.jsp";

	ArrayList regs = new StudentDB().getRegulations();
%>
<jsp:include page='<%=header%>' flush="true" />


<html>
<head>
<link rel="stylesheet" type="text/css" href="CSS/StyleCalender.css">

<script type="text/javascript" language="javascript" src="JS/CalendarControl.js"></script>

<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div id="centre">
	<form method="post" action="./notificationSubmit" target="_blank">
		<center>
			<h2>Examination Notification Report</h2>
			<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="400">

				<tr>
					<td align=right> Degree:</td>
					<td><select size="1" name="degree" id="degree">
							<option></option>
							<option value="B.Pharmacy">B.PHARMACY</option>
							<option value="M.Pharmacy">M.PHARMACY</option>
					</select></td>
				</tr>

				<tr>
					<td align=right>Semester:</td>
					<td nowrap><input type="checkbox" name="sem" value="I">I</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="II">II</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="III">III</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="IV">IV</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="V">V</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="VI">VI</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="VII">VII</input>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sem" value="VIII">VIII</input>&nbsp;&nbsp;&nbsp;
				</tr>
				<tr>
					<td align=right>Academic Year:<br>(yyyy-yyyy)</td>
					<td><input name="from" type="text"></td>
				</tr>
				<tr>
					<td align=right nowrap>Admitted Batches<br>(Comma seperated years):</td>
					<td><input type="text" name="admit"></td>
				</tr>
				<tr>
					<td align=right>Exam Type:</td>
					<td ><input type="checkbox" name="examType" value="Regular">Regular&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="examType" value="Supplementary">Supplementary&nbsp;&nbsp;&nbsp;&nbsp;
						<br><input type="checkbox" name="examType" value="Regular Revaluation">Regular Revaluation&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="examType" value="Supplementary Revaluation">Supply Revaluation&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						
				</tr>
				<tr>
				<td align=right>Month of Examination:</td>
					<td><input name="month" type="text" id="dpMonthYear" value="" style="width:80px;" />
							<img alt="Month/Year Picker" onclick="showCalendarControl('dpMonthYear');" 
				src="imgs/datepicker.gif" /></td>
				</tr>


				<TR>
					<TD WIDTH="20%" ALIGN="right">Regulation</TD>
					<td WIDTH="10%" ALIGN="left"><select id="reg" name="reg">
							<option value="-">-</option>

							<%
								for (int i = 0; i < regs.size(); i++) {
									String sub = regs.get(i).toString();
							%>
							<option value='<%=sub%>'><%=sub%></option>
							<%
								}
							%>
					</select></td>
				</tr>

				<tr>
					<td align=right>Exam Date with out fine:</td>
					<td><input type="date" name="wofine"></td>
				</tr>
				<tr>
					<td align=right>Exam Date with fine:</td>
					<td><input type="date" name="wfine"></td>
				</tr>
				<tr>
					<td align=right>Date of the Circular:</td>
					<td><input type="date" name="date"></td>
				</tr>
				<tr>
					<td colspan=2><center>
							<input type="submit" value="SUBMIT">
						</center></td>
				</tr>
			</table>
		</center>
	</form>
	</div>
</body>
</html>