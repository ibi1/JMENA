package kr.co.jmena.www.web.home.saleMng.Ctr;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA012009Ctr {
	
//	@Resource(name = "enaSampleBiz")
//	private EnaSampleBiz enaSampleBiz;
	
	public SA012009Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012009.do")
	public ModelAndView SA012009(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012009");
	}
	
}
