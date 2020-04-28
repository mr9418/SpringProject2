package kr.manamana.file.dao;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.manamana.file.vo.FileBoardFilesVO;

public interface FileBoardFilesDAO {
	 Logger logger = LoggerFactory.getLogger(FileBoardFilesDAO.class);
	
	// <!-- 0. 해당 글번호 가져오기  -->
	public FileBoardFilesVO selectByIdx(int idx);
	// <!-- 1. 몇 번글의 파일이 몇개인지 개수 구하기 -->
	public int selectCount(int ref);

   //2.몇번글의 파일의 목록 구하기
   public List<FileBoardFilesVO> selectList(int ref);
	  
   //저장하기
   public void insert(FileBoardFilesVO vo);
   //한개삭제하기
   public void deleteByIdx(int idx);
   //같은ref삭제하기:하나의 파일을 지우면 그 파일에 첨부된 첨부파일들도 같이 삭제되게하기
   public void deleteByRef(int ref);
}
