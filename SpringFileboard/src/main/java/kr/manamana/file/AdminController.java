package kr.manamana.file;

import java.security.Principal;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.javassist.compiler.ast.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.manamana.file.service.MemberService;
import kr.manamana.file.vo.CommonVO;
import kr.manamana.file.vo.MemberRoleVO;
import kr.manamana.file.vo.MemberVO;
import kr.manamana.file.vo.PagingVO;
import kr.manamana.file.vo.TodoListVO;

@Controller
public class AdminController {
	// ---------admin로그인----------------
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Autowired
	MemberService memberService;

	@RequestMapping(value = "/admin/", method = RequestMethod.GET)
	public String admin(Locale locale, Model model, Principal principal, HttpServletRequest request) {
		logger.info("Welcome Admin Home!");
		if (principal != null) {
			MemberVO vo = memberService.selectById(principal.getName());
			logger.info("home principal: " + principal.getName());
			logger.info("home vo: " + vo);
			request.getSession().setAttribute("vo", vo);
		}
		return "admin/admin";
	}

	@RequestMapping(value = "/admin/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);
			model.addObject("username", userDetail.getUsername());
		}
		model.setViewName("/403");
		return model;

	}

	@RequestMapping(value = "/memberList")
	public String MemberList(@ModelAttribute CommonVO commonVO, Model model) {
		PagingVO<MemberVO> pagingVO = memberService.selectList(commonVO.getCurrentPage(), commonVO.getPageSize(),
				commonVO.getBlockSize());

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("commonVO", commonVO);

		return "memberList";
	}
}
