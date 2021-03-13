<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>

<%-- Insert On Post --%>
<% 
  
  String fName = "";
  String mName = "";
  String lName = "";
  Date DOB = null;
  String phone_number = "";
  String email = "";
  boolean xraydye = false;
  boolean mridye = false;
  boolean asthma = false;
  boolean latex = false;
  String pnotes = "";

  int pid = 0;
  String visit_reason = "";
  String imaging_needed = "";
  int mid = 0;
  String modality = "";
  String onotes = ""; 

  Connection conn = dbConnector.dbConnect();	
  PreparedStatement stmt = null;
  ResultSet rs = null;
  if (request.getParameter("oid") != null) {
    try {
      String query = "SELECT `patient_id`, `modality_id`, `visit_reason`, `imaging_needed`, `notes` FROM `order` WHERE order_id = ?";
      stmt = conn.prepareStatement(query);
      stmt.setString(1, request.getParameter("oid"));
      rs = stmt.executeQuery();
      if (!rs.isBeforeFirst()) {
      } else {
        while(rs.next()) { 
          pid = rs.getInt("patient_id");
          mid = rs.getInt("modality_id");
          visit_reason = rs.getString("visit_reason");
          imaging_needed = rs.getString("imaging_needed");
          onotes = rs.getString("notes");
        }
      }
      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }

    try {
      conn = dbConnector.dbConnect();	
      stmt = null;
      rs = null;
      String query = "SELECT * FROM patient WHERE patient_id = ?";
      stmt = conn.prepareStatement(query);
      stmt.setInt(1, pid);
      rs = stmt.executeQuery();
      if (!rs.isBeforeFirst()) {
      } else {
        while(rs.next()) { 
          fName = rs.getString("first_name");
          mName = rs.getString("middle_name");
          lName = rs.getString("last_name");
          DOB = rs.getDate("birthday");
          String[] temp = rs.getString("phone_number").split(" "); 
          phone_number = "("+temp[0]+") "+temp[1]+"-"+temp[2];
          email = rs.getString("email");
          xraydye = rs.getBoolean("has_allergy_xraydye");
          mridye = rs.getBoolean("has_allergy_mridye");
          asthma = rs.getBoolean("has_allergy_asthma");
          latex = rs.getBoolean("has_allergy_latex");
          pnotes = rs.getString("notes");
        }
      }
      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }

    try {
      conn = dbConnector.dbConnect();	
      stmt = null;
      rs = null;
      String query = "SELECT * FROM modality WHERE modality_id = ?";
      stmt = conn.prepareStatement(query);
      stmt.setInt(1, mid);
      rs = stmt.executeQuery();
      if (!rs.isBeforeFirst()) {
      } else {
        while(rs.next()) { 
          modality = rs.getString("name");
        }
      }
      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
%>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />		
	<meta charset="UTF-8">
	<title>Order Portal: Add</title>
</head>
<body>
  <%-- include shared nav bar --%>
	<jsp:include page="\navBar.jsp" />
	
	<div class="container mt-4">
		<div class="display-4 text-center">
      Order # <%=request.getParameter("oid") %>
    </div>
		<div class="card mt-4">
			<div class="card-header text-center">
				Patient Information
			</div>
			<div class="card-body">
        <div class="row">
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              First Name:
            </div>
            <%=fName %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Middle Name:
            </div>
            <%=mName %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Last Name:
            </div>
            <%=lName %>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              DOB:
            </div>
            <%=DOB %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Phone Number:
            </div>
            <%=phone_number %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Email Address:
            </div>
            <%=email %>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <hr>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              Asthma:
            </div>
            <% 
              if (asthma) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              X-Ray Dye Allergy:
            </div>
            <% 
              if (xraydye) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              MRI Dye Allergy:
            </div>
            <% 
              if (mridye) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              Latex Allergy:
            </div>
            <% 
              if (latex) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="font-weight-bold">
              Patient Notes:
            </div>
            <p>
              <%=pnotes %>
            </p>
          </div>
        </div>
      </div>
		</div>

    <div class="card mt-4">
			<div class="card-header text-center">
				Order Information
			</div>
			<div class="card-body">
        <div class="row">
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Reason for Visit:
            </div>
            <%=visit_reason %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Imaging Needed:
            </div>
            <%=imaging_needed %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Modality:
            </div>
            <%=modality %>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="font-weight-bold">
              Order Notes:
            </div>
            <p>
              <%=onotes %>
            </p>
          </div>
        </div>
      </div>
    </div>
	</div>
	<script>
		$(document).ready(function(){
			
		});
		
	</script>
</body>
</html>