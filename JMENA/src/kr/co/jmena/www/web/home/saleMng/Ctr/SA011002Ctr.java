package kr.co.jmena.www.web.home.saleMng.Ctr;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA011002Ctr {
	
//	@Resource(name = "enaSampleBiz")
//	private EnaSampleBiz enaSampleBiz;
	
	public SA011002Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011002.do")
	public ModelAndView SA011002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011002");
	}
	
}
