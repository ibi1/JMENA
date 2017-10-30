package kr.co.jmena.www.web.common.Ctr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorCtr {

	public ErrorCtr() {}
	
	@RequestMapping("/common/error.do")
	public ModelAndView error(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView view = new ModelAndView();

		return view;
	}
}
