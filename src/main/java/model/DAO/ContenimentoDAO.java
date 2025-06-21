package model.DAO;

import java.sql.*;

import model.Connessione.ConPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class ContenimentoDAO{
    public boolean doSave(Contenimento contenimento) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO contenimento (codice, id_ordine, quantita) VALUES (?, ?, ?)"
            );
            ps.setInt(1, contenimento.getCodice());
            ps.setInt(2, contenimento.getId_ordine());
            ps.setInt(3, contenimento.getQuantita());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Restituisce tutti i contenimenti relativi a un ordine
    public List<Contenimento> doRetrieveByOrdine(int id_ordine) {
        List<Contenimento> contenuti = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM contenimento WHERE id_ordine = ?"
            );
            ps.setInt(1, id_ordine);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contenuti.add(new Contenimento(
                        rs.getInt("codice"),
                        rs.getInt("id_ordine"),
                        rs.getInt("quantita")
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return contenuti;
    }

    // Elimina una riga di contenimento specifica
    public boolean doDelete(int codice, int id_ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM contenimento WHERE codice = ? AND id_ordine = ?"
            );
            ps.setInt(1, codice);
            ps.setInt(2, id_ordine);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doUpdateQuantita(int codice, int id_ordine, int nuovaQuantita) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE contenimento SET quantita = ? WHERE codice = ? AND id_ordine = ?"
            );
            ps.setInt(1, nuovaQuantita);
            ps.setInt(2, codice);
            ps.setInt(3, id_ordine);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}
