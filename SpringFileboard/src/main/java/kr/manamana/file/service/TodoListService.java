package kr.manamana.file.service;

import java.util.HashMap;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.manamana.file.dao.TodoListDAO;
import kr.manamana.file.vo.PagingVO;
import kr.manamana.file.vo.TodoListVO;

@Service
public class TodoListService {
	//싱글톤은 지운다
	//자동주입
    @Autowired
	private TodoListDAO todoListDAO;
     
      Logger logger = LoggerFactory.getLogger(TodoListService.class);

	//1.1개얻기
	public TodoListVO selectByIdx(int idx) {
		logger.info("TodoListService.selectByIdx 인수:"+idx);
		TodoListVO vo = null;
		
			try{//sql세션얻는다
		
			//---------------------------------------- 
			  vo = todoListDAO.selectByIdx(idx);
			 //---------------------------------------
			
		     }catch(Exception e){
				
				  e.printStackTrace();
			 }finally{
				
			 }
	  logger.info("TodoListService.selectByIdx 리턴값:"+vo);
		return vo;
	}
	//2.1페이지얻기
	public PagingVO<TodoListVO> selectList(int currentPage, int pageSize, int blockSize) {
		logger.info("TodoListService.selectList 인수:"+currentPage+","+pageSize+","+blockSize);
		PagingVO<TodoListVO> pagingVO = null;
		
			try{//세션이 자동주입되니까 내가 실행할필요가없으므로 다 지운다
		
			//---------------------------------------- 
			 //자동주입됫으니 삭제한다   
				//MemoDAO dao = MemoDAO.getInstance();
			 int totalCount =todoListDAO.selectCount();
			 pagingVO = new PagingVO<>(totalCount, currentPage, pageSize, blockSize);
			 HashMap<String, Integer> map = new HashMap<String, Integer>();
			 map.put("startNo", pagingVO.getStartNo());
			 map.put("endNo", pagingVO.getEndNo());
			 pagingVO.setList(todoListDAO.selectList(map));
		    //---------------------------------------
		
		     }catch(Exception e){
		
				  e.printStackTrace();
			 }finally{
		
			 }		
	  logger.info("TodoListService.selectList 리턴값:"+pagingVO);
		return pagingVO;
	}
	//3.저장하기
	public void insert(TodoListVO vo) {
		logger.info("TodoListService.insert 인수:"+vo);
			try{
		     
			//---------------------------------------- 
			if(vo!=null) {
				todoListDAO.insert(vo);
			}
		    //---------------------------------------
			
		     }catch(Exception e){
			
				  e.printStackTrace();
			 }finally{
				
			 }		
	     }

	//4.수정하기
	public void update(TodoListVO vo) {
		logger.info("TodoListService.update 인수:"+vo);
		try{
		   
			//---------------------------------------- 
		    //
			if(vo!=null) {
				todoListDAO.update(vo);
			}
		    
		     //---------------------------------------
			
		     }catch(Exception e){
			
				  e.printStackTrace();
			 }finally{
				
			 }		
	}
	  //5.삭제하기
	public void delete(TodoListVO vo) {
		logger.info("TodoListService.delete 인수:"+vo);
		
			try{//
			  
				//---------------------------------------- 
				if(vo!=null) {
					todoListDAO.delete(vo.getIdx());
				}
			     //---------------------------------------
				
			     }catch(Exception e){
				
					  e.printStackTrace();
				 }finally{
			
				 }		
		
   } 
}

