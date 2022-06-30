package membership;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class MembershipDAO extends JDBConnect{
	
	public MembershipDAO(ServletContext application) {
		super(application);
	}
	
	public int memberInsert(MembershipDTO dto) {
		int affected = 0;
		try {
			String query = "INSERT INTO membership VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getSex());
			psmt.setString(5, dto.getBirth());
			psmt.setString(6, dto.getAddress());
			psmt.setString(7, dto.getEmail());
			psmt.setString(8, dto.getCellphone());
			psmt.setString(9, dto.getPhone());
			
			affected = psmt.executeUpdate();
			System.out.println(affected +"행이 입력되었습니다.");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	
	public MembershipDTO memberLogin(String uid, String upass) {
		
		MembershipDTO memdto = new MembershipDTO();
		String sql = "SELECT * FROM membership WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				memdto.setId(rs.getString(1));
				memdto.setName(rs.getString(3));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return memdto;
	}
}
