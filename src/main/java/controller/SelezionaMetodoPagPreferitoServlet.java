package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.JavaBeans.*;
import java.util.*;
import model.DAO.*;

@WebServlet(name = "SelezionaMetodoPagPreferitoServlet", value = "/SelezionaMetodoPagPreferitoServlet")
public class SelezionaMetodoPagPreferitoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numCarta=request.getParameter("numCarta");
        HttpSession session=request.getSession();
        Cliente utente = (Cliente) session.getAttribute("utenteLoggato");
        if(utente==null){
            response.sendRedirect("login.jsp");
            return;
        }

        String nomeUtente = utente.getNomeUtente();
        MetodiPagamentoDAO dao = new MetodiPagamentoDAO();
        List<MetodiPagamento> metodiUtente = dao.doRetrieveByUser(nomeUtente);

        MetodiPagamento preferito=null;
        for(MetodiPagamento m : metodiUtente){
            if(m.getNumCarta().equals(numCarta)){
                preferito=m;
                break;
            }
        }
        if(preferito!=null){
            session.setAttribute("metodoPreferito", preferito);
            response.sendRedirect("riepilogo.jsp");
        }else{
            session.setAttribute("erroreMetodo", "Metodo di pagamento non valido.");
            response.sendRedirect("riepilogo.jsp");
        }
    }
}