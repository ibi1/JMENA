package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011005Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011005VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011005Ctr {
	
	@Resource(name = "SY011005Biz")
	private SY011005Biz SY011005Biz;
	
	public SY011005Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	/**
	 * @name 공통코드관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011005.do")
	public ModelAndView SY011005(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011005");
	}
	
	/**
	 * sy_ccodemst 리스크 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListCcodeMst.do")
	public ModelAndView selectListCcodeMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011005VO vo = new SY011005VO();
		
		vo.setCCODENAME(request.getParameter("CCODENAME"));
		
		List<SY011005VO> lst = SY011005Biz.selectListCcodeMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("CCODE", lst.get(i).getCCODE());
			obj.put("CCODENAME", lst.get(i).getCCODENAME());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListCcodeMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * sy_ccodedtl 리스크 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListCcodeDtl.do")
	public ModelAndView selectListCcodeDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011005VO vo = new SY011005VO();
		
		vo.setCCODE(request.getParameter("CCODE"));
		
		List<SY011005VO> lst = SY011005Biz.selectListCcodeDtl(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("DCODE", lst.get(i).getDCODE());
			obj.put("DCODENAME", lst.get(i).getDCODENAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("AUX1", lst.get(i).getAUX1());
			obj.put("AUX1DESC", lst.get(i).getAUX1DESC());
			obj.put("AUX2", lst.get(i).getAUX2());
			obj.put("AUX2DESC", lst.get(i).getAUX2DESC());
			obj.put("AUX3", lst.get(i).getAUX3());
			obj.put("AUX3DESC", lst.get(i).getAUX3DESC());
			obj.put("AUX4", lst.get(i).getAUX4());
			obj.put("AUX4DESC", lst.get(i).getAUX4DESC());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListCcodeDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataCcodeMst.do")
	public ModelAndView insertDataCcodeMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011005VO vo = new SY011005VO();
		
		vo.setCCODE(request.getParameter("S_CCODE"));
		vo.setCCODENAME(request.getParameter("S_CCODENAME_R"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_L");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY011005Biz.insertDataCcodeMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SY011005Biz.updateDataCcodeMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]공통 코드처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataCcodeMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataCcodeDtl.do")
	public ModelAndView insertDataCcodeDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011005VO vo = new SY011005VO();
		
		vo.setCCODE(request.getParameter("CCODE"));
		vo.setDCODE(request.getParameter("DCODE"));
		vo.setDCODENAME(request.getParameter("DCODENAME"));
		vo.setUSEYN(request.getParameter("USEYN"));
		vo.setSORTKEY(request.getParameter("SORTKEY"));
		vo.setREMARK(request.getParameter("REMARK"));
		vo.setAUX1(request.getParameter("AUX1"));
		vo.setAUX1DESC(request.getParameter("AUX1DESC"));
		vo.setAUX2(request.getParameter("AUX2"));
		vo.setAUX2DESC(request.getParameter("AUX2DESC"));
		vo.setAUX3(request.getParameter("AUX3"));
		vo.setAUX3DESC(request.getParameter("AUX3DESC"));
		vo.setAUX4(request.getParameter("AUX4"));
		vo.setAUX4DESC(request.getParameter("AUX4DESC"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_B");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY011005Biz.insertDataCcodeDtl(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SY011005Biz.updateDataCcodeDtl(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]상세 코드 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataCcodeDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
