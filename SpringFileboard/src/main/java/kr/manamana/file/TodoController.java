package kr.manamana.file;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.manamana.file.service.TodoListService;
import kr.manamana.file.vo.CommonVO;
import kr.manamana.file.vo.PagingVO;
import kr.manamana.file.vo.TodoListVO;


@Controller
public class TodoController {
	@InitBinder
    protected void initBinder(WebDataBinder binder){
        DateFormat  dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
    }
	
	
	@Autowired
	private TodoListService todoListService;
	
	private static final Logger logger = LoggerFactory.getLogger(TodoController.class);
	
	
	@RequestMapping(value = "/Todolist")
	public String TodoList(@ModelAttribute CommonVO commonVO, Model model,TodoListVO todoListVO) {
	  PagingVO<TodoListVO> pagingVO  = todoListService.selectList(commonVO.getCurrentPage(), 
			                                                        commonVO.getPageSize(), 
			                                                        commonVO.getBlockSize());
		  
	  
	   model.addAttribute("pagingVO", pagingVO);
	    model.addAttribute("commonVO",commonVO);
	   model.addAttribute("todoListVO",todoListVO);
	     return "Todolist";
	}
	
	
	
  
	
	@RequestMapping(value="/add")  //add에서 날짜를 받아올때는 자바를 이용해서 현재시간을 받아올수있다
	public String add(@ModelAttribute CommonVO commonVO, Model model) {
		logger.info("HomeController.insert" + commonVO.toString());
		model.addAttribute("commonVO", commonVO);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		model.addAttribute("regDate", sdf.format(date));
		return "add";
	}

	//add.jsp
	@RequestMapping(value = "/addinsertOk", method = RequestMethod.POST)
	public String addinsertOk(@ModelAttribute CommonVO commonVO, @ModelAttribute TodoListVO todoListVO, Model model) {
		 logger.info(todoListVO.toString());	
		todoListService.insert(todoListVO);
		return "redirect:/Todolist";
	}	
	
	
	//update
	@RequestMapping(value = "/todoupdate", method = RequestMethod.POST)
	public String todoupdate(@ModelAttribute CommonVO commonVO, Model model) {
		logger.info("HomeController.update" + commonVO.toString());
		model.addAttribute("commonVO", commonVO);
		model.addAttribute("vo", todoListService.selectByIdx(commonVO.getIdx()));
		return "todoupdate";
	}

	
	@RequestMapping(value = "/todoupdateOk" , method = RequestMethod.POST)
	public String todoupdateOk(@ModelAttribute CommonVO commonVO, @ModelAttribute TodoListVO todoListVO, Model model) {
		 logger.info(todoListVO.toString());	
		todoListService.update(todoListVO);
		return "redirect:/Todolist";
	}
   @RequestMapping(value = "/tododelete", method = RequestMethod.POST)
	public String tododelete(@ModelAttribute CommonVO commonVO, Model model) {
		logger.info("HomeController.update" + commonVO.toString());
		model.addAttribute("commonVO", commonVO);
		model.addAttribute("vo", todoListService.selectByIdx(commonVO.getIdx()));
	    return "tododelete";
	}
   @RequestMapping(value = "/tododeleteOk", method = RequestMethod.POST)
  	public String tododeleteOk(@ModelAttribute CommonVO commonVO, Model model, @ModelAttribute TodoListVO todoListVO ) {
  	    todoListService.delete(todoListVO);
  		return "redirect:/Todolist";
  	}
}
