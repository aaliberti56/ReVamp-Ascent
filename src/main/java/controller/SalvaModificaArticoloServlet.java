package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.DAO.ArticoloDAO;
import model.JavaBeans.Articolo;
import java.io.IOException;

@WebServlet(name = "SalvaModificaArticoloServlet", value = "/SalvaModificaArticoloServlet")
public class SalvaModificaArticoloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // RECUPERO PARAMETRI (come stringhe per sicurezza)
            String codiceStr = request.getParameter("codice");
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            String colore = request.getParameter("colore");
            String scontoStr = request.getParameter("sconto");
            String prezzoStr = request.getParameter("prezzo");
            String pesoStr = request.getParameter("peso");
            String dimensione = request.getParameter("dimensione");
            String idCategoriaStr = request.getParameter("id_categoria");

            // CONVERSIONI SICURE
            int codice = Integer.parseInt(codiceStr);
            int id_categoria = Integer.parseInt(idCategoriaStr);
            double prezzo = Double.parseDouble(prezzoStr);

            // Gestione Peso (se vuoto diventa 0)
            double peso = 0.0;
            if (pesoStr != null && !pesoStr.trim().isEmpty()) {
                peso = Double.parseDouble(pesoStr);
            }

            // Gestione Sconto (se vuoto diventa 0)
            double sconto = 0.0;
            if (scontoStr != null && !scontoStr.trim().isEmpty()) {
                sconto = Double.parseDouble(scontoStr);
                // Se l'admin scrive "20" per il 20%, convertiamo in 0.20 per il DB
                if (sconto > 1.0) {
                    sconto = sconto / 100.0;
                }
            }

            Articolo articolo = new Articolo(
                    codice, nome, descrizione, colore,
                    sconto, prezzo, peso, dimensione, id_categoria
            );

            ArticoloDAO articoloDAO = new ArticoloDAO();
            articoloDAO.doUpdate(articolo);

            // QUI LA MODIFICA: Torna alla lista articoli corretta
            response.sendRedirect("listaArticoli.jsp?msg=modificaOK");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore nella modifica: " + e.getMessage());
            request.getRequestDispatcher("erroreInserimento.jsp").forward(request, response);
        }
    }
}