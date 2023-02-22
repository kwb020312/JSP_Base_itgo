package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/webmarketdb";
		String user = "root";
		String password = "0000";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("데이터베이스에 연결되었습니다.");
		} catch(Exception e) {
			System.out.println("데이터베이스에 연결되지 않았습니다.");
			e.printStackTrace();
		}
		
		return conn;
	}
}
