<% 
  String username = "place holder";
  if (session.getAttribute("username") != null) {
    username = (String) session.getAttribute("username");
  }
  else {
    response.sendRedirect("login.jsp");
  }
  Integer role = 0;
	if (session.getAttribute("role_id") == null) {
		response.sendRedirect("login.jsp");
	}
	else {
		role = (Integer) session.getAttribute("role_id");
	}
  
%>
<nav class="navbar navbar-expand-md navbar-light bg-light">
  <a class="navbar-brand" href="/RISTeam4/"><i class="fas fa-x-ray"></i> XamineRIS</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <% 
			  if (role == 5) {
		  %>	
      <li class="nav-item">
        <a class="nav-link" href="http://localhost/phpmyadmin/">Database</a>
      </li>
      <% } %>
      <li class="nav-item">
        <a class="nav-link" href="logout.jsp">Logout</a>
      </li>
    </ul>
    <span class="navbar-text">Logged in as <%=username %></span>
  </div>
</nav>
