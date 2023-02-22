<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%@page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	// 사용자가 입력한 이미지
	String filename = "";
	String realFolder = "D:\\develop\\Self\\JDBC_CRUD\\WebMarket\\src\\main\\webapp\\resources\\images"; // 이미지가 저장될 경로
	int maxSize = 100*1024*1024; // 최대 크기 100MB
	String encType = "UTF-8"; // 인코딩 유형
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	Integer price;
	long stock;
	
	// 단가
	if(unitPrice.isEmpty()) {
		price = 0;
	} else {
		price = Integer.valueOf(unitPrice);
	}
	
	// 재고
	if(unitsInStock.isEmpty()) {
		stock = 0;
	} else {
		stock = Long.valueOf(unitsInStock);
	}
	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	PreparedStatement pstmt = null;
	String sql = "INSERT INTO product VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	pstmt = conn.prepareStatement(sql);
	
	// 해당 9개 데이터가 DB에 저장됨
	pstmt.setString(1, productId);
	pstmt.setString(2, name);
	pstmt.setInt(3, price);
	pstmt.setString(4, description);
	pstmt.setString(5, manufacturer);
	pstmt.setString(6, category);
	pstmt.setLong(7, stock);
	pstmt.setString(8, condition);
	pstmt.setString(9, fileName);
	
	pstmt.executeUpdate();
	
	// 자원 해제
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	// 아래 내용을 DB연동 내용으로 대체
	/* ProductRepository dao = ProductRepository.getInstance();
	Product newProduct = new Product(); */
	
	/* newProduct.setProductId(productId);
	newProduct.setPname(name);
	newProduct.setUnitPrice(price);
	newProduct.setDescription(description);
	newProduct.setManufacturer(manufacturer);
	newProduct.setCategory(category);
	newProduct.setUnitsInStock(stock);
	newProduct.setCondition(condition);
	newProduct.setFilename(fileName); */
	
	/* dao.addProduct(newProduct); */
	
	response.sendRedirect("products.jsp");
%>