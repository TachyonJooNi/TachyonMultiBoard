package model1.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

//board를 multiboard로 수정

public class BoardDAO extends JDBConnect {
	
	public BoardDAO(ServletContext application) {
		super(application);
	}

	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		//WHERE b_flag='"+map.get("b_flag")+"'" 를 추가하고 if문의 where을 지우고 and로 변경
		String query = "SELECT COUNT(*) FROM multiboard WHERE b_flag='"+map.get("b_flag")+"'";
		if(map.get("searchWord") != null) {
			query += " AND " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e){
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		//결과값을 반환한다.
		return totalCount;
	}

	public List<BoardDTO> selectList(Map<String, Object> map){
		
//		List<BoardDTO> bbs = new Vector<BoardDTO>();
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		
		String query = "SELECT * FROM multiboard";
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY num DESC ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//쓰기를 게시판별 수행하기 위한 수정
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			//b_flag 추가
			String query = "INSERT INTO multiboard ( "
					+ " num, title, content, id, visitcount, b_flag) "
					+ " VALUES ( "
					+ " seq_board_num.NEXTVAL, ?, ?, ?, 0, ?)";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getB_flag()); //플레그 추가
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public BoardDTO selectView(String num) {
		
		BoardDTO dto = new BoardDTO();
		String query = "SELECT B.*, M.name "
				+ " FROM multiboard B INNER JOIN member M "
				+ " ON B.id=M.id "
				+ " WHERE num=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setB_flag(rs.getString("b_flag")); // DTO에 b_flag추가
				dto.setName(rs.getString("name"));
			}
		}
		catch(Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}

	public void updateVisitCount(String num) {
		String query = "UPDATE multiboard SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE num=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			psmt.executeQuery();
		}
		catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		try {
			String query = "UPDATE multiboard SET "
					+ " title=?, content=? "
					+ " WHERE num=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int deletePost(BoardDTO dto) {
		int result = 0;
		
		try {
			String query = "DELETE FROM multiboard WHERE num=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			result = psmt.executeUpdate();
			
		}
		catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<BoardDTO> selectListPage(Map<String, Object> map){
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		// WHERE b_flag='"+map.get("b_flag")+"'" 추가 및 if문의 WHERE를 AND로 수정
		String query = " SELECT * FROM ( "
					+ " 	SELECT Tb.*, rownum rNum FROM ( "
					+ " 		SELECT * FROM multiboard "
					+ " WHERE b_flag='"+map.get("b_flag")+"'";
		
		if(map.get("searchWord") != null) {
			query += " AND " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += " 		ORDER BY num DESC "
				+ " 	) Tb "
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
	        
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setB_flag(rs.getString("b_flag"));
				
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
}





































