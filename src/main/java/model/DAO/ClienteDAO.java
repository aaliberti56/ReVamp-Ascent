package model.DAO;

import java.sql.*;
import model.JavaBeans.*;
import model.ConPool;
import java.util.List;
import java.util.logging.Level;
import java.util.ArrayList;

public class ClienteDAO{

    public Cliente doRetrieveByUsername(String nome_utente){
        try(Connection con=ConPool.getConnection()){
            PreparedStatement ps=con.prepareStatement("select * from cliente where nome_utente=?");
            ps.setString(1, nome_utente);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                return new Cliente(
                        rs.getString("nome_utente"),
                        rs.getString("pass"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getDouble("saldo"),
                        rs.getString("email"),
                        rs.getString("sesso"),
                        rs.getInt("eta"),
                        rs.getString("num_telefono")
                );
            }
            return null;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public List<Cliente> doRetrieveAll(){
        List<Cliente> clienti=new ArrayList<>();
        try(Connection con=ConPool.getConnection()){
            Statement st = con.createStatement(); //

            ResultSet rs=st.executeQuery("select * from cliente");
            while(rs.next()){
                Cliente c = new Cliente(
                        rs.getString("nome_utente"),
                        rs.getString("pass"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getDouble("saldo"),
                        rs.getString("email"),
                        rs.getString("sesso"),
                        rs.getInt("eta"),
                        rs.getString("numTelefono")
                );
                clienti.add(c);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return clienti;
    }

    public boolean doSave(Cliente cliente){
        try(Connection con=ConPool.getConnection()){
            PreparedStatement ps=con.prepareStatement("INSERT INTO cliente(nome_utente, pass, nome, cognome, saldo, email, sesso, eta, num_telefono) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, cliente.getNomeUtente());
            ps.setString(2, cliente.getPass());
            ps.setString(3, cliente.getNome());
            ps.setString(4, cliente.getCognome());
            ps.setDouble(5, cliente.getSaldo());
            ps.setString(6, cliente.getEmail());
            ps.setString(7, cliente.getSesso());
            ps.setInt(8, cliente.getEta());
            ps.setString(9, cliente.getNumTelefono());

            return ps.executeUpdate() > 0;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public boolean doDelete(String nomeUtente) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM cliente WHERE nome_utente = ?");
            ps.setString(1, nomeUtente);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Cliente checkLogin(String nome_utente,String pass){
        try(Connection con=ConPool.getConnection()){
            PreparedStatement ps=con.prepareStatement("SELECT * FROM cliente WHERE nome_utente = ? AND pass = ?");
            ps.setString(1, nome_utente);
            ps.setString(2, pass);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                return new Cliente(
                        rs.getString("nome_utente"),
                        rs.getString("pass"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getDouble("saldo"),
                        rs.getString("email"),
                        rs.getString("sesso"),
                        rs.getInt("eta"),
                        rs.getString("numTelefono")
                );
            }
            return null;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean aggiornaSaldo(String nomeUtente, double nuovoSaldo) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE cliente SET saldo = ? WHERE nome_utente = ?"
            );
            ps.setDouble(1, nuovoSaldo);
            ps.setString(2, nomeUtente);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}


