package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.systemMng.Biz.SY021002Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011005VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY021002Ctr {
	
	@Resource(name = "SY021002Biz")
	private SY021002Biz SY021002Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SY021002Ctr() {}
	
	/**
	 * @name 지사및부서관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY021002.do")
	public ModelAndView SY021002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY021002");
	}

	/**
	 * @name 지사및부서관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaBranchMst.do")
	public ModelAndView selectListEnaBranchMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021002VO vo = new SY021002VO();
		
		vo.setBRANCHNAME(request.getParameter("BRANCHNAME"));
		
		List<SY021002VO> lst = SY021002Biz.selectListEnaBranchMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			//jData.put("id", i+1);
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 지사및부서관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaDeptMst.do")
	public ModelAndView selectListEnaDeptMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021002VO vo = new SY021002VO();
		
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		
		List<SY021002VO> lst = SY021002Biz.selectListEnaDeptMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("DEPTCODE", lst.get(i).getDEPTCODE());
			obj.put("DEPTNAME", lst.get(i).getDEPTNAME());
			obj.put("DEPTGUBUN", lst.get(i).getDEPTGUBUN());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 지사및부서관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/insertEnaBranchMst.do")
	public ModelAndView insertEnaBranchMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021002VO vo = new SY021002VO();
		
		vo.setBRANCHCODE(request.getParameter("RS_BRANCHCODE"));
		vo.setBRANCHNAME(request.getParameter("RS_BRANCHNAME"));
		vo.setUSEYN(request.getParameter("RS_USEYN"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_L");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY021002Biz.insertEnaBranchMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SY021002Biz.updateEnaBranchMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]지사 코드 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertEnaBranchMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 지사및부서관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/insertEnaDeptMst.do")
	public ModelAndView insertEnaDeptMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021002VO vo = new SY021002VO();
		
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		vo.setDEPTCODE(request.getParameter("DEPTCODE"));
		vo.setDEPTNAME(request.getParameter("DEPTNAME"));
		vo.setDEPTGUBUN(request.getParameter("DEPTGUBUN"));
		vo.setSORTKEY(request.getParameter("SORTKEY"));
		vo.setUSEYN(request.getParameter("USEYN"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SY021002Biz.selectDataDeptMst(vo) == 0) {
				if (SY021002Biz.insertEnaDeptMst(vo) == true) {
					resultCode ="SUCCESS";
					resultMsg = "정상적으로 저장하였습니다.";
				 } else {
					 resultCode ="FAILED";
					 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
				 }
			} else {
				resultCode ="FAILED";
				 resultMsg = "[ERROR]이미 다른 지사에 소속되어 있는 부서코드입니다.";
			}
		} else if ("U".equals(IU_Flag)) {
			if (SY021002Biz.updateEnaDeptMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]부서 코드 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertEnaDeptMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
