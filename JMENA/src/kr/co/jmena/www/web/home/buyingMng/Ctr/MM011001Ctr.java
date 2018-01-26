package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.buyingMng.Biz.MM011001Biz;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MM011001Ctr {
	
	@Resource(name = "MM011001Biz")
	private MM011001Biz MM011001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	public MM011001Ctr() {}
	
	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM011001.do")
	public ModelAndView MM011001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/buyingMng/MM011001");
	}

	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaBuyMst.do")
	public ModelAndView selectListEnaBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setLS_BUYDATE_FR(request.getParameter("LS_BUYDATE_FR"));
		vo.setLS_BUYDATE_TO(request.getParameter("LS_BUYDATE_TO"));
		vo.setLS_ADDRESS(request.getParameter("LS_ADDRESS"));
		
		List<MM011001VO> lst = MM011001Biz.selectListEnaBuyMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYDATE", lst.get(i).getBUYDATE());
			obj.put("BUYGUBUN", lst.get(i).getBUYGUBUN());
			obj.put("MANAGENO", lst.get(i).getMANAGENO());
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("BOROUGHCODE", lst.get(i).getBOROUGHCODE());
			obj.put("BOROUGHNAME", lst.get(i).getBOROUGHNAME());
			obj.put("USETYPE", lst.get(i).getUSETYPE());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("OWNERJUMINID", lst.get(i).getOWNERJUMINID());
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYPY", lst.get(i).getBUYPY());
			obj.put("BUNJANM2", lst.get(i).getBUNJANM2());
			obj.put("BUNJANPY", lst.get(i).getBUNJANPY());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			obj.put("PMDANGA", lst.get(i).getPMDANGA());
			obj.put("REGYN", lst.get(i).getREGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
			
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaPayScheduleTb.do")
	public ModelAndView selectListEnaPayScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		
		List<MM011001VO> lst = MM011001Biz.selectListEnaPayScheduleTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYSEQ", lst.get(i).getBUYSEQ());
			obj.put("PAYGUBUN", lst.get(i).getPAYGUBUN());
			obj.put("PAYDATE", lst.get(i).getPAYDATE());
			obj.put("PAYAMT", lst.get(i).getPAYAMT());
			obj.put("PAYYN", lst.get(i).getPAYYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaSalesOpenTb.do")
	public ModelAndView selectListEnaSalesOpenTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		
		List<MM011001VO> lst = MM011001Biz.selectListEnaSalesOpenTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("OPENYN", lst.get(i).getOPENYN());
			obj.put("HOLDINGYN", lst.get(i).getHOLDINGYN());
			obj.put("HOLDINGM2", lst.get(i).getHOLDINGM2());
			obj.put("HOLDINGPY", lst.get(i).getHOLDINGPY());
			obj.put("HOLDINGDATE", lst.get(i).getHOLDINGDATE());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataBuyMst.do")
	public ModelAndView insertDataBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		vo.setBUYDATE(request.getParameter("BUYDATE"));
		vo.setBUYGUBUN(request.getParameter("BUYGUBUN"));
		vo.setMANAGENO(request.getParameter("MANAGENO"));
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		vo.setBOROUGHCODE(request.getParameter("BOROUGHCODE"));
		vo.setUSETYPE(request.getParameter("USETYPE"));
		vo.setADDRESS(request.getParameter("ADDRESS"));
		vo.setOWNERNAME(request.getParameter("OWNERNAME"));
		vo.setOWNERJUMINID(request.getParameter("OWNERJUMINID").replaceAll("-", ""));
		vo.setBUYM2(request.getParameter("BUYM2"));
		vo.setBUYPY(request.getParameter("BUYPY"));
		vo.setBUYAMT(request.getParameter("BUYAMT"));
		vo.setBUYDANGA(request.getParameter("BUYDANGA"));
		vo.setPMDANGA(request.getParameter("PMDANGA"));
		vo.setREGYN(request.getParameter("REGYN"));
		vo.setREGDATE(request.getParameter("REGDATE"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_L");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (MM011001Biz.insertDataBuyMst(vo) == true) {
				json.put("BUYID", vo.getBUYID_PK());
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (MM011001Biz.updateDataBuyMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]매입관리 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataBuyMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/deleteDataBuyMst.do")
	public ModelAndView deleteDataBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (MM011001Biz.deleteAllSalesopenTb(vo) == true) {
			if (MM011001Biz.deleteAllPayScheduleTb(vo) == true) {
				if (MM011001Biz.deleteDataBuyMst(vo) == true) {
					resultCode ="SUCCESS";
					resultMsg = "정상적으로 삭제하였습니다.";
				} else {
					 resultCode ="FAILED";
					 resultMsg = "[ERROR]선택된 매입 삭제 중 오류가 발생하였습니다.";
				}
			} else {
				resultCode ="FAILED";
				resultMsg = "[ERROR]선택된 지급 스케줄 관리 전체 삭제 중 오류가 발생하였습니다.";
			}
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]선택된 지사 오픈 관리 전체 삭제 중 오류가 발생하였습니다.";
		}
		

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataBuyMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/deleteDataPayScheduleTb.do")
	public ModelAndView deleteDataPayScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		vo.setBUYSEQ(request.getParameter("BUYSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (MM011001Biz.deleteDataPayScheduleTb(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataPayScheduleTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/deleteDataSalesopenTb.do")
	public ModelAndView deleteDataSalesopenTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (MM011001Biz.deleteDataSalesopenTb(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataSalesopenTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataPayScheduleTb.do")
	public ModelAndView insertDataPayScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		vo.setBUYSEQ(request.getParameter("BUYSEQ"));
		vo.setPAYGUBUN(request.getParameter("PAYGUBUN"));
		vo.setPAYDATE(request.getParameter("PAYDATE"));
		vo.setPAYAMT(request.getParameter("PAYAMT"));
		vo.setPAYYN(request.getParameter("PAYYN"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R_1");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (MM011001Biz.insertDataPayScheduleTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (MM011001Biz.updateDataPayScheduleTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]지급 스케줄 관리 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataPayScheduleTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataSalesopenTb.do")
	public ModelAndView insertDataSalesopenTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		vo.setOPENYN(request.getParameter("OPENYN"));
		vo.setHOLDINGYN(request.getParameter("HOLDINGYN"));
		vo.setHOLDINGM2(request.getParameter("HOLDINGM2"));
		vo.setHOLDINGPY(request.getParameter("HOLDINGPY"));
		vo.setHOLDINGDATE(request.getParameter("HOLDINGDATE"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R_2");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (MM011001Biz.insertDataSalesopenTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (MM011001Biz.updateDataSalesopenTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]지사를 변경하였거나 수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]지사 오픈관리 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataSalesopenTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/selectSumSaleMst.do")
	public ModelAndView selectSumSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		
		List<MM011001VO> lst = MM011001Biz.selectSumSaleMst(vo);
		
		JSONObject json = new JSONObject();
		
		JSONObject obj = new JSONObject();
		
		obj.put("CONM2", lst.get(0).getCONM2());
		obj.put("CONPY", lst.get(0).getCONPY());
		
		json.put("rows", obj);
		
		logger.debug("[selectSumSaleMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/MM011001_searchPopup.do")
	public ModelAndView MM011001_searchPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/buyingMng/MM011001_searchPopup");
	}
	
	@RequestMapping("/home/selectListMMBuyMstPopup.do")
	public ModelAndView selectListMMBuyMstPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYDATE(request.getParameter("BUYDATE"));
		
		List<MM011001VO> lst = MM011001Biz.selectListMMBuyMstPopup(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYDATE", lst.get(i).getBUYDATE());
			obj.put("BUYGUBUN", lst.get(i).getBUYGUBUN());
			obj.put("MANAGENO", lst.get(i).getMANAGENO());
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("BOROUGHCODE", lst.get(i).getBOROUGHCODE());
			obj.put("BOROUGHNAME", lst.get(i).getBOROUGHNAME());
			obj.put("USETYPE", lst.get(i).getUSETYPE());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("OWNERJUMINID", lst.get(i).getOWNERJUMINID());
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYPY", lst.get(i).getBUYPY());
			obj.put("BUNJANM2", lst.get(i).getBUNJANM2());
			obj.put("BUNJANPY", lst.get(i).getBUNJANPY());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			obj.put("REGYN", lst.get(i).getREGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
			
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaBuyMstPopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
