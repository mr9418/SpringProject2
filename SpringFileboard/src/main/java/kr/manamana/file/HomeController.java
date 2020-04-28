package kr.manamana.file;

import java.io.IOException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.manamana.file.service.FileBoardService;
import kr.manamana.file.service.FileGuestService;
import kr.manamana.file.service.MemberService;
import kr.manamana.file.service.TodoListService;
import kr.manamana.file.service.UploadFileUtils;
import kr.manamana.file.vo.CommentVO;
import kr.manamana.file.vo.CommonVO;
import kr.manamana.file.vo.FileBoardFilesVO;
import kr.manamana.file.vo.FileBoardVO;
import kr.manamana.file.vo.FileGuestVO;
import kr.manamana.file.vo.MemberVO;
import kr.manamana.file.vo.PagingVO;
import kr.manamana.file.vo.TodoListVO;





@Controller
public class HomeController {
	@Autowired
	private MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//Intro페이지
		@RequestMapping(value = "/")
		public String home2(Principal principal, Model model, HttpServletRequest request) {
			if(principal != null) {
				MemberVO vo = memberService.selectById(principal.getName());
				logger.info("home principal: "+ principal.getName());
				logger.info("home vo: "+ vo);
				request.getSession().setAttribute("vo", vo);
			}
			return "home";
		}
}
