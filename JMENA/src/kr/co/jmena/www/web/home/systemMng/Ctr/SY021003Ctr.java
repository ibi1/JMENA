package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.systemMng.Biz.SY021003Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021003VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY021003Ctr {
	
	@Resource(name = "SY021003Biz")
	private SY021003Biz SY021003Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SY021003Ctr() {}
	
	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY021003.do")
	public ModelAndView SY021003(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY021003");
	}
	
	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaCityMst.do")
	public ModelAndView selectListEnaCityMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		List<SY021003VO> lst = SY021003Biz.selectListEnaCityMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			//jData.put("id", i+1);
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaCityDtl.do")
	public ModelAndView selectListEnaCityDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		System.out.println("CITYCODE====>"+request.getParameter("CITYCODE"));
		
		List<SY021003VO> lst = SY021003Biz.selectListEnaCityDtl(vo);
		
		System.out.println("lst.size()====>"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("BOROUGHCODE", lst.get(i).getBOROUGHCODE());
			obj.put("BOROUGHNAME", lst.get(i).getBOROUGHNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/insertEnaCityMst.do")
	public ModelAndView insertEnaCityMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		vo.setCITYCODE(request.getParameter("RS_CITYCODE"));
		vo.setCITYNAME(request.getParameter("RS_CITYNAME"));
		vo.setSORTKEY(request.getParameter("RS_SORTKEY"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_L");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY021003Biz.insertEnaCityMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SY021003Biz.updateEnaCityMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]시/도 코드 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertEnaCityMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertEnaCityDtl.do")
	public ModelAndView insertEnaCityDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		vo.setBOROUGHCODE(request.getParameter("BOROUGHCODE"));
		vo.setBOROUGHNAME(request.getParameter("BOROUGHNAME"));
		vo.setUSEYN(request.getParameter("USEYN"));
		vo.setREMARK(request.getParameter("REMARK"));
		vo.setSORTKEY(request.getParameter("SORTKEY"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY021003Biz.insertEnaCityDtl(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SY021003Biz.updateEnaCityDtl(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]시/도/군 코드 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertEnaCityDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
