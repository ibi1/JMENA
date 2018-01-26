package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA011005Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011005VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA011005Ctr {
	
	@Resource(name = "SA011005Biz")
	private SA011005Biz SA011005Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA011005Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005.do")
	public ModelAndView SA011005(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011005");
	}
	
	/**
	 * 해약여부 확인
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005_selectDataSaleHistoryTb004.do")
	public ModelAndView selectDataSaleHistoryTb004(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		int cnt = SA011005Biz.selectDataSaleHistoryTb004(vo);
		
		JSONObject json = new JSONObject();
		
		String resultMsg = (cnt > 0) ? "Y" : "N";
		
		json.put("resultMsg", resultMsg);
		
		logger.debug("[selectDataSaleHistoryTb004]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005_selectListEanSaleMst.do")
	public ModelAndView selectListEanSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSL_SALEDATE_FR(request.getParameter("SL_SALEDATE_FR"));
		vo.setSL_SALEDATE_TO(request.getParameter("SL_SALEDATE_TO"));
		/*vo.setSALERCD(request.getParameter("SL_SALERNAME"));*/			//담당자
		vo.setADDRESS(request.getParameter("SL_ADDRESS"));
		vo.setSL_CANCELYN(request.getParameter("SL_CANCELYN"));
		vo.setSL_KNAME(URLDecoder.decode(request.getParameter("SL_KNAME"), "UTF-8"));
		
		List<SA011005VO> lst = SA011005Biz.selectListEanSaleMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("MANAGENO", lst.get(i).getMANAGENO());
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("OWNERJUMINID", lst.get(i).getOWNERJUMINID());
			obj.put("CONBM2", lst.get(i).getCONBM2());
			obj.put("CONJM2", lst.get(i).getCONJM2());
			obj.put("CONBPY", lst.get(i).getCONBPY());
			obj.put("CONJPY", lst.get(i).getCONJPY());
			obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
			obj.put("SALERCD", lst.get(i).getSALERCD());
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONJUMINID", lst.get(i).getCONJUMINID());
			obj.put("CONADDRESS", lst.get(i).getCONADDRESS());
			obj.put("CONTELNO", lst.get(i).getCONTELNO());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("SALEAMT", lst.get(i).getSALEAMT());
			obj.put("SALEDANGA", lst.get(i).getSALEDANGA());
			obj.put("DCGUBUN", lst.get(i).getDCGUBUN());
			obj.put("DCRATE", lst.get(i).getDCRATE());
			obj.put("DCAMT", lst.get(i).getDCAMT());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("PMDANGA", lst.get(i).getPMDANGA());
			obj.put("AGENCYAMT", lst.get(i).getAGENCYAMT());
			obj.put("JOINYN", lst.get(i).getJOINYN());
			obj.put("REGYN", lst.get(i).getREGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("CANCELYN", lst.get(i).getCANCELYN());
			obj.put("CANCELDATE", lst.get(i).getCANCELDATE());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			obj.put("SALERNAME", lst.get(i).getSALERNAME());
			
			jCell.add(obj);
			
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListEanSaleMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_insertDataSaleMst.do")
	public ModelAndView insertDataSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		//mst
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setSALEDATE(request.getParameter("SALEDATE"));
		vo.setSALEGUBUN(request.getParameter("SALEGUBUN"));
		vo.setSALERCD(request.getParameter("SALERCD"));
		vo.setBUYID(request.getParameter("MANAGENO"));
		vo.setMANAGENO(request.getParameter("MANAGENO"));
		vo.setCONNAME(request.getParameter("CONNAME"));
		vo.setCONJUMINID(request.getParameter("CONJUMINID").replaceAll("-", ""));
		vo.setCONADDRESS(request.getParameter("CONADDRESS"));
		vo.setCONTELNO(request.getParameter("CONTELNO"));
		vo.setCONM2(request.getParameter("CONM2"));
		vo.setCONPY(request.getParameter("CONPY"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		//dtl
		vo.setSALEAMT(request.getParameter("SALEAMT"));
		vo.setSALEDANGA(request.getParameter("SALEDANGA"));
		vo.setDCGUBUN(request.getParameter("DCGUBUN"));
		vo.setDCRATE(request.getParameter("DCRATE"));
		vo.setDCAMT(request.getParameter("DCAMT"));
		vo.setSELLAMT(request.getParameter("SELLAMT"));
		vo.setAGENCYAMT(request.getParameter("AGENCYAMT"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_L");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SA011005Biz.insertDataSaleMst(vo) == true) {
				json.put("SALEID", vo.getSALEID_PK());
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SA011005Biz.updateDataSaleMst(vo) == true) {
				json.put("SALEID", vo.getSALEID());
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]매출관리 처리 중 오류가 발생했습니다.";
		}
		
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataSaleMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_deleteDataSaleMst.do")
	public ModelAndView deleteDataSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SA011005Biz.deleteAllSaleHistoryTb(vo) == true) {
			if (SA011005Biz.deleteAllJointnameTb(vo) == true) {
				if (SA011005Biz.deleteAllIpgumScheduleTb(vo) == true) {
					if (SA011005Biz.deleteDataSaleDtl(vo) == true) {
						if (SA011005Biz.deleteDataSaleMst(vo) == true) {
							resultCode ="SUCCESS";
							resultMsg = "정상적으로 삭제하였습니다.";
						} else {
							resultCode ="FAILED";
							 resultMsg = "[ERROR]선택된 매출 삭제 중 오류가 발생하였습니다.";
						}
					} else {
						 resultCode ="FAILED";
						 resultMsg = "[ERROR]선택된 매출 상세 삭제 중 오류가 발생하였습니다.";
					}
				} else {
					resultCode ="FAILED";
					resultMsg = "[ERROR]선택된 입금 스케줄 관리 전체 삭제 중 오류가 발생하였습니다.";
				}
			} else {
				resultCode ="FAILED";
				resultMsg = "[ERROR]선택된 등기 관리 전체 삭제 중 오류가 발생하였습니다.";
			}
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]계약 변동 관리 전체 삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataSaleMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * 입금 스케줄 관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005_selectListEnaIpgumScheduleTb.do")
	public ModelAndView selectListEnaIpgumScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		List<SA011005VO> lst = SA011005Biz.selectListEnaIpgumScheduleTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("IPGUMSEQ", lst.get(i).getIPGUMSEQ());
			obj.put("DEPOSITGUBUN", lst.get(i).getDEPOSITGUBUN());
			obj.put("DEPOSITDATE", lst.get(i).getDEPOSITDATE());
			obj.put("DEPOSITAMT", lst.get(i).getDEPOSITAMT());
			obj.put("DEPOSITYN", lst.get(i).getDEPOSITYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("IPGUMID", lst.get(i).getIPGUMID());
			obj.put("SEQ", lst.get(i).getSEQ());
			obj.put("SUGUMAMT", lst.get(i).getSUGUMAMT());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaIpgumScheduleTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_insertDataEnaIpgumScheduleTb.do")
	public ModelAndView insertDataEnaIpgumScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();

		vo.setSALEID(request.getParameter("SALEID"));
		vo.setIPGUMSEQ(request.getParameter("IPGUMSEQ"));
		vo.setDEPOSITGUBUN(request.getParameter("DEPOSITGUBUN"));
		vo.setDEPOSITDATE(request.getParameter("DEPOSITDATE"));
		vo.setDEPOSITAMT(request.getParameter("DEPOSITAMT"));
		vo.setDEPOSITYN(request.getParameter("DEPOSITYN"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R_1");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SA011005Biz.insertDataEnaIpgumScheduleTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SA011005Biz.updateDataEnaIpgumScheduleTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]입금 스케줄 관리 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataEnaIpgumScheduleTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	@RequestMapping("/home/SA011005_deleteDataEnaIpgumScheduleTb.do")
	public ModelAndView deleteDataEnaIpgumScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setIPGUMSEQ(request.getParameter("IPGUMSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SA011005Biz.deleteDataEnaIpgumScheduleTb(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataEnaIpgumScheduleTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * 등기 관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005_selectListEnaJointNameTb.do")
	public ModelAndView selectListEnaJointNameTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		List<SA011005VO> lst = SA011005Biz.selectListEnaJointNameTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("JOINTSEQ", lst.get(i).getJOINTSEQ());
			obj.put("JOINTNAME", lst.get(i).getJOINTNAME());
			obj.put("JOINTJUMINID", lst.get(i).getJOINTJUMINID());
			obj.put("JOINTTELNO", lst.get(i).getJOINTTELNO());
			obj.put("OCCUM2", lst.get(i).getOCCUM2());
			obj.put("OCCUPY", lst.get(i).getOCCUPY());
			obj.put("SALEAMT", lst.get(i).getSALEAMT());
			obj.put("SELLDANGA", lst.get(i).getSELLDANGA());
			obj.put("DCGUBUN", lst.get(i).getDCGUBUN());
			obj.put("DCRATE", lst.get(i).getDCRATE());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("PAPERREGYN", lst.get(i).getPAPERREGYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaJointNameTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_insertDataEnaJointNameTb.do")
	public ModelAndView insertDataEnaJointNameTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setJOINYN(request.getParameter("JOINYN"));
		vo.setREGYN(request.getParameter("REGYN"));
		vo.setREGDATE(request.getParameter("REGDATE"));
		vo.setJOINTNAME(request.getParameter("JOINTNAME"));
		
		if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
			vo.setJOINTSEQ(request.getParameter("JOINTSEQ"));
			vo.setJOINTJUMINID(request.getParameter("JOINTJUMINID").replaceAll("-", ""));
			vo.setJOINTTELNO(request.getParameter("JOINTTELNO"));
			vo.setOCCUM2(request.getParameter("OCCUM2"));
			vo.setOCCUPY(request.getParameter("OCCUPY"));
			vo.setSALEAMT(request.getParameter("SALEAMT"));
			vo.setSELLDANGA(request.getParameter("SELLDANGA"));
			vo.setDCGUBUN(request.getParameter("DCGUBUN"));
			vo.setDCRATE(request.getParameter("DCRATE"));
			vo.setSELLAMT(request.getParameter("SELLAMT"));
			vo.setPAPERREGYN(request.getParameter("PAPERREGYN"));
			vo.setREMARK(request.getParameter("REMARK"));
		}
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R_2");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SA011005Biz.insertDataEnaJointNameTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SA011005Biz.updateDataEnaJointNameTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]등기 관리 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataEnaIpgumScheduleTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_deleteDataEnaJointNameTb.do")
	public ModelAndView deleteDataEnaJointNameTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setJOINTSEQ(request.getParameter("JOINTSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SA011005Biz.deleteDataEnaJointNameTb(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataEnaJointNameTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * 계약변동관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005_selectListEnaSaleHistoryTb.do")
	public ModelAndView selectListEnaSaleHistoryTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		List<SA011005VO> lst = SA011005Biz.selectListEnaSaleHistoryTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALESEQ", lst.get(i).getSALESEQ());
			obj.put("CHGGUBUN", lst.get(i).getCHGGUBUN());
			obj.put("CHGGUBUNNAME", lst.get(i).getCHGGUBUNNAME());
			obj.put("CHGDATE", lst.get(i).getCHGDATE());
			obj.put("PREM2", lst.get(i).getPREM2());
			obj.put("PREPY", lst.get(i).getPREPY());
			obj.put("CHGM2", lst.get(i).getCHGM2());
			obj.put("CHGPY", lst.get(i).getCHGPY());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaSaleHistoryTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_insertDataEnaSaleHistoryTb.do")
	public ModelAndView insertDataEnaSaleHistoryTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setSALESEQ(request.getParameter("SALESEQ"));
		vo.setCHGGUBUN(request.getParameter("CHGGUBUN"));
		vo.setCHGDATE(request.getParameter("CHGDATE"));
		vo.setPREM2(request.getParameter("PREM2"));
		vo.setPREPY(request.getParameter("PREPY"));
		vo.setCHGM2(request.getParameter("CHGM2"));
		vo.setCHGPY(request.getParameter("CHGPY"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R_3");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SA011005Biz.insertDataEnaSaleHistoryTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SA011005Biz.updateDataEnaSaleHistoryTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]계약변동관리 처리 중 오류가 발생했습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataEnaSaleHistoryTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	@RequestMapping("/home/SA011005_deleteDataEnaSaleHistoryTb.do")
	public ModelAndView deleteDataEnaSaleHistoryTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		String CHGGUBUN = request.getParameter("CHGGUBUN");		// 계약변동구분
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setSALESEQ(request.getParameter("SALESEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if(CHGGUBUN.equals("004")) {		// 해약일 경우
			
			if(SA011005Biz.selectOneRefundTb(vo).size() > 0) {
				resultCode = "ABORT";
				resultMsg = "환불 내역이 존재합니다.\n해약관리에서 환불 내역을 삭제해주세요.";
			} else {
				if (SA011005Biz.deleteDataEnaSaleHistoryTb(vo) == true) {
					resultCode ="SUCCESS";
					resultMsg = "정상적으로 삭제하였습니다.";
				} else {
					 resultCode ="FAILED";
					 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
				}
			}
		} else {
			
			if (SA011005Biz.deleteDataEnaSaleHistoryTb(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 삭제하였습니다.";
			} else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
			}
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataEnaSaleHistoryTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_searchPopup.do")
	public ModelAndView SA011005_searchPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011005_searchPopup");
	}
	
	@RequestMapping("/home/SA011005_selectListEanSaleMstPopup.do")
	public ModelAndView selectListEanSaleMstPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALEDATE(request.getParameter("SALEDATE"));
		
		List<SA011005VO> lst = SA011005Biz.selectListEanSaleMstPopup(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("MANAGENO", lst.get(i).getMANAGENO());
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("OWNERJUMINID", lst.get(i).getOWNERJUMINID());
			obj.put("CONBM2", lst.get(i).getCONBM2());
			obj.put("CONJM2", lst.get(i).getCONJM2());
			obj.put("CONBPY", lst.get(i).getCONBPY());
			obj.put("CONJPY", lst.get(i).getCONJPY());
			obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
			obj.put("SALERCD", lst.get(i).getSALERCD());
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONJUMINID", lst.get(i).getCONJUMINID());
			obj.put("CONADDRESS", lst.get(i).getCONADDRESS());
			obj.put("CONTELNO", lst.get(i).getCONTELNO());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("SALEAMT", lst.get(i).getSALEAMT());
			obj.put("SALEDANGA", lst.get(i).getSALEDANGA());
			obj.put("DCGUBUN", lst.get(i).getDCGUBUN());
			obj.put("DCRATE", lst.get(i).getDCRATE());
			obj.put("DCAMT", lst.get(i).getDCAMT());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("AGENCYAMT", lst.get(i).getAGENCYAMT());
			obj.put("JOINYN", lst.get(i).getJOINYN());
			obj.put("REGYN", lst.get(i).getREGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("CANCELYN", lst.get(i).getCANCELYN());
			obj.put("CANCELDATE", lst.get(i).getCANCELDATE());
			
			jCell.add(obj);
			
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListEanSaleMstPopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_searchManagePopup.do")
	public ModelAndView SA011005_searchManagePopup(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011005_searchManagePopup");
	}
	
	@RequestMapping("/home/SA011005_selectListEnaBuyMstPopup.do")
	public ModelAndView selectListEnaBuyMstPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYGUBUN(request.getParameter("BUYGUBUN"));

		List<MM011001VO> lst = SA011005Biz.selectListEnaBuyMstPopup(vo);
		
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
			obj.put("CONBM2", lst.get(i).getCONBM2());
			obj.put("CONJM2", lst.get(i).getCONJM2());
			obj.put("CONBPY", lst.get(i).getCONBPY());
			obj.put("CONJPY", lst.get(i).getCONJPY());
			obj.put("PMDANGA", lst.get(i).getPMDANGA());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			
			jCell.add(obj);
			
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaBuyMstPopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011005_selectHRInsamstBranchCode.do")
	public ModelAndView selectHRInsamstBranchCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011005VO vo = new SA011005VO();
		
		vo.setSALERNAME(request.getParameter("SALERNAME"));
		
		List<SA011005VO> lst = SA011005Biz.selectHRInsamstBranchCode(vo);
		
		JSONObject json = new JSONObject();
		
		if (lst.size() > 0) {
			json.put("RESULT", "FULL");
			json.put("SALERCD", lst.get(0).getSALERCD());
			json.put("BRANCHCODE", lst.get(0).getBRANCHCODE());
		} else {
			json.put("RESULT", "EMPTY");
		}
		
		logger.debug("[selectHRInsamstBranchCode]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name (신)매출관리 > 입금스케줄관리 > 입금처리(팝업)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011005_v1.do")
	public ModelAndView SA011005_procDepositPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/saleMng/SA011005_procDepositPopup");
	}
	
	/**
	 * @name (신)매출관리 > 입금스케줄관리(탭) > 입금처리(팝업) > 매출 건별 입금처리 현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/home/SA011005_s1.do")
	public ModelAndView selectListIpgumDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = new ArrayList<Map<String, Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		lst = SA011005Biz.selectListIpgumDtl(param);
		
		resultMap.put("rows", lst);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)매출관리 > 입금스케줄관리 > 입금처리(팝업) > 입금현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/home/SA011005_s2.do")
	public ModelAndView selectListIpgumMst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = new ArrayList<Map<String, Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		lst = SA011005Biz.selectListIpgumMst(param);
		
		resultMap.put("rows", lst);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)매출관리 > 입금스케줄관리 > 입금처리(팝업) > 입금처리 : 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/SA011005_u1.do")
	public ModelAndView insertIpgumMst(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		int cnt = 0;
		String msg = "error";
		HttpSession session = null;
		session = request.getSession(false);
		String userId = (String) session.getAttribute("userId");
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		param.put("USERID", userId);
		
		cnt = SA011005Biz.insertIpgumDtl(param);
		
		if(cnt > 0) msg = "success";
		
		msgMap.put("MSG", msg);
		resultMap.put("rows",  msgMap);
		
		return new ModelAndView("jsonView", resultMap);
	}
	
	/**
	 * @name (신)매출관리 > 입금스케줄관리 > 입금처리(팝업) > 매출 건별 입금처리 현황 : 취소
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/home/SA011005_u2.do")
	public ModelAndView deleteIpgumDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		int cnt = 0;
		String msg = "error";
		
		Map<String, Object> msgMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		cnt = SA011005Biz.deleteIpgumDtl(param);
		
		if(cnt > 0) msg = "success";
		
		msgMap.put("MSG", msg);
		resultMap.put("rows",  msgMap);
		
		return new ModelAndView("jsonView", resultMap);
	}	
}
