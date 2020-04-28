package kr.manamana.file.service;

import java.util.HashMap;
import java.util.Random;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.manamana.file.dao.MemberDAO;
import kr.manamana.file.vo.MemberRoleVO;
import kr.manamana.file.vo.MemberVO;
import kr.manamana.file.vo.PagingVO;



@Service
public class MemberService {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;

	Logger logger = LoggerFactory.getLogger(MemberService.class);
    //1.개수얻기
    public int getCount() {
	  return memberDAO.getCount();
  }
    public MemberVO selectById(String userid) {
    	return memberDAO.selectById(userid);
    }
    //저장하기
    public void insert(MemberVO memberVO) {
    	//1.데이터검증
    	if(memberVO==null || memberVO.getUserid()==null) return;
    	//2.DB에저장 자동으로 role_user이 되게함
    	memberDAO.insert(memberVO);
    	Logger logger = LoggerFactory.getLogger(getClass());
    	MemberRoleVO roleVO = new MemberRoleVO(memberVO.getUserid(), "ROLE_USER");
    	logger.info("insert role : "+ roleVO);
    	System.out.println("insert role : "+ roleVO);
    	memberDAO.insertRole(roleVO);
    	//3.회원가입 축하메일 발송
    	sendEmail(memberVO);
    }
    

	// 2.1페이지얻기
	public PagingVO<MemberVO> selectList(int currentPage, int pageSize, int blockSize) {
		logger.info("MemberVOService.selectList 인수:" + currentPage + "," + pageSize + "," + blockSize);
		PagingVO<MemberVO> pagingVO = null;

		try {// 세션이 자동주입되니까 내가 실행할필요가없으므로 다 지운다

			// ----------------------------------------
			// 자동주입됫으니 삭제한다
			// MemoDAO dao = MemoDAO.getInstance();
			int totalCount = memberDAO.getCount();
			pagingVO = new PagingVO<>(totalCount, currentPage, pageSize, blockSize);
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			pagingVO.setList(memberDAO.selectList());
			// ---------------------------------------
			for (MemberVO vo : pagingVO.getList()) {
				vo.setMemberRoleList(memberDAO.selectRoleList(vo.getUserid()));
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {

		}
		logger.info("MemberVOService.selectList리턴값:" + pagingVO);
		return pagingVO;
	}

    
    
    public void sendEmail(MemberVO memberVO) {
    	MimeMessagePreparator preparator = getMessagePreparator(memberVO);
    	try {
    		mailSender.send(preparator);
    		System.out.println("메일 보내기성공**************************************"); 		
    	}catch (MailException ex) {
			System.out.println(ex.getMessage());
		}
    }
    private MimeMessagePreparator getMessagePreparator(final MemberVO memberVO) {
    	MimeMessagePreparator preparator = new MimeMessagePreparator() {
    
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				 mimeMessage.setFrom("mr9418@naver.com");
				 mimeMessage.setRecipient(Message.RecipientType.TO,new InternetAddress(memberVO.getUserid()));
				 mimeMessage.setText("반갑습니다"+memberVO.getUsername()+"님!!!"
				    +"회원가입을 축하드립니다");
						mimeMessage.setSubject("회원가입을 축하드립니다");
			}
		};
		return preparator;
    }
    //회원이메일인증
    public void confirm(String userid){
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("userid", userid);
    	MemberVO vo = memberDAO.selectByUserID(map);
    	//DB변경
    	if(vo!=null) {
    		HashMap<String, String> map2 = new HashMap<String, String>();
    		map2.put("userid", userid);
    		map2.put("use", "2");
    		memberDAO.updateUse(map2);
    	}
    }
    //아이디중복검사
    public String idCheck(String userid) {
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("userid", userid);
    	MemberVO vo = memberDAO.selectByUserID(map);
    	return vo==null ? "0" : "1"; //vo가 null 인데 참일경우는 0:가입되어있는상태 1은휴면상태이다
    }
    //로그인처리
    public MemberVO loginOk(MemberVO memberVO) {
    	MemberVO vo = null;
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("userid", memberVO.getUserid());
    	vo = memberDAO.selectByUserID(map);
    	if(vo!=null) {//vo가 null이 아닌데
    		//vo의 비번이랑 멤버vo에서가져온비번이 같지않다면
    		if(!vo.getPassword().equals(memberVO.getPassword())) {
    			vo = null; //vo정보는없는것
    		}
    	}
    	return vo;
    }
    //이름과 폰으로 아이디찾기
    public MemberVO idSearch(MemberVO memberVO) {
    	MemberVO vo = null;
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("username", memberVO.getUsername());
    	map.put("phone", memberVO.getPhone());
    	vo = memberDAO.selectByUserName(map);
    	return vo;
    }
    
    public MemberVO passwordSearch(MemberVO memberVO) {
    	MemberVO vo = null;
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("userid", memberVO.getUserid());
    	vo = memberDAO.selectByUserID(map); 
    	if(!(vo!=null && vo.getUsername().equals(memberVO.getUsername())&&vo.getPhone().equals(memberVO.getPhone()))) {
    	 vo = null;
    }else {
    	//임시비밀번호를 만들어서 사용자에게 메일을 발송한다
    	//1. 임시비번생성
    	StringBuilder sb = new StringBuilder();
    	Random rnd = new Random();
    	for(int i=0; i<4; i++) {
    		sb.append((char)(rnd.nextInt(26)+'A')+""); //대문자
    		sb.append((char)(rnd.nextInt(26)+'a')+""); //소문자
    		sb.append((char)(rnd.nextInt(10)+'0')+""); //숫자
    	}
    	final String password = sb.toString();
    	//2. 임시 비번으로 DB를 업데이트 해주고
    	HashMap<String, String> map2 = new HashMap<String, String>();
    	map2.put("userid", memberVO.getUserid());
    	map2.put("password", password);
		memberDAO.updatePassword(map2);
		// 3. 메일 발송
        try {
        	final MemberVO vo2 = vo;
        	MimeMessagePreparator preparator = new MimeMessagePreparator() {
        		@Override
        		public void prepare(MimeMessage mimeMessage) throws Exception {
        			mimeMessage.setFrom("sungnam2020@gmail.com");
        			mimeMessage.setRecipient(Message.RecipientType.TO,
        					new InternetAddress(vo2.getUserid()));
        			mimeMessage.setText("반갑습니다. " + vo2.getUsername() + "님!!!\n"
        					+ "임시비밀 번호 입니다.\n"
        					+ password + "\n");
        			mimeMessage.setSubject("임시비밀 번호 입니다!!!");
        		}
        	};
        	mailSender.send(preparator);
        	System.out.println("메일보내기성공*************************************");
     }catch (MailException ex) {
		System.out.println(ex.getMessage());
	  }
      	
    } 
     return vo;
 } 
  
}

    
    
    
    
