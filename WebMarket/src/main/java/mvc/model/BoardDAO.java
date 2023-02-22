package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class BoardDAO {
	private static BoardDAO instance;
	
	// DB접속 시 필요한 멤버객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ArrayList<BoardDTO> dtos = null;
	
	public BoardDAO() {}
	
	// 싱글톤 패턴으로 BoardDAO객체를 고유하게 반환한다.
	public static BoardDAO getInstance() {
		if(instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}
	
	// board테이블의 레코드 개수
	public int getListCount(String items, String text) {
		
		int count = 0;
		String sql = "";
		
		//�Ķ���ͷ� �Ѿ���� �˻������ �Ѵ� �ƹ����� ���ٸ�...
		if(items == null && text == null) {
			sql = "select count(*) from board";
		}
		else {
			//�Ķ���ͷ� �Ѿ���� ������ �˻���� �ϰԲ� ������ �ۼ���.
			sql = "select count(*) from board where " + items + " like '%" + text + "%'";
		}
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("getListCount()����" + e.getMessage());
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("getListCount() close()ȣ�� ����" + e2.getMessage());
				e2.printStackTrace();
			}
		}	
		return count;
	}
	
	// board테이블에 있는 레코드를 가져온다.
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text){
		
		int total_record = getListCount(items,text);
		int start = (page - 1) * limit;  //�������� 0�������� �����Ƿ� -1�� �Ѵ�.
		int index = start + 1;
		
		String sql = "";
		dtos = new ArrayList<BoardDTO>();
		
		//�Ķ���ͷ� �Ѿ���� �˻������ �Ѵ� �ƹ����� ���ٸ�...
		//items : ����,����,�۾���  ,  text : �˻��ܾ�
		if(items == null && text == null) {
			sql = "select * from board order by num desc";
		}
		else {
			//�Ķ���ͷ� �Ѿ���� ������ �˻���� �ϰԲ� ������ �ۼ���.
			sql = "select * from board where " + items + " like '%" + text + "%' order by num desc";
		}
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//ex)6�������� ���� �ִٰ� 1�������� Ŭ���� �ϰ� �Ǹ�...
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				
				dtos.add(board);
				
				//�ε����� ������ ������ �Ǽ� ���� �۴ٸ�....
				if(index < (start + limit) && index <= total_record) {
					index++;
				}
				else {
					break;
				}				
			}				
		} catch (Exception e) {
			System.out.println("getBoardList()����" + e.getMessage());
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("getBoardList() close()ȣ�� ����" + e2.getMessage());
				e2.printStackTrace();
			}
		}		
		return dtos;
	}
	
	// member 테이블에 인증된 사용자 명 가져오기
	public String getLoginName(String id) {
		
		String name = null;
		String sql = "SELECT * FROM members WHERE id = ?";
		System.out.println("getLoginName() 들어옴");
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("name");
			}
		}catch (Exception e) {
			System.out.println("getLoginName() 에러");
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				System.out.println("getLoginName() close()호출 에러");
			}
		}
		
		return name;
	}
	
	// board테이블에 새 게시글 저장
	public void insertBoard(BoardDTO board) {
		
		String sql = "ALTER TABLE board auto_increment = 1";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
			
			sql = "INSERT INTO board VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getId());
			pstmt.setString(3, board.getName());
			pstmt.setString(4, board.getSubject());
			pstmt.setString(5, board.getContent());
			pstmt.setString(6, board.getRegist_day());
			pstmt.setInt(7, board.getHit());
			pstmt.setString(8, board.getIp());
			
			pstmt.executeUpdate();
			System.out.println("inserBoard() 수행 완료");
		} catch(Exception e) {
			System.out.println("inserBoard() 예외 발생");
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e2) {
				System.out.println("inserBoard() close() 예외 발생");
				e2.printStackTrace();
			}
		}
	}
	
	// 선택된 게시글의 상세내용
	public BoardDTO getBoardByNum(int num, int page) {
		
		BoardDTO board = null;
		String sql = "SELECT * FROM board WHERE num = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
			}
			System.out.println("getBoardByNum() 수행 완료");
		}catch (Exception e) {
			System.out.println("getBoardByNum() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch (Exception e2) {
				System.out.println("getBoardByNum() close() 예외 발생 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		// 조회 수 증가
		updateHit(num);
		
		return board;
	}
	
	// 게시글 조회 시 조회 수 증가
	public void updateHit(int num) {
		int hit = 0;
		String sql = "SELECT hit FROM board WHERE num = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hit = rs.getInt("hit") + 1;
			}
			
			sql = "UPDATE board SET hit = ? WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			System.out.println("updateHit() 수행 완료");
		} catch (Exception e) {
			System.out.println("updateHit() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e2) {
				System.out.println("updateHit() close() 예외 발생 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
	}
	
	// 게시글 수정
	public void updateBoard(BoardDTO board) {
		
		String sql = "UPDATE board SET subject = ?, content = ?, regist_day = ?, hit = ? WHERE num = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getRegist_day());
			pstmt.setInt(4, board.getHit());
			pstmt.setInt(5, board.getNum());
			
			pstmt.executeUpdate();
			
			System.out.println("updateBoard() 수행 완료");
		} catch (Exception e) {
			System.out.println("updateBoard() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e2) {
				System.out.println("updateBoard() close() 예외 발생 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
	}
	
	// 게시글 삭제
	public void deleteBoard(int num) {
		String sql = "DELETE FROM board WHERE num = ?";
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			System.out.println("deleteBoard() 수행 완료");
		} catch (Exception e) {
			System.out.println("deleteBoard() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e2) {
				System.out.println("deleteBoard() close() 예외 발생 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
	}
}
