<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Accedi al tuo account</h2>
<form action="LoginServlet" method="post">
    <label for="username">Nome utente</label>
    <input type="text" id="username" name="username" required><br>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" required><br>

    <input type="submit" value="Accedi">
</form>

<%--Messaggio di errore  --%>

<%
    String errors=(String) request.getAttribute("erroreLogin");
    if(errors != null){
        %>
    <p style="color:red;"><%=errors %></p>
        <%
    }
%>
</body>
</html>
