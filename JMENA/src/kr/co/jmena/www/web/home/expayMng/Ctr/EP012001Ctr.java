package kr.co.jmena.www.web.home.expayMng.Ctr;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EP012001Ctr {
	
//	@Resource(name = "enaSampleBiz")
//	private EnaSampleBiz enaSampleBiz;
	
	public EP012001Ctr() {}
	
	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012001.do")
	public ModelAndView EP012001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP012001");
	}
	
}
