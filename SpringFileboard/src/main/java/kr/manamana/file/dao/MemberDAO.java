package kr.manamana.file.dao;

import java.util.HashMap;
import java.util.List;

import kr.manamana.file.vo.MemberRoleVO;
import kr.manamana.file.vo.MemberVO;
import kr.manamana.file.vo.TodoListVO;



public interface MemberDAO {
    //1.저장
	public void insert(MemberVO vo);
	//2.1개읽기
	public MemberVO selectByIdx(int idx);
     //로그인체크
	public MemberVO loginCheck(MemberVO vo);
	//2-5. id로 1개 읽기	
    public MemberVO selectById(String userid);
	//3.수정
	public void update(MemberVO vo);
	//4.삭제
	public void delete(MemberVO vo);
	//5.모두읽기\
    public List<MemberVO> selectList();
    //6.개수얻기
    public int getCount();
    //7.1개읽기(유저아이디로 얻기):로그인, 비번찾을때 =>이메일로 비번전송
    public MemberVO selectByUserID(HashMap<String, String>map);
    //8.1개읽기(이름과 전번으로 얻기):아이디찾기->화면에 표시됨
    public MemberVO selectByUserName(HashMap<String, String>map);
    //9.use값 변경하기(0:가입 ,1:휴면2:가입하고 인증)
    public void updateUse(HashMap<String , String>map);
    //10.password값변경하기
    public void updatePassword(HashMap<String, String> map);
    //11.role 추가
    public void insertRole(MemberRoleVO roleVO);
    //username으로 role가져오기
    public MemberRoleVO selectByname(String username);
    //12.role리스트가져오기
    public List<MemberRoleVO> selectRoleList(String username);
}
