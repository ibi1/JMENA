package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.personMng.Biz.HR012003Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012003VO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR012003Ctr {
	
	@Resource(name = "HR012003Biz")
	private HR012003Biz HR012003Biz;
	
	public HR012003Ctr() {}
	

	/**
	 * @name 인원자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012003.do")
	public ModelAndView HR012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012003");
	}
	
}
