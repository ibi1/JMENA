package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011006Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011006VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011006Ctr {
	
	@Resource(name = "SY011006Biz")
	private SY011006Biz SY011006Biz;
	
	public SY011006Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	/**
	 * @name 공통코드관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011006.do")
	public ModelAndView SY011006(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011006");
	}
	
	/**
	 * sy_bankmst 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListBankMst.do")
	public ModelAndView selectListBankMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011006VO vo = new SY011006VO();
		
		vo.setBANKNAME(request.getParameter("BANKNAME"));
		
		List<SY011006VO> lst = SY011006Biz.selectListBankMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BANKCODE", lst.get(i).getBANKCODE());
			obj.put("BANKNAME", lst.get(i).getBANKNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("AUXCODE", lst.get(i).getAUXCODE());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListBankMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataBankMst.do")
	public ModelAndView insertDataBankMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011006VO vo = new SY011006VO();
		
		vo.setBANKCODE(request.getParameter("BANKCODE"));
		vo.setBANKNAME(request.getParameter("BANKNAME"));
		vo.setUSEYN(request.getParameter("USEYN"));
		vo.setAUXCODE(request.getParameter("AUXCODE"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			
			if (SY011006Biz.selectDataBankMst(vo) == true) { //기존 BANKCODE 있는지 확인
				if (SY011006Biz.insertDataBankMst(vo) == true) {
					resultCode ="SUCCESS";
					resultMsg = "정상적으로 저장하였습니다.";
				 } else {
					 resultCode ="FAILED";
					 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
				 }
			} else {
				resultCode ="FAILED";
				resultMsg = "금융기관 코드가 이미 지정되어 있습니다.";
			}
		} else if ("U".equals(IU_Flag)) {
			if (SY011006Biz.updateDataBankMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]금융기관 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataBankMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
