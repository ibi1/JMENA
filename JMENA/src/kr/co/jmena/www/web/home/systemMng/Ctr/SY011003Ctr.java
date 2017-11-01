package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011003Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011003VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011003Ctr {
	
	@Resource(name = "SY011003Biz")
	private SY011003Biz SY011003Biz;
	
	public SY011003Ctr() {}

	protected final Logger logger = Logger.getLogger(getClass());

	/**
	 * @name 사용자관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011003.do")
	public ModelAndView SY011003(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011003");
	}
	
	/**
	 * sy_usermst 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListUserMst.do")
	public ModelAndView selectListUserMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011003VO vo = new SY011003VO();
		
		vo.setUSERNAME(request.getParameter("USERNAME"));
		
		List<SY011003VO> lst = SY011003Biz.selectListUserMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("USERID", lst.get(i).getUSERID());
			obj.put("PASSWORD", lst.get(i).getPASSWORD());
			obj.put("USERNAME", lst.get(i).getUSERNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("USERGUBUN", lst.get(i).getUSERGUBUN());
			obj.put("PHONENO", lst.get(i).getPHONENO());
			obj.put("MOBILENO", lst.get(i).getMOBILENO());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListUserMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * sy_usersystb 리스크 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListUserSysTb.do")
	public ModelAndView selectListUserSysTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011003VO vo = new SY011003VO();
		
		vo.setUSERID(request.getParameter("USERID"));
		
		List<SY011003VO> lst = SY011003Biz.selectListUserSysTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SYSID", lst.get(i).getSYSID());
			obj.put("SYSNAME", lst.get(i).getSYSNAME());
			obj.put("AUTH_YN", lst.get(i).getAUTH_YN());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListUserSysTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/selectTest.do")
	public ModelAndView selectTest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<String> list = new ArrayList<String>();
		
		

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
			JSONObject obj1 = new JSONObject();
			obj1.put("VALUE", "Y");
			obj1.put("LABEL", "Y");
			jCell.add(0, obj1);
			
			JSONObject obj2 = new JSONObject();
			obj2.put("VALUE", "N");
			obj2.put("LABEL", "N");
			jCell.add(1, obj2);
			
			JSONObject obj3 = new JSONObject();
			obj3.put("VALUE", "001");
			obj3.put("LABEL", "OK1");
			jCell.add(2, obj3);
			
			JSONObject obj4 = new JSONObject();
			obj4.put("VALUE", "002");
			obj4.put("LABEL", "OK2");
			jCell.add(3, obj4);
			
			JSONObject obj5 = new JSONObject();
			obj5.put("VALUE", "003");
			obj5.put("LABEL", "OK3");
			jCell.add(4, obj5);
		
		json.put("rows", jCell);
		
		logger.debug("[test]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
