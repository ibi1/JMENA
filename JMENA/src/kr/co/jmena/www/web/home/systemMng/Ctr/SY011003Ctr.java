package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011003Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011002VO;
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
	
	/**
	 * 사용자 저장/수정 후 저장일 경우는 권한도 자동 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/insertDataUserMst.do")
	public ModelAndView insertDataUserMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011003VO vo = new SY011003VO();
		
		vo.setUSERID(request.getParameter("S_USERID"));
		vo.setPASSWORD(request.getParameter("S_PASSWORD"));
		vo.setUSERNAME(request.getParameter("S_USERNAME_R"));
		vo.setUSEYN(request.getParameter("S_USEYN"));
		vo.setUSERGUBUN(request.getParameter("S_USERGUBUN"));
		vo.setPHONENO(request.getParameter("S_PHONENO"));
		vo.setMOBILENO(request.getParameter("S_MOBILENO"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERIDSESSION((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY011003Biz.insertDataUserMst(vo) == true) {
				if (SY011003Biz.insertDataUserSysTb(vo) == true) {
					if (SY011003Biz.insertDataUserPgmAuthTb(vo) == true) {
						resultCode ="SUCCESS";
						resultMsg = "정상적으로 저장하였습니다.";
					} else {
						resultCode ="FAILED";
						resultMsg = "[ERROR]사용자 프로그램 권한 저장 중 오류가 발생하였습니다.";
					}
				 } else {
					 resultCode ="FAILED";
					 resultMsg = "[ERROR]사용자 시스템 권한 저장 중 오류가 발생하였습니다.";
				 }
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]사용자 저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SY011003Biz.updateDataUserMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]사용자 수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]사용자 관리 저장/수정 중 오류가 발생했습니다.";
		}
		
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataUserMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * 사용자 시스템 권한을 수정한다.
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/updateDataUserSysTb.do")
	public ModelAndView updateDataUserSysTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011003VO vo = new SY011003VO();
		
		vo.setSYSID(request.getParameter("SYSID"));
		vo.setUSERID(request.getParameter("USERID"));
		vo.setAUTH_YN(request.getParameter("AUTH_YN"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERIDSESSION((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		if (SY011003Biz.updateDataUserSysTb(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 권한을 수정하였습니다.";
		 } else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]권한 수정 중 오류가 발생하였습니다.";
		 }
	
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[updateDataUserSysTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
