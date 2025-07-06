package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import model.DAO.*;
import model.JavaBeans.*;
import java.io.*;

@WebServlet(name = "RicercaCatalogoJson", value = "/RicercaCatalogoJson")
public class RicercaCatalogoJson extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ricerca = request.getParameter("ricerca");
        List<Articolo> articoli = new ArticoloDAO().cercaArticoloPerNome(ricerca);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        if (articoli == null || articoli.isEmpty()) {
            out.print("[]");
            return;
        }

        ImmagineArticoloDAO imgDao=new ImmagineArticoloDAO();

        StringBuilder jsonOutput = new StringBuilder();
        jsonOutput.append("[");

        for (int i = 0; i < articoli.size(); i++) {
            Articolo a = articoli.get(i);
            ImmagineArticolo img=imgDao.findMainImage(a.getCodice());
            String url;
            if(img!=null && img.getUrl() !=null && !img.getUrl().isEmpty()){
                url=img.getUrl();
            }else{
                url="img/default.jpg";
            }
            jsonOutput.append(String.format(Locale.US,
                    "{\"codice\":%d,\"nome\":\"%s\",\"prezzo\":%.2f,\"immagine\":\"%s\"}",
                    a.getCodice(),
                    a.getNome().replace("\"", "\\\""),
                    a.getPrezzo(),
                    url.replace("\"", "\\\"")
            ));

            if (i < articoli.size() - 1)
                jsonOutput.append(",");
        }

        jsonOutput.append("]");
        out.print(jsonOutput.toString());


    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
