package kr.manamana.file;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.manamana.file.service.MemberService;
import kr.manamana.file.vo.MemberVO;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	   //===========================로그인===================================
	
		@RequestMapping(value="/getCount")
		public String getCount(Model model) {
			model.addAttribute("count", memberService.getCount());
			return "getCount";
		}
		
		@RequestMapping(value="/login")
		public String login(HttpServletRequest request, Model model) {
			//쿠키를 읽자
			Cookie[] cookies = request.getCookies();//request해서 가져온쿠키들을 쿠키배열에 집어넣는다
			if(cookies!=null && cookies.length>0) {//쿠키가 null이 아니거나 쿠키들이 0보다크다면
				for(Cookie cookie : cookies) {//for문을 돌린다
					if(cookie.getName().equals("usrid")) {//만약에 쿠키에서가져온name이 userid와 같다면
						model.addAttribute("usrid",cookie.getValue()); // 쿠키는 userid값을가진다
						break;
					}
				}
			}
			return "login"; //로그인으로 돌아옴 
		}
		
		@RequestMapping(value="/join")
		public String join() {
			return "join"; 
		}
		@RequestMapping(value="/joinOk", method =RequestMethod.GET)
		public String joinOkGET() {
			return "redirect:login";
		}
		@RequestMapping(value="/joinOk", method =RequestMethod.POST)
		public String joinOkPOST(@ModelAttribute MemberVO memberVO) {
			System.out.println(memberVO+"**********joinOkPOST*********");
			//서비스를 호출해서 DB에 저장
			memberVO.setPassword(this.bCryptPasswordEncoder.encode(memberVO.getPassword()));
			memberService.insert(memberVO);
			return "redirect:login";
		}
		@RequestMapping(value="/viewConfirm")
		public String confirm(@RequestParam String userid) {
			System.out.println(userid+"**********confirm*********");
			//서비스를 호출해서 회원인증
			memberService.confirm(userid);
			return "redirect:login";
		}
		@RequestMapping(value="/idCheck")
		@ResponseBody
		public String idCheck(@RequestParam String userid) {
			System.out.println(userid+"**********idCheck*********");
			//서비스를 호출해서 아이디중복검사
			String result = memberService.idCheck(userid);
			return result;
		}
		@RequestMapping(value="/idSearch")
		public String idSearch() {
			return "idSearch";
		}
		
		@RequestMapping(value="/idSearchOk", method = RequestMethod.GET)
			public String idSearchOkGET() {
				return "redirect:login";				
			}
		
		
		@RequestMapping(value="/idSearchOk", method = RequestMethod.POST)
		public String idSearchOkPOST(@ModelAttribute MemberVO memberVO, Model model) {
			System.out.println(memberVO+"**************idSearchOkPOST****************");
			//서비스를 호출해서 로그인확인
			MemberVO vo = memberService.idSearch(memberVO);
			if(vo==null) { //vo가 없으면 idSearch화면으로 돌아가고
				return "redirect:/idSearch";
			}else {
				model.addAttribute("vo",vo); //그렇지않으면 vo를넘겨줘서
				return "viewUserID"; //아이디가뭔지볼수있게해준다
			}
		}
	
}		