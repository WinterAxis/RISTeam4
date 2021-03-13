<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		</div>

		<!-- Receptionist Section -->
		<div class="row text-center">
			<div class="col-md-6 mb-4"> 
				<div class="card mt-4">
					<div class="card-header">
						Today's Appointments
					</div> 
					<div class="card-body">
						<div class="text-muted small mb-3">Todays Date</div> 
						<table class="table">
							<thead>
								<tr>
										<th scope="col">Order #</th>
										<th scope="col">Patient</th>
										<th scope="col">Time</th>
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
		</div>

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


	</div>
	
	<br>
	<br>
</body>
</html>
