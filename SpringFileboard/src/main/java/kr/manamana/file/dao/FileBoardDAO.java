package kr.manamana.file.dao;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.manamana.file.vo.FileBoardVO;


public interface FileBoardDAO {
	 Logger logger = LoggerFactory.getLogger(FileBoardDAO.class);
 

   //====================================================
//   <!-- 1.전체개수구하기 -->
   public int selectCount(); 

//  <!-- 2 1개구하기 -->
   public FileBoardVO selectByIdx(int idx); 
   // <!-- 3.1페이지구하기-->
   public List<FileBoardVO> selectList(HashMap<String, Integer>map);
	  
  
//   <!-- 4.저장하기 -->                       
   public void insert(FileBoardVO vo);
//   <!-- 5.수정하기 -->
   public void update(FileBoardVO vo); 
//   <!-- 6.삭제하기 --> 
   public void delete(int idx); 
   //7.마지막에 저장한 글의 idx구하기
   public int getLastIdx();

}

