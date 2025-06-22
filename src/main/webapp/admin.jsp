<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Admin" %>
<%
    Admin admin=(Admin) session.getAttribute("admin");
    if(admin==null){
        response.sendRedirect("../loginAdmin.jsp?errore=true");
        return;
    }
%>

<html>
<head>
    <title>Area Admin</title>
</head>
<body>
    <h2>Benvenuto, <%= admin.getNome() %> <%=admin.getCognome()%>!</h2>
    <p>Username: <%=admin.getUsername()%></p>

    <hr>
    <a href="../LogoutServlet">Logout</a>
</body>
</html>