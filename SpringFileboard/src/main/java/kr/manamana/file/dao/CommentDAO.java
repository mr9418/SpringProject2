package kr.manamana.file.dao;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.manamana.file.vo.CommentVO;



public interface CommentDAO {
	
   Logger logger= LoggerFactory.getLogger(CommentDAO.class);	
 
    //1.해당글번호의 개수 구하기
 	public int selectCount(int ref);
 	
 	// 2. 해당 글번호의 댓글 목록 가져오기
 	public List<CommentVO> selectList(int ref);
 	
 	//한개가져오기
 	public CommentVO selectByIdx(int idx);
 	//저장하기
    public void insert(CommentVO vo);

    //수정하기
    public void update(CommentVO vo);
    //삭제하기
    public void delete(int idx);   
}
