<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Cliente" %>
<%@ page session="true" %>

<%
    Cliente utente=(Cliente) session.getAttribute("utenteLoggato");

    if(utente==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Home</title>
</head>
<body>
    <h2>Benvenuto,<%=utente.getNome()%>!</h2>
    <p>Saldo disponibile : <%=utente.getSaldo()%></p>
    <a href="VisualizzaArticoliServlet">Vai allo shop</a>
    <a href="LogoutServlet">Logout</a>
</body>
</html>