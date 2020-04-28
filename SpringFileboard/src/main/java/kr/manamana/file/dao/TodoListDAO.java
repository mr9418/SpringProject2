package kr.manamana.file.dao;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.manamana.file.vo.TodoListVO;

public interface TodoListDAO { 
	  Logger logger= LoggerFactory.getLogger(TodoListDAO.class);	
	    
     //전체개수구하기
	   public int selectCount(); 
     //한개구하기
	   public TodoListVO selectByIdx(int idx); 
	 //1페이지구하기
	   public List<TodoListVO> selectList(HashMap<String, Integer>map);
	  //저장하기
	   public void insert(TodoListVO vo);
       //수정하기
	   public void update(TodoListVO vo); 
     //삭제하기
	   public void delete(int idx); 

}
