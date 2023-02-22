package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.Product;

public class ProductRepository {
	private ArrayList<Product> listOfProducts = new ArrayList<>();

	// 싱글톤 패턴
	private static ProductRepository instance = new ProductRepository();

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private static String url = "jdbc:mysql://localhost:3306/webmarketdb";
	private static String user = "root";
	private static String password = "0000";

	// 인스턴스를 반환하는 getter
	public static ProductRepository getInstance() {
		return instance;
	}

	/*
	 * public ProductRepository() {
	 * 
	 * Product phone = new Product("P1234", "Galaxy S20", 1200000);
	 * phone.setDescription("5.25-inch, 1334*750 HD display, 16-megapixel Camera");
	 * phone.setCategory("Smart Phone"); phone.setManufacturer("SAMSUNG");
	 * phone.setUnitsInStock(1000); phone.setCondition("New");
	 * phone.setFilename("P1234.jpg");
	 * 
	 * Product notebook = new Product("P1235", "LG GRAM", 2000000);
	 * notebook.setDescription("13.3-inch, IPS FULL HD display, Intel Core Process"
	 * ); notebook.setCategory("Notebook"); notebook.setManufacturer("LG");
	 * notebook.setUnitsInStock(1000); notebook.setCondition("Refurbished");
	 * notebook.setFilename("P1235.jpg");
	 * 
	 * Product tablet = new Product("P1236", "Galaxy Tab", 900000); tablet.
	 * setDescription("212.8*125.6*6.6mm, Super AMOLED display, Octa-Core Processor"
	 * ); tablet.setCategory("Notebook"); tablet.setManufacturer("SAMSUNG");
	 * tablet.setUnitsInStock(1000); tablet.setCondition("Old");
	 * tablet.setFilename("P1236.jpg");
	 * 
	 * 
	 * 
	 * listOfProducts.add(phone); listOfProducts.add(notebook);
	 * listOfProducts.add(tablet);
	 * 
	 * }
	 */

	public ArrayList<Product> getAllProducts() {
		String sql = "SELECT * FROM product";
		
		try {
			conn = getConnection(); // 커넥션 입력
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getString("p_id"));
				product.setPname(rs.getString("p_name"));
				product.setUnitPrice(rs.getInt("p_unitPrice"));
				product.setDescription(rs.getString("p_description"));
				product.setCategory(rs.getString("p_category"));
				product.setUnitsInStock(rs.getLong("p_unitsInStock"));
				product.setCondition(rs.getString("p_condition"));
				product.setFilename(rs.getString("p_filename"));
				
				// ArrayList컬렉션에 추가
				listOfProducts.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	
				System.out.println("DB연동 해제");
			} catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return listOfProducts;
	}

	public Product getProductById(String productId) {
		
		String sql = "SELECT * FROM product WHERE p_id=?";
		Product productById = new Product();
		
		try {
			conn = getConnection(); // 커넥션 입력
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			
			rs = pstmt.executeQuery();
			
			if(!rs.next() ) {
				return null;
			}
			
			if(rs.next()) {
				productById.setProductId(rs.getString("p_id"));
				productById.setPname(rs.getString("p_name"));
				productById.setUnitPrice(rs.getInt("p_unitPrice"));
				productById.setDescription(rs.getString("p_description"));
				productById.setCategory(rs.getString("p_category"));
				productById.setUnitsInStock(rs.getLong("p_unitsInStock"));
				productById.setCondition(rs.getString("p_condition"));
				productById.setFilename(rs.getString("p_filename"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	
				System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		/*
		 * for (int i = 0; i < listOfProducts.size(); i++) { Product product =
		 * listOfProducts.get(i); if (product != null && product.getProductId() != null
		 * && product.getProductId().equals(productId)) { productById = product; break;
		 * } }
		 */

		return productById;
	}

	// 상품을 추가하는 역할을 하는 메서드
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 연동
			conn = DriverManager.getConnection(url, user, password); // DB연결 객체
			System.out.println("DB연동 완료");
		} catch(Exception e) {
			System.out.println("DB연동 실패");
			System.out.println("실패 사유 : ");
			e.printStackTrace();
		}
		return conn;
	}
}
