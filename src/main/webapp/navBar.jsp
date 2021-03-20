<% 
  String fullname = (String) session.getAttribute("name");
%>
<nav class="navbar navbar-expand-md navbar-light bg-light">
  <a class="navbar-brand" href="/RISTeam4/"><i class="fas fa-x-ray"></i> XamineRIS</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="http://localhost/phpmyadmin/">Database</a>
      </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Logout</a>
        </li>
      </ul>
    <span class="navbar-text">Logged in as <%=fullname %></span>
  </div>
</nav>
