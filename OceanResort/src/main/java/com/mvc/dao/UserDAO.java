package com.mvc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import com.mvc.model.User;

public class UserDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    public boolean registerUser(User user) {

        boolean rowInserted = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "INSERT INTO users (name, email, phone, password, role, created_at) VALUES (?, ?, ?, ?, ?, NOW())";

            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getRole());

            rowInserted = pst.executeUpdate() > 0;

            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowInserted;
    }
}
