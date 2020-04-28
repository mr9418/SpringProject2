package kr.manamana.file.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.manamana.file.service.TestService;
import kr.manamana.file.vo.TestVO;






@Controller
public class TestController {

	@Autowired
	private TestService testService;
	
	@RequestMapping(value="/testVO")
	@ResponseBody
	public TestVO testObject() {
		return new TestVO(1,"한사람",22);
	}
	
	@RequestMapping(value="/testText" , produces="text/plain;charset=utf-8")
	@ResponseBody
	public String testText() {
		return "한글qwerty`12345!@#$%";
	}

	@RequestMapping(value="/testDB")
	public String testDB(Model model) {
		model.addAttribute("today", testService.today());
		model.addAttribute("mul", testService.mul(12,34));
		model.addAttribute("sum", testService.sum(1,2,3));
		return "testDB";
	}
	
	//리다이렉트시 POST전송하기
	@RequestMapping("/redirect")
	public String redirectnewpage(RedirectAttributes redirectAttributes){
	    Map<String, Object> map = new HashMap<String,Object>();
	    map.put("key1", "value1");
	    map.put("key2", "value2");
	    redirectAttributes.addFlashAttribute("vo", map);
	    return "redirect:/herepage";
	}
	
	@RequestMapping(value = "/herepage", method = RequestMethod.POST)
	public String herepagePost(){
	    return "herepagePost";
	}
	@RequestMapping(value = "/herepage", method = RequestMethod.GET)
	public String herepageGET(){
		return "herepageGET";
	}

	
	
}
	
