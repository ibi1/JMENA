package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.saleMng.Biz.SA011004Biz;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SA011004Ctr {

	@Resource(name = "SA011004Biz")
	private SA011004Biz SA011004Biz;
	
	/**
	 * @name (신)입금관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011004.do")
	public ModelAndView SA011004(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/saleMng/SA011004");
	}
	
	/**
	 * @name (신)입금관리 화면 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/selectListIpgumMst.do")
	public ModelAndView selectListIpgumMst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = new ArrayList<Map<String, Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		lst = SA011004Biz.selectListIpgumMst(param);
		
		resultMap.put("rows", lst);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)입금관리 화면 : 담당자 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/selectOneInsamst.do")
	public ModelAndView selectOneInsamst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = new ArrayList<Map<String, Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		lst = SA011004Biz.selectOneInsamst(param);
		
		resultMap.put("rows", lst);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)입금관리 화면 : 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/insertIpgumMst.do")
	public ModelAndView insertIpgumMst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		int cnt = 0;
		String msg = "error";
		HttpSession session = null;
		session = request.getSession(false);
		String userId = (String) session.getAttribute("userId");
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		param.put("USERID", userId);
		
		cnt = SA011004Biz.insertIpgumMst(param);
		
		if(cnt > 0) msg = "success";
		
		msgMap.put("MSG", msg);
		resultMap.put("rows",  msgMap);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)입금관리 화면 : 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/updateIpgumMst.do")
	public ModelAndView updateIpgumMst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		int cnt = 0;
		String msg = "error";
		HttpSession session = null;
		session = request.getSession(false);
		String userId = (String) session.getAttribute("userId");
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		param.put("USERID", userId);
		
		cnt = SA011004Biz.updateIpgumMst(param);
		
		if(cnt > 0) msg = "success";
		
		msgMap.put("MSG", msg);
		resultMap.put("rows",  msgMap);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)입금관리 화면 : 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/deleteIpgumMst.do")
	public ModelAndView deleteIpgumMst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		int cnt = 0;
		String msg = "error";
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		cnt = SA011004Biz.deleteIpgumMst(param);
		
		if(cnt > 0) msg = "success";
		
		msgMap.put("MSG", msg);
		resultMap.put("rows",  msgMap);
		
		return new ModelAndView("jsonView", resultMap);
	}		
}
