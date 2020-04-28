package kr.manamana.file;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.manamana.file.service.FileBoardService;
import kr.manamana.file.service.FileGuestService;
import kr.manamana.file.service.UploadFileUtils;
import kr.manamana.file.vo.CommentVO;
import kr.manamana.file.vo.CommonVO;
import kr.manamana.file.vo.FileBoardFilesVO;
import kr.manamana.file.vo.FileBoardVO;
import kr.manamana.file.vo.FileGuestVO;
import kr.manamana.file.vo.PagingVO;

@Controller
public class FileController {
	
	@Autowired
	private FileBoardService fileBoardService;
	@Autowired
	private FileGuestService fileGuestService;
	

	@Resource
	private String uploadPath;
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	
	
	//---------------------------파일 업로드 게시판------------------//
	@RequestMapping(value = "/file")
	public String file(@ModelAttribute CommonVO commonVO, Model model, HttpServletRequest request) {
		// POST 전송으로 값이 넘어오면 처리
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			Integer p = (Integer) flashMap.get("p");
			if (p != null)
				commonVO.setCurrentPage(p);
			Integer s = (Integer) flashMap.get("s");
			if (s != null)
				commonVO.setPageSize(s);
			Integer b = (Integer) flashMap.get("b");
			if (b != null)
				commonVO.setBlockSize(b);
		}
		PagingVO<FileBoardVO> pagingVO = fileBoardService.selectList(commonVO.getCurrentPage(), commonVO.getPageSize(),
				commonVO.getBlockSize());
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("commonVO", commonVO);
		model.addAttribute("newLine", "\n");
		model.addAttribute("br", "<br/>");
		logger.info("HomeController.index : " + pagingVO.toString());
		logger.info("HomeController.index : " + commonVO.toString());
		return "index";
	}
	
	// 글쓰기로 가는 경로를 작성해준다
	@RequestMapping(value = "/insert")
	public String insert(@ModelAttribute CommonVO commonVO, Model model) {
		logger.info("HomeController.insert" + commonVO.toString());
		model.addAttribute("commonVO", commonVO);
		return "insert";
	}

	// GET방식호출
	@RequestMapping(value = "/insertOk", method = RequestMethod.GET)
	public String insertOkGet() {
		return "redirect:/file/file";
	}

	// POST방식일 경우에 파일 업로드 처리
	@RequestMapping(value = "/insertOk", method = RequestMethod.POST)
	public String MultiuploadOkPost(MultipartHttpServletRequest request, @ModelAttribute CommonVO commonVO,
			@ModelAttribute FileBoardVO fileBoardVO, Model model) throws IOException, Exception {
		// 파일 받기
		String realPath = request.getRealPath("/upload/");
		List<MultipartFile> files = request.getFiles("files");
		System.out.println(realPath);
		System.out.println(files);
		if (files != null && files.size() > 0) { // 파일이 존재 한다면
			List<FileBoardFilesVO> list = new ArrayList<FileBoardFilesVO>();
			
			for (MultipartFile file : files) {
				if (file != null && file.getSize() > 0) {
					String savedName = UploadFileUtils.uploadFile(realPath, file.getOriginalFilename(),
							file.getBytes());
					FileBoardFilesVO fvo = new FileBoardFilesVO();
					// setter를 불러서 fvo를 채운다.
					fvo.setoFile(file.getOriginalFilename());
					fvo.setsFile(savedName);
					list.add(fvo);
				}
			}
			fileBoardVO.setFileList(list);
			fileBoardVO.setFileCount(list.size());
		}
		
		System.out.println(fileBoardVO);
		fileBoardService.insert(fileBoardVO);
		return "redirect:/file?p=" + commonVO.getCurrentPage() + "&s=" + commonVO.getPageSize() + "&b=" + commonVO.getBlockSize(); 
	}
	//파일다운로드받기
	@RequestMapping(value="/download")
	public String download(@ModelAttribute CommonVO commonVO,Model model,HttpServletRequest request,
			@RequestParam("of")String of, @RequestParam String sf) {
		logger.info("FileController.download"+commonVO.toString());
		request.setAttribute("of",of);
		request.setAttribute("sf", sf);
		return "download";
	}
	
	

	@RequestMapping(value = "/view")
	public String view(@ModelAttribute CommonVO commonVO, Model model, HttpServletRequest request) {

		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			Integer p = (Integer) flashMap.get("p");
			if (p != null)
				commonVO.setCurrentPage(p);
			Integer s = (Integer) flashMap.get("s");
			if (s != null)
				commonVO.setPageSize(s);
			Integer b = (Integer) flashMap.get("b");
			if (b != null)
				commonVO.setBlockSize(b);
			Integer m = (Integer) flashMap.get("m");
			if (m != null)
				commonVO.setMode(m);
			Integer idx = (Integer) flashMap.get("idx");
			if (idx != null)
				commonVO.setIdx(idx);

		}
		FileBoardVO vo = fileBoardService.selectByIdx(commonVO.getIdx());
		model.addAttribute("vo", vo);
		model.addAttribute("commonVO", commonVO);
		model.addAttribute("newLine", "\n");
		model.addAttribute("br", "<br/>");
		return "view";
	}

	// 수정하기
	@RequestMapping(value = "/update") // 수정하기폼
	public String update(@ModelAttribute CommonVO commonVO, Model model) {
		FileBoardVO vo = fileBoardService.selectByIdx(commonVO.getIdx());
		model.addAttribute("commonVO", commonVO);
		model.addAttribute("vo", vo);
		return "update";
	}

	@RequestMapping(value = "/updateOk") // 수정하기
	public String updateOk(@ModelAttribute FileBoardVO fileBoardVO, @ModelAttribute CommonVO commonVO,
			MultipartHttpServletRequest request)throws IOException, Exception {
				// 파일 받기
				String deleteFiles = request.getParameter("deleteFiles");
				String realPath = request.getRealPath("/upload/");
				List<MultipartFile> files = request.getFiles("files");
				if (files != null && files.size() > 0) { // 파일이 존재 한다면
					List<FileBoardFilesVO> list = new ArrayList<FileBoardFilesVO>();
					for (MultipartFile file : files) {
						if (file != null && file.getSize() > 0) {
							String savedName = UploadFileUtils.uploadFile(realPath, file.getOriginalFilename(),
									file.getBytes());
							FileBoardFilesVO fvo = new FileBoardFilesVO();
							// setter를 불러서 fvo를 채운다.
							fvo.setoFile(file.getOriginalFilename());
							fvo.setsFile(savedName);
							list.add(fvo);
						}
					}
					fileBoardVO.setFileList(list);
					fileBoardVO.setFileCount(list.size());
				}
				// 서비스의 저장하기 호출
				System.out.println(fileBoardVO);
				System.out.println(deleteFiles);
				fileBoardService.update(fileBoardVO, deleteFiles, realPath);
				
				return "redirect:/view?idx="+fileBoardVO.getIdx()+"&p=" + commonVO.getCurrentPage() + "&s=" + commonVO.getPageSize() + "&b=" + commonVO.getBlockSize();	
	}


	// 삭제하기 폼
	@RequestMapping(value = "/delete") // 삭제하기폼
	public String delete(@ModelAttribute CommonVO commonVO, Model model) {
		FileBoardVO vo = fileBoardService.selectByIdx(commonVO.getIdx());
		model.addAttribute("commonVO", commonVO);
		model.addAttribute("vo", vo);
		return "delete";
	}

	// 삭제하기실행
	@RequestMapping(value = "/deleteOk")
	public String deleteOk(@ModelAttribute FileBoardVO fileBoardVO, @ModelAttribute CommonVO commonVO,
			HttpServletRequest request) {
		fileBoardService.delete(fileBoardVO, null);
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("p", commonVO.getCurrentPage());
		map.put("s", commonVO.getPageSize());
		map.put("b", commonVO.getBlockSize());
		map.put("idx", fileBoardVO.getIdx());
		return "redirect:/file?p=" + commonVO.getCurrentPage() + "&s=" + commonVO.getPageSize() + "&b=" + commonVO.getBlockSize(); 
	}
	//===================댓글처리=========================//
	@RequestMapping(value="/CommentInsertOk")
	public String CommentInsertOk(@ModelAttribute CommentVO commentVO,
			             @ModelAttribute CommonVO commonVO,Model model,
			                      HttpServletRequest request) {
		commentVO.setIp(request.getRemoteAddr());
		fileBoardService.commentinsert(commentVO);
		
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("p",commonVO.getCurrentPage());
		map.put("s", commonVO.getPageSize());
		map.put("b",commonVO.getBlockSize());
		map.put("idx",commentVO.getRef());
		map.put("m",0);
		return "redirect:/view";
	}
   //댓글수정
	@RequestMapping(value="/CommentUpdateOk")
    public String commentUpdateOk(@ModelAttribute CommentVO commentVO ,
    		                      @ModelAttribute CommonVO commonVO, Model model, HttpServletRequest request) {
		commentVO.setIp(request.getRemoteAddr());
		fileBoardService.commentupdate(commentVO);
     FlashMap map = RequestContextUtils.getOutputFlashMap(request);
     map.put("p", commonVO.getCurrentPage());
     map.put("s", commonVO.getPageSize());
     map.put("b", commonVO.getBlockSize());
     map.put("idx", commentVO.getRef());
     map.put("m", 0);
     return "redirect:/view";
		
	}
   //댓글삭제
	@RequestMapping(value="/CommentDeleteOk")
	public String commentDeleteOk(@ModelAttribute CommentVO commentVO,@ModelAttribute CommonVO commonVO,
			                      Model model, HttpServletRequest request) {
	 	 fileBoardService.commentdelete(commentVO);
	   FlashMap map = RequestContextUtils.getOutputFlashMap(request);
	   map.put("p", commonVO.getCurrentPage());
	   map.put("s", commonVO.getPageSize());
	   map.put("b", commonVO.getBlockSize());
	   map.put("idx", commentVO.getRef());
	   map.put("m", 0);
	   return "redirect:/view";
	
	}
   

	@RequestMapping(value = "/mypage")
	public String mypage(@ModelAttribute CommonVO commonVO, Model model,FileGuestVO fileGuestVO) {
	  PagingVO<FileGuestVO> pagingVO  = fileGuestService.selectList(commonVO.getCurrentPage(),
			                                                      commonVO.getPageSize(),
			                                                      commonVO.getBlockSize());
        
	model.addAttribute("pagingVO", pagingVO);
	model.addAttribute("commonVO",commonVO);
	model.addAttribute("fileGuestVO",fileGuestVO);
	return "mypage";
	
	}
	
	@RequestMapping(value="guestinsertOk", method = RequestMethod.POST)
	public String guestinsertOk (@ModelAttribute CommonVO commonVO, @ModelAttribute FileGuestVO fileGuestVO,Model model) {
		     fileGuestService.insert(fileGuestVO);
       return "redirect:/mypage";
	}
	@RequestMapping(value="guestupdateOk", method =RequestMethod.POST)
	public String guestupdateOk(@ModelAttribute CommonVO commonVO,@ModelAttribute FileGuestVO fileGuestVO, Model model) {
		fileGuestService.update(fileGuestVO);
		return "redirect:/mypage";
	}
	@RequestMapping(value="guestdeleteOk", method = RequestMethod.POST)
	  public String guestdeleteOk(@ModelAttribute CommonVO commonVO, @ModelAttribute FileGuestVO fileGuestVO, Model model) {
		fileGuestService.delete(fileGuestVO);
		return "redirect:/mypage";
		
	}
	
	
}
