<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 26/06/2025
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="model.JavaBeans.Admin"
         import="model.DAO.OrdineDAO"
         import="model.JavaBeans.Ordine"
         import="java.util.*"
         import="java.util.GregorianCalendar"
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Ordini</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin != null) {
        OrdineDAO ordineDAO = new OrdineDAO();
        List<Ordine> ordini;

        String data1 = request.getParameter("data1");
        String data2 = request.getParameter("data2");

        if (data1 != null && !data1.isEmpty() && data2 != null && !data2.isEmpty()) {
            GregorianCalendar gc1 = new GregorianCalendar();
            GregorianCalendar gc2 = new GregorianCalendar();
            gc1.setTime(java.sql.Date.valueOf(data1));
            gc2.setTime(java.sql.Date.valueOf(data2));
            ordini = ordineDAO.doRetrieveByDate(gc1, gc2);
        } else {
            ordini = ordineDAO.doRetrieveAll();
        }
%>

<div class="page-container">
    <div class="header-section">
        <img src="<%= request.getContextPath() %>/img/logo.webp" alt="Logo" class="logo">
        <h2>Gestione Ordini</h2>
    </div>

    <form method="get" action="CercaOrdiniPerDataServlet" class="search-form-container">
        <input type="date" name="data1" value="<%= (data1 != null) ? data1 : "" %>">
        <input type="date" name="data2" id="data2" value="<%= (data2 != null) ? data2 : "" %>">
        <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
    </form>

    <div class="table-wrapper">
        <table>
            <thead>
            <tr>
                <th><i class="fas fa-hashtag"></i> ID</th>
                <th><i class="fas fa-user"></i> Utente</th>
                <th><i class="fas fa-calendar-alt"></i> Data</th>
                <th><i class="fas fa-box"></i> Articoli</th>
                <th><i class="fas fa-euro-sign"></i> Totale</th>
                <th><i class="fas fa-info-circle"></i> Dettagli</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (!ordini.isEmpty()) {
                    for (Ordine ordine : ordini) {
                        int giorno = ordine.getData().get(Calendar.DAY_OF_MONTH);
                        int mese = ordine.getData().get(Calendar.MONTH) + 1;
                        int anno = ordine.getData().get(Calendar.YEAR);
            %>
            <tr>
                <td><%= ordine.getId_ordine() %></td>
                <td><%= ordine.getNome_utente() %></td>
                <td><%= String.format("%02d/%02d/%04d", giorno, mese, anno) %></td>
                <td><%= ordine.getNum_articoli() %></td>
                <td><%= String.format("€%.2f", ordine.getImporto_totale()) %></td>
                <td>
                    <a href="DettaglioOrdineServlet?id=<%= ordine.getId_ordine() %>" class="detail-link">
                        <i class="fas fa-eye"></i>
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6" class="no-results-message">Nessun ordine trovato nel periodo selezionato.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<% } else {
    response.sendRedirect("invalidLogin.jsp");
} %>
</body>
<script>
    document.getElementById('data2').max = new Date().toISOString().split("T")[0];
    document.getElementById('data2').value = new Date().toISOString().split("T")[0];
</script>
</html>
