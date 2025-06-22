<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>Login Admin</title>
</head>
<body>
    <h2>Area Riservata</h2>

    <form action="AdminLoginServlet" method="post">
        <label for="username">Username</label><br>
        <input type="text" id="username" name="username" required><br>

        <label for="password">Password</label><br>
        <input type="password" id="password" name="password" required><br>

        <input type="submit" value="Login">
    </form>

    <%
        String errore=request.getParameter("errore");
        if("true".equals(errore)){
     %>
    <p style="color:red;">Credenziali non valide</p>
    <%
        }
    %>

</body>
</html>