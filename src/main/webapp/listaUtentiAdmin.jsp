<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 25/06/2025
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="model.ClienteDAO"
         import="model.Cliente"
         import="java.util.ArrayList"
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista Clienti</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    // Controlla che l'admin sia loggato
    if (session.getAttribute("admin") != null) {
        ClienteDAO clienteDAO = new ClienteDAO();
        String ricerca = request.getParameter("nomeUtente");
        ArrayList<Cliente> clienti;

        if (ricerca != null && !ricerca.trim().isEmpty()) {
            // Se c'è ricerca, prendo tutti e poi filtro in Java (meglio se il DAO supporta filtro in DB)
            clienti = (ArrayList<Cliente>) clienteDAO.doRetrieveAll(null);
            // filtro a mano (se vuoi puoi implementare una query con filtro in DAO)
            ArrayList<Cliente> clientiFiltrati = new ArrayList<>();
            for (Cliente c : clienti) {
                if (c.getEmail().toLowerCase().contains(ricerca.toLowerCase())) {
                    clientiFiltrati.add(c);
                }
            }
            clienti = clientiFiltrati;
        } else {
            // Se niente ricerca, prendo tutti
            clienti = (ArrayList<Cliente>) clienteDAO.doRetrieveAll(null);
        }
%>

<h2>Lista Clienti</h2>
<form method="get" action="listaClienti.jsp">
    <input type="text" placeholder="Cerca Cliente per email..." name="nomeUtente" value="<%= (ricerca != null) ? ricerca : "" %>">
    <input type="image" src="img/magnifier.png" class="ricercaImg" alt="Cerca" />
</form>

<table>
    <thead>
    <tr>
        <th>Nome</th>
        <th>Cognome</th>
        <th>Email</th>
    </tr>
    </thead>
    <tbody>
    <% for (Cliente c : clienti) { %>
    <tr>
        <td><%= c.getNome() %></td>
        <td><%= c.getCognome() %></td>
        <td><%= c.getEmail() %></td>
    </tr>
    <% } %>
    </tbody>
</table>

<%
    } else {
        // Se non admin, reindirizza alla pagina di login/errore
        response.sendRedirect("invalidLogin.jsp");
    }
%>
</body>
</html>

