package model.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {

	private static final String URL = "jdbc:mysql://localhost:3306/beenatural"; // modifica se serve
	private static final String USER = "root"; // metti il tuo utente
	private static final String PASSWORD = "admin"; // metti la tua password

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // per MySQL 8+
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}
}