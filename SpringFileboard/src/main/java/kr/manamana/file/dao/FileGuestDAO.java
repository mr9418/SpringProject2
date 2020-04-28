package kr.manamana.file.dao;


import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.manamana.file.vo.FileGuestVO;

public interface FileGuestDAO {
	//싱글톤은 스프링에서는만들지않는다
	//인터페이스는 선언부만 만들면되기때문에 밑에부분은 다 지운다
	
	 Logger logger= LoggerFactory.getLogger(FileGuestDAO.class);	
	
	//1.전체개수구하기
	public int selectCount();

	//2.한개구하기
	public FileGuestVO selectByIdx( int idx);

	//3.한 페이지구하기
	public List<FileGuestVO> selectList(HashMap<String, Integer>map);
	
	//4.저장하기 리턴할게없을때는 
	public void insert(FileGuestVO vo);
	
	//5.수정하기
	public void update(FileGuestVO vo);
	
	//6.삭제하기
	public void delete(int idx);
	
}
