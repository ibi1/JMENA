package kr.co.jmena.www.web.home.main.Ctr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.common.util.LoginCheckInterceptor;
import kr.co.jmena.www.web.home.main.Biz.MainBiz;
import kr.co.jmena.www.web.home.main.Vo.MainVO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MainCtr {
	
	@Resource(name = "mainBiz")
	private MainBiz mainBiz;
	
	public MainCtr() {}
	
	@RequestMapping("/")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView();
		
		view.setViewName("/index.do");
		return view;
	}
	
	/**
	 * index
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/index.do")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView();
		
		return view;
	}
	
	/**
	 * @name 로그인
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/login.do")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = null;
		Map<String, String> sessionMap = new HashMap<String, String>();
		
		JSONObject json = new JSONObject();
		
		String userId = request.getParameter("USERID");
		String password = request.getParameter("PASSWORD");
		
		MainVO vo = new MainVO();
		
		vo.setUSERID(userId);
		vo.setPASSWORD(password);
		
		List<MainVO> lst = mainBiz.selectUserInfo(vo);
		
		if (lst.size() == 1) {			
			session = request.getSession(true);
			session.setMaxInactiveInterval(3600);
			session.setAttribute("userId", lst.get(0).getUSERID());
			session.setAttribute("userName", lst.get(0).getUSERNAME());
			session.setAttribute("userGubun", lst.get(0).getUSERGUBUN());
			
			json.put("ReturnMsg", "SUCCESS");
		} else {
			json.put("ReturnMsg", "FAILED");
		}
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/main.do")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/main/MAIN");
	}
	
	@RequestMapping("/home/systemMenu.do")
	public ModelAndView systemMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MainVO vo = new MainVO();
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		vo.setUSERGUBUN((String)session.getAttribute("userGubun"));
		
		List<MainVO> lst = mainBiz.selectSystemMenu(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			//System.out.println(lst.get(i).getSYSID());
			JSONObject jData = new JSONObject();
			jData.put("SYSID", lst.get(i).getSYSID());
			jData.put("SYSNAME", lst.get(i).getSYSNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("systemMenu", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/treeMenu.do")
	public ModelAndView treeMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MainVO vo = new MainVO();
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		vo.setUSERGUBUN((String)session.getAttribute("userGubun"));
		vo.setSYSID(request.getParameter("SYSID"));
		
		String[] strArr = mainBiz.selectTreeMenu(vo);
		
		JSONObject json = new JSONObject();
		json.put("tree", strArr[0]);
		json.put("pgmFirst", strArr[1]);
		
		return new ModelAndView("jsonView", json);
	}
}
