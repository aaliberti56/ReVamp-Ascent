package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.JavaBeans.*;
import model.DAO.*;
import java.util.*;
import java.io.IOException;

import java.io.IOException;

@WebServlet(name = "Admin", value = "/LoginServlet")
public class login extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        ClienteDAO clienteDAO = new ClienteDAO();
        Cliente cliente = clienteDAO.checkLogin(username, password);

        if (cliente != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utenteLoggato", cliente);

            // 🔁 Trasferisci carrello anonimo nel DB
            List<Carrello> carrelloAnonimo = (List<Carrello>) session.getAttribute("carrelloAnonimo");
            if (carrelloAnonimo != null && !carrelloAnonimo.isEmpty()) {
                CarrelloDAO carrelloDAO = new CarrelloDAO();
                for (Carrello item : carrelloAnonimo) {
                    carrelloDAO.aggiungiAlCarrello(cliente.getNomeUtente(), item.getCodiceArticolo(), item.getQuantita());
                }
                session.removeAttribute("carrelloAnonimo"); // ✅ lo pulisci
            }

            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("erroreLogin", "Nome utente o password errati");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }

}
