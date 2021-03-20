<% 
  session.removeAttribute("user_id");
  session.removeAttribute("role_id");
  session.removeAttribute("name");

  response.sendRedirect("login.jsp");
  
%>