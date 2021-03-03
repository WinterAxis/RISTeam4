<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Patient Portal: Add</title>
</head>
<body>
	<form action="addPatient" method="post">
		<table>
			<tr>
				<td>Patient Name</td>
				<td><input type="text" name="patientName"></td>
			</tr>
			
			<tr>
				<td></td>
				<td>Submit</td>
				<td><input type="submit" value="addPatient"></td>
			</tr>
		</table>
	</form>
</body>
</html>