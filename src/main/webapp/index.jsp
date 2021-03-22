<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
	int role = 0;
	if (session.getAttribute("role_id") == null) {
		response.sendRedirect("login.jsp");
	}
	else {
		role = ((int) session.getAttribute("role_id"));
	}

	Connection conn = dbConnector.dbConnect();	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	SimpleDateFormat date_formatter = new SimpleDateFormat("yyyy-MM-dd"); 
	SimpleDateFormat time_formatter = new SimpleDateFormat("hh:mm a"); 
	SimpleDateFormat datetime_formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm a"); 
	String today = date_formatter.format(new Date());

%>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />	
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
	<%-- include shared nav bar --%>
	<jsp:include page="\navBar.jsp" />

	<div class="container mt-4">

		<% 
			if (role == 1 || role == 5) {
		%>	
		<!-- Physician Section -->
		<div class="row">
			<div class="col-12 text-center">
				<a class="btn btn-primary" href="lookUpPatient.jsp" role="button">Create New Order</a>
			</div>
		</div>
		<div class="row text-center">
			<div class="col-md-6 mb-4"> 
				<div class="card mt-4">
					<div class="card-header">
						Active Orders
					</div> 
					<div class="card-body"> 
						<table class="table">
							<thead>
								<tr>
										<th scope="col">Order #</th>
										<th scope="col">Patient</th>
										<th scope="col">Stage</th>
								</tr>
							</thead>
							<tbody>
							<% 
								try {
									conn = dbConnector.dbConnect();
									stmt = null;
									rs = null;
									String query = "SELECT `order`.`order_id`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `status`.`name` AS status_name FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` INNER JOIN `status` ON `order`.`status_id` = `status`.`status_id` WHERE `order`.`status_id` in (1,2,3) ORDER BY `order`.`status_id`";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									if (!rs.isBeforeFirst()) {
							%>
								<tr>
									<td colspan="6" class="text-center text-muted">
										No orders
									</td>
								</tr>
							<%
									} else {
										while(rs.next()) {
											String name = rs.getString("first_name");
											if (rs.getString("middle_name") != null) {
												name += " "+rs.getString("middle_name");
											}
											name += " "+rs.getString("last_name");
							%>
								<tr>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
									</td>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
									</td>
									<td>
										<%=rs.getString("status_name") %>
									</td>
								</tr>
							<%      
										}
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
							<tbody>
						</table>
					</div> 
				</div> 
			</div>
			<div class="col-md-6 mb-4"> 
				<div class="card mt-4">
					<div class="card-header">
						Completed Orders
					</div> 
					<div class="card-body"> 
						<table class="table">
							<thead>
								<tr>
										<th scope="col">Order #</th>
										<th scope="col">Patient</th>
										<th scope="col">Completed</th>
								</tr>
							</thead>
							<tbody>
							<% 
								try {
									conn = dbConnector.dbConnect();
									stmt = null;
									rs = null;
									String query = "SELECT `order`.`order_id`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `order`.`date_completed` FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` WHERE `order`.`status_id` = 4 ORDER BY `order`.`status_id`";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									if (!rs.isBeforeFirst()) {
							%>
								<tr>
									<td colspan="6" class="text-center text-muted">
										No orders
									</td>
								</tr>
							<%
									} else {
										while(rs.next()) {
											String name = rs.getString("first_name");
											if (rs.getString("middle_name") != null) {
												name += " "+rs.getString("middle_name");
											}
											name += " "+rs.getString("last_name");
							%>
								<tr>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
									</td>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
									</td>
									<td>
										<%=rs.getDate("date_completed") %>
									</td>
								</tr>
							<%      
										}
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
							<tbody>
						</table>
					</div> 
				</div> 
			</div>
		</div>
		<% 
			}

			if (role == 2 || role == 5) {
		%>
		<!-- Receptionist Section -->
		<div class="row text-center">
			<div class="col-md-6 mb-4"> 
				<div class="card mt-4">
					<div class="card-header">
						Today's Appointments
					</div> 
					<div class="card-body">
						<div class="text-muted small mb-3"><%=today %></div> 
						<table class="table">
							<thead>
								<tr>
										<th scope="col">Order #</th>
										<th scope="col">Patient</th>
										<th scope="col">Time</th>
								</tr>
							</thead>
							<tbody>
								<% 
								try {
									conn = dbConnector.dbConnect();
									stmt = null;
									rs = null;
									String query = "SELECT `order`.`order_id`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `order`.`appointment` FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` WHERE cast(`appointment` as DATE) = ?";
									stmt = conn.prepareStatement(query);
									stmt.setString(1, today);
									rs = stmt.executeQuery();
									if (!rs.isBeforeFirst()) {
							%>
								<tr>
									<td colspan="6" class="text-center text-muted">
										No orders
									</td>
								</tr>
							<%
									} else {
										while(rs.next()) {
											String name = rs.getString("first_name");
											if (rs.getString("middle_name") != null) {
												name += " "+rs.getString("middle_name");
											}
											name += " "+rs.getString("last_name");
							%>
								<tr>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
									</td>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
									</td>
									<td>
										<%=time_formatter.format(rs.getTimestamp("appointment")) %>
									</td>
								</tr>
							<%      
										}
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
							<tbody>
						</table>
					</div> 
				</div> 
			</div>
			<div class="col-md-6 mb-4"> 
				<div class="card mt-4">
					<div class="card-header">
						Unscheduled Appointments
					</div> 
					<div class="card-body">
						<div class="text-muted small mb-3">Click to Schedule</div> 
						<table class="table">
							<thead>
								<tr>
										<th scope="col">Order #</th>
										<th scope="col">Patient</th>
										<th scope="col">Drafted</th>
								</tr>
							</thead>
							<tbody>
							<% 
								try {
									conn = dbConnector.dbConnect();
									stmt = null;
									rs = null;
									String query = "SELECT `order`.`order_id`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `order`.`date_added` FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` WHERE `appointment` IS NULL ";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									if (!rs.isBeforeFirst()) {
							%>
								<tr>
									<td colspan="6" class="text-center text-muted">
										No orders
									</td>
								</tr>
							<%
									} else {
										while(rs.next()) {
											String name = rs.getString("first_name");
											if (rs.getString("middle_name") != null) {
												name += " "+rs.getString("middle_name");
											}
											name += " "+rs.getString("last_name");
							%>
								<tr>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
									</td>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
									</td>
									<td>
										<%=rs.getDate("date_added") %>
									</td>
								</tr>
							<%      
										}
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
							<tbody>
						</table>
					</div> 
				</div> 
			</div>
		</div>
		<% 
			}

			if (role == 3 || role == 5) {
		%>
		<!-- Technicain Section -->
		<div class="row text-center">
			<div class="col">
				<div class="card mt-4">
					<div class="card-header">
						Checked In Patients					
					</div> 
					<table class="table">
						<thead>
							<tr>
									<th scope="col">Order #</th>
									<th scope="col">Patient</th>
									<th scope="col">Visit Reason</th>
									<th scope="col">Imaging</th>
									<th scope="col">Modality</th>
									<th scope="col">Appointment Time</th>
							</tr>
						</thead>
						<tbody>
							<% 
								try {
									conn = dbConnector.dbConnect();
									stmt = null;
									rs = null;
									String query = "SELECT `order`.`order_id`, `order`.`visit_reason`, `order`.`imaging_needed`, `order`.`appointment`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `modality`.`name` as modality_name FROM `order` INNER JOIN `modality` ON `order`.`modality_id` = `modality`.`modality_id` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` WHERE `status_id` = 2";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									if (!rs.isBeforeFirst()) {
							%>
								<tr>
									<td colspan="6" class="text-center text-muted">
										No orders
									</td>
								</tr>
							<%
									} else {
										while(rs.next()) {
											String name = rs.getString("first_name");
											if (rs.getString("middle_name") != null) {
												name += " "+rs.getString("middle_name");
											}
											name += " "+rs.getString("last_name");
							%>
								<tr>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
									</td>
									<td>
										<a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
									</td>
									<td>
										<%=rs.getString("visit_reason") %>
									</td>
									<td>
										<%=rs.getString("imaging_needed") %>
									</td>
									<td>
										<%=rs.getString("modality_name") %>
									</td>
									<td>
										<%=datetime_formatter.format(rs.getTimestamp("appointment")) %>
									</td>
								</tr>
							<%      
										}
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
						<tbody>
					</table>
				</div>
			</div>
		</div>
		<% 
			}

			if (role == 4 || role == 5) {
		%>
		<!-- Radiologist Section -->
		<div class="row text-center">
			<div class="col">
				<div class="card mt-4">
					<div class="card-header">
						Awaiting Analysis					
					</div> 
					<table class="table">
						<thead>
							<tr>
									<th scope="col">Order #</th>
									<th scope="col">Patient</th>
									<th scope="col">Visit Reason</th>
									<th scope="col">Imaging</th>
									<th scope="col">Modality</th>
									<th scope="col">Completed</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="6" class="text-center text-muted">
										No orders
								</td>
							</tr>
						<tbody>
					</table> 
				</div>
			</div>
		</div>
		<% 
			}
		%>

	</div>
	
	<br>
	<br>
</body>
</html>
