package kr.manamana.file.vo;

import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@XmlRootElement
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberVO {
	private int idx;
	private String userid;
	private String password;
	private String username;
	private String nickname;
	private Date   birth;
	private String phone;
	private String zipcode;
	private String addr1;
	private String addr2;
	private int    use;
	private Date   regdate;
	
	private List<MemberRoleVO> memberRoleList;
}
