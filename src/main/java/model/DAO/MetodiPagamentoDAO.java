package model.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import model.JavaBeans.*;
import model.ConPool;

public class MetodiPagamentoDAO {

    public MetodiPagamento doRetrieveByKey(String numCarta){
        try(Connection con = ConPool.getConnection()){
            PreparedStatement ps=con.prepareStatement("SELECT * FROM Metodi_pagamento WHERE num_carta = ?");
            ps.setString(1, numCarta);
            ResultSet rs=ps.executeQuery();
            if (rs.next()) {
                GregorianCalendar dataScadenza = new GregorianCalendar();
                Date sqlDate = rs.getDate("data_scadenza");
                if (sqlDate != null) {
                    dataScadenza.setTime(sqlDate);
                }
                return new MetodiPagamentoBean(
                        rs.getString("num_carta"),
                        rs.getString("intestatario"),
                        dataScadenza,
                        rs.getInt("cvv"),
                        rs.getString("nome_utente")
                );
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<MetodiPagamentoBean> doRetrieveAll() {
        List<MetodiPagamentoBean> lista = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Metodi_pagamento");
            while (rs.next()) {
                GregorianCalendar dataScadenza = new GregorianCalendar();
                Date sqlDate = rs.getDate("data_scadenza");
                if (sqlDate != null) {
                    dataScadenza.setTime(sqlDate);
                }
                MetodiPagamentoBean metodo = new MetodiPagamentoBean(
                        rs.getString("num_carta"),
                        rs.getString("intestatario"),
                        dataScadenza,
                        rs.getInt("cvv"),
                        rs.getString("nome_utente")
                );
                lista.add(metodo);
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(MetodiPagamentoBean metodo) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Metodi_pagamento (num_carta, intestatario, data_scadenza, cvv, nome_utente) VALUES (?, ?, ?, ?, ?)"
            );
            ps.setString(1, metodo.getNumCarta());
            ps.setString(2, metodo.getIntestatario());
            ps.setDate(3, new java.sql.Date(metodo.getDataScadenza().getTimeInMillis()));
            ps.setInt(4, metodo.getCvv());
            ps.setString(5, metodo.getNomeUtente());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doDelete(String numCarta) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM Metodi_pagamento WHERE num_carta = ?");
            ps.setString(1, numCarta);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doUpdate(MetodiPagamentoBean metodo) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE Metodi_pagamento SET intestatario = ?, data_scadenza = ?, cvv = ?, nome_utente = ? WHERE num_carta = ?"
            );
            ps.setString(1, metodo.getIntestatario());
            ps.setDate(2, new java.sql.Date(metodo.getDataScadenza().getTimeInMillis()));
            ps.setInt(3, metodo.getCvv());
            ps.setString(4, metodo.getNomeUtente());
            ps.setString(5, metodo.getNumCarta());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}



}
