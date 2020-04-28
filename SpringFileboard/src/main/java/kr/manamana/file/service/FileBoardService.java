package kr.manamana.file.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.manamana.file.dao.CommentDAO;
import kr.manamana.file.dao.FileBoardDAO;
import kr.manamana.file.dao.FileBoardFilesDAO;
import kr.manamana.file.vo.CommentVO;
import kr.manamana.file.vo.FileBoardFilesVO;
import kr.manamana.file.vo.FileBoardVO;
import kr.manamana.file.vo.PagingVO;

@Service
public class FileBoardService {

	@Autowired
	private FileBoardDAO fileBoardDAO;
	@Autowired
	private FileBoardFilesDAO fileBoardFilesDAO;
	@Autowired
	private CommentDAO commentDAO;

	// -----------------------------------------------------
	Logger logger = LoggerFactory.getLogger(FileBoardService.class);
	// ----------------------------------------------------

	// 1.1개얻기
	public FileBoardVO selectByIdx(int idx) {
		logger.info("FileBoardService.selectByIdx인수:" + idx);
		FileBoardVO vo = null;
		// -----------------------------------------------------------

		try {
			// ------------------------------------------------------
			// 글 가져오기
			vo = fileBoardDAO.selectByIdx(idx);
			// 첨부파일 가져오기
			if (vo != null) {
				List<FileBoardFilesVO> list = fileBoardFilesDAO.selectList(idx);
				vo.setFileList(list);
				if (list != null) {
					vo.setFileCount(list.size());
				}
				vo.setCommentList(commentDAO.selectList(vo.getIdx()));

			}

			// ------------------------------------------------
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		logger.info("FileBoardService.selectByIdx리턴값:" + vo);
		return vo;

	}

	// 2.한페이지얻기(페이징객체)
	public PagingVO<FileBoardVO> selectList(int currentPage, int pageSize, int blockSize) {
		logger.info("FileBoardSerbice.selectList인수:" + String.format("%d,%d,%d", currentPage, pageSize, blockSize));
		PagingVO<FileBoardVO> pagingVO = null;
		try {
			// 1.페이지계산
			int totalCount = fileBoardDAO.selectCount();
			pagingVO = new PagingVO<>(totalCount, currentPage, pageSize, blockSize);
			// 글 목록 가져오기
			HashMap<String, Integer> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			List<FileBoardVO> list = fileBoardDAO.selectList(map);
			// 글이 있으면 첨부파일목록 글에 추가
			if (list != null && list.size() > 0) {
				// 3)첨부파일 목록을 글에 추가
				for (FileBoardVO vo : list) {
					List<FileBoardFilesVO> fList = fileBoardFilesDAO.selectList(vo.getIdx());
					if (fList != null) {
						vo.setCommentCount(commentDAO.selectCount(vo.getIdx())); // 댓글의 개수를 구해서 넣는다.
						vo.setFileCount(fList.size());
						vo.setFileList(fList);
					}
				}
			}
			// 4.완성된 리스트를 페이징 객체에 대입
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		logger.info("FileBoardService.selectByIdx리턴값:" + pagingVO);
		return pagingVO;
	}

	// 3.저장하기
	public void insert(FileBoardVO vo) {
		logger.info("FileBoardService.insert인수:" + vo);
		// ---------------------------------------------
		try {
			// -----------------------------------------------------------------
			// 저장하기수행
			if (vo != null) {
				fileBoardDAO.insert(vo); // 원본 글 저장
				// 첨부파일이 있다면 파일들을 DB에 추가해줘야한다
				// 첨부파일 리스트에 원본글번호를 넣어주고 저장해야한다
				int ref = fileBoardDAO.getLastIdx();
				System.out.println(vo.getFileList());
				if (vo.getFileList() != null && vo.getFileCount() > 0) {
					// 첨부된 파일의 개수만큼 저장해줘야한다
					for (FileBoardFilesVO fvo : vo.getFileList()) { // 파일갯수만큼for문을돌려줘야한다
						fvo.setRef(ref); // 원본글 번호 저장
						fileBoardFilesDAO.insert(fvo);
						System.out.println(fvo);
					}
				}
			}
			// ---------------------------------------------------
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		System.out.println("******************************************************************");
		
	}

	// 4. 수정하기
	public void update(FileBoardVO vo, String deleteFiles, String path) {
		logger.info("FileBoardService.update 인수 : " + vo + ", " + deleteFiles);
		// ------------------------------------------------------------
		try {
			// -------------------------------------------------------
			// 수정하기 수행
			if (vo != null) {
				// DB의 비번과 일치 할때만 수정한다.
				FileBoardVO dbVO = fileBoardDAO.selectByIdx(vo.getIdx());
				if (dbVO != null && dbVO.getPassword().equals(vo.getPassword())) {
					fileBoardDAO.update(vo); // 원본 글 수정
					// 첨부 파일이 있다면 파일들을 DB에 추가해줘야 한다.
					if (vo.getFileList() != null && vo.getFileCount() > 0) {
						// 첨부된 파일의 개수만큼 저장해 줘야 한다.
						for (FileBoardFilesVO fvo : vo.getFileList()) {
							fvo.setRef(vo.getIdx()); // 원본글 번호 저장
							fileBoardFilesDAO.insert(fvo);
						}
					}

					// 삭제할 파일들은 삭제해 준다.
					if (deleteFiles != null && deleteFiles.trim().length() > 0) {
						String files[] = deleteFiles.trim().split(" ");
						if (files != null && files.length > 0) {
							for (String file : files) {
								// FileBoardFilesVO fvo = fileBoardFilesDAO.selectByIdx(Integer.parseInt(file));
								FileBoardFilesVO fvo = fileBoardFilesDAO.selectByIdx(Integer.parseInt(file));
								fileBoardFilesDAO.deleteByIdx(Integer.parseInt(file)); // DB 내용 삭제
								File file2 = new File(path + fvo.getsFile());
								file2.delete(); // 저장된 실제 파일 삭제
							}
						}
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
	}

	// 5. 삭제하기
	public void delete(FileBoardVO vo, String path) {
		logger.info("FileBoardService.delete 인수 : " + vo);
		// ------------------------------------------------------------
		try {
			// -------------------------------------------------------
			// 삭제하기 수행
			if (vo != null) {
				// DB의 비번과 일치 할때만 삭제한다.
				FileBoardVO dbVO = fileBoardDAO.selectByIdx(vo.getIdx());
				if (dbVO != null && dbVO.getPassword().equals(vo.getPassword())) {
					fileBoardDAO.delete(vo.getIdx()); // 원본 글 삭제
					// 첨부파일 들을 모두 지운다.
					// 첨부 파일 목록을 읽어온다.
					List<FileBoardFilesVO> list = fileBoardFilesDAO.selectList(vo.getIdx());
					// 첨부파일 모두 삭제
					fileBoardFilesDAO.deleteByRef(vo.getIdx()); // DB것 삭제
					// 서버에 저장된 파일 삭제
					for (FileBoardFilesVO fvo : list) {
						File file = new File(path + fvo.getsFile());
						file.delete();
					}
				}
			}
			// -------------------------------------------------------
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
	}

	// 댓글저장
	public void commentinsert(CommentVO vo) {
		logger.info("boardService.commentinsert 인수:" + vo);
		try {
			if (vo != null) {
				commentDAO.insert(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}

	}

	// 수정하
	public void commentupdate(CommentVO vo) {
		logger.info("boardService.commentupdate" + vo);
		try {
			// -------------------------------------------------
			if (vo != null) {
				CommentVO dbvo = commentDAO.selectByIdx(vo.getIdx());
				if (dbvo != null && dbvo.getPassword().equals(vo.getPassword())) {
					commentDAO.update(vo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
	}

	// 삭제하기
	public void commentdelete(CommentVO vo) {
		logger.info("boardService.commentdelete" + vo);
		try {
			// --------------------------------------------------
			if (vo != null) {
				CommentVO dbvo = commentDAO.selectByIdx(vo.getIdx());
				if (dbvo != null && dbvo.getPassword().equals(vo.getPassword())) {
					commentDAO.delete(vo.getIdx());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("boardService.commentdelete리턴값:" + vo);
	}
}
