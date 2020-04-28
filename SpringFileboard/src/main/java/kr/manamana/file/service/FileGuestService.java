package kr.manamana.file.service;

import java.util.HashMap;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.manamana.file.dao.FileGuestDAO;
import kr.manamana.file.vo.FileGuestVO;
import kr.manamana.file.vo.PagingVO;


@Service
public class FileGuestService {  
	//싱글톤은 지운다
	//자동주입
    @Autowired
	private FileGuestDAO fileGuestDAO;
     
      Logger logger = LoggerFactory.getLogger(FileGuestService.class);

	//1.1개얻기
	public FileGuestVO selectByIdx(int idx) {
		logger.info("FileGuestService.selectByIdx 인수:"+idx);
		FileGuestVO vo = null;
		
			try{//sql세션얻는다
		
			//---------------------------------------- 
			  vo = fileGuestDAO.selectByIdx(idx);
			 //---------------------------------------
			
		     }catch(Exception e){
				
				  e.printStackTrace();
			 }finally{
				
			 }
	  logger.info("FileGuestService.selectByIdx 리턴값:"+vo);
		return vo;
	}
	//2.1페이지얻기
	public PagingVO<FileGuestVO> selectList(int currentPage, int pageSize, int blockSize) {
		logger.info("FileGuestService.selectList 인수:"+currentPage+","+pageSize+","+blockSize);
		PagingVO<FileGuestVO> pagingVO = null;
		
			try{//세션이 자동주입되니까 내가 실행할필요가없으므로 다 지운다
		
			//---------------------------------------- 
			 //자동주입됫으니 삭제한다   
				//MemoDAO dao = MemoDAO.getInstance();
			 int totalCount =fileGuestDAO.selectCount();
			 pagingVO = new PagingVO<>(totalCount, currentPage, pageSize, blockSize);
			 HashMap<String, Integer> map = new HashMap<String, Integer>();
			 map.put("startNo", pagingVO.getStartNo());
			 map.put("endNo", pagingVO.getEndNo());
			 pagingVO.setList(fileGuestDAO.selectList(map));
		    //---------------------------------------
		
		     }catch(Exception e){
		
				  e.printStackTrace();
			 }finally{
		
			 }		
	  logger.info("FileGuestService.selectList 리턴값:"+pagingVO);
		return pagingVO;
	}
	//3.저장하기
	public void insert(FileGuestVO vo) {
		logger.info("FileGuestService.insert 인수:"+vo);
			try{
		     
			//---------------------------------------- 
			if(vo!=null) {
				fileGuestDAO.insert(vo);
			}
		    //---------------------------------------
			
		     }catch(Exception e){
			
				  e.printStackTrace();
			 }finally{
				
			 }		
	     }

	//4.수정하기
	public void update(FileGuestVO vo) {
		logger.info("FileGuestService.update 인수:"+vo);
		try{//sql세션얻는다
		   
			//---------------------------------------- 
		    //비번이 일치할때만 수정가능하게 하자
		     if(vo!=null) {
		    	 FileGuestVO dbvo = fileGuestDAO.selectByIdx(vo.getIdx());
		        if(dbvo!=null && dbvo.getPassword().equals(vo.getPassword())) {
		        	fileGuestDAO.update(vo);
		        }
		     
		     }
		     //---------------------------------------
			
		     }catch(Exception e){
			
				  e.printStackTrace();
			 }finally{
				
			 }		
	}
	  //5.삭제하기
	public void delete(FileGuestVO vo) {
		logger.info("FileGuestService.delete 인수:"+vo);
		
			try{//
			  
				//---------------------------------------- 
			    //비번이 일치할때만 삭제가능하게 하자
			     if(vo!=null) {
			    	 FileGuestVO dbvo = fileGuestDAO.selectByIdx(vo.getIdx());
			     if(dbvo!=null && dbvo.getPassword().equals(vo.getPassword())) {
			    	 fileGuestDAO.delete(vo.getIdx());
			     }
			   } 
			     //---------------------------------------
				
			     }catch(Exception e){
				
					  e.printStackTrace();
				 }finally{
			
				 }		
		
   } 
}