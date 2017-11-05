package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011004Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011004VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011004Ctr {

	@Resource(name = "SY011004Biz")
	private SY011004Biz SY011004Biz;
	
	public SY011004Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());

	/**
	 * @name 사용자권한관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011004.do")
	public ModelAndView SY011004(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011004");
	}
	
	/**
	 * sy_userMst 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListUserMst4.do")
	public ModelAndView selectListUserMst4(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011004VO vo = new SY011004VO();
		
		vo.setUSERGUBUN(request.getParameter("USERGUBUN"));
		vo.setUSERNAME(request.getParameter("USERNAME"));
		
		List<SY011004VO> lst = SY011004Biz.selectListUserMst4(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("USERID", lst.get(i).getUSERID());
			obj.put("USERNAME", lst.get(i).getUSERNAME());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListUserMst4]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/selectListUserPgmAuthTb.do")
	public ModelAndView selectListUserPgmAuthTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011004VO vo = new SY011004VO();
		
		vo.setUSERID(request.getParameter("USERID"));
		vo.setSYSID(request.getParameter("SYSID"));
		vo.setMENUID(request.getParameter("MENUID"));
		
		List<SY011004VO> lst = SY011004Biz.selectListUserPgmAuthTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("SYSID", lst.get(i).getSYSID());
			obj.put("SYSNAME", lst.get(i).getSYSNAME());
			obj.put("MENUID", lst.get(i).getMENUID());
			obj.put("MENUNAME", lst.get(i).getMENUNAME());
			obj.put("PGMID", lst.get(i).getPGMID());
			obj.put("PGMNAME", lst.get(i).getPGMNAME());
			obj.put("AUTH_S", lst.get(i).getAUTH_S());
			obj.put("AUTH_I", lst.get(i).getAUTH_I());
			obj.put("AUTH_U", lst.get(i).getAUTH_U());
			obj.put("AUTH_D", lst.get(i).getAUTH_D());
			obj.put("AUTH_P", lst.get(i).getAUTH_P());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListUserMst4]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataUserPgmAuthTb.do")
	public ModelAndView insertDataUserPgmAuthTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SY011004Biz.insertDataUserPgmAuthTb(request) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 저장하였습니다.";
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]사용자 별 권한 저장 중 오류가 발생하였습니다.";
		}
		
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataUserMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
