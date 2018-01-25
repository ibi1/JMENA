package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA011002Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA011002Ctr {
	
	@Resource(name = "SA011002Biz")
	private SA011002Biz SA011002Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA011002Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011002.do")
	public ModelAndView SA011002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011002");
	}
	
	/**
	 * @name 매출관리 - 소비대차 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEanSaleMstBDtl.do")
	public ModelAndView selectListEanSaleMstBDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011002VO vo = new SA011002VO();
		
		vo.setSL_BRROWDATE_FR(request.getParameter("SL_BRROWDATE_FR"));
		vo.setSL_BRROWDATE_TO(request.getParameter("SL_BRROWDATE_TO"));
		vo.setSALERCD(request.getParameter("SL_SALERNAME"));			//담당자
		vo.setADDRESS(request.getParameter("SL_ADDRESS"));
		vo.setSL_CANCELYN(request.getParameter("SL_CANCELYN"));
		
		List<SA011002VO> lst = SA011002Biz.selectListEanSaleMstBDtl(vo);
		
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
			obj.put("BRROWTYPE", lst.get(i).getBRROWTYPE());
			obj.put("BRROWAMT", lst.get(i).getBRROWAMT());
			obj.put("BRROWPERIOD", lst.get(i).getBRROWPERIOD());
			obj.put("PERIODGUBUN", lst.get(i).getPERIODGUBUN());
			obj.put("BRROWDATE", lst.get(i).getBRROWDATE());
			obj.put("EXPIREYN", lst.get(i).getEXPIREYN());
			obj.put("EXPIREDATE", lst.get(i).getEXPIREDATE());
			obj.put("PAYRATE", lst.get(i).getPAYRATE());
			obj.put("PAYAMT", lst.get(i).getPAYAMT());
			obj.put("PAYACCOUNT", lst.get(i).getPAYACCOUNT());
			obj.put("PAYBANK", lst.get(i).getPAYBANK());
			obj.put("EXTENDYN", lst.get(i).getEXTENDYN());
			obj.put("EXTENDDATE", lst.get(i).getEXTENDDATE());
			obj.put("PAYOWNER", lst.get(i).getPAYOWNER());
			obj.put("JOINYN", lst.get(i).getJOINYN());
			obj.put("REGYN", lst.get(i).getREGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("CANCELYN", lst.get(i).getCANCELYN());
			obj.put("CANCELDATE", lst.get(i).getCANCELDATE());
			obj.put("SALERNAME", lst.get(i).getSALERNAME());
			
			jCell.add(obj);
			
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListEanSaleMstBDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataSaleMstBDtl.do")
	public ModelAndView insertDataSaleMstBDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011002VO vo = new SA011002VO();
		
		//mst
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setSALEDATE(request.getParameter("SALEDATE"));
		vo.setSALEGUBUN(request.getParameter("SALEGUBUN"));
		vo.setSALERCD(request.getParameter("SALERCD"));
		vo.setBUYID(request.getParameter("MANAGENO"));
		vo.setMANAGENO(request.getParameter("MANAGENO"));
		vo.setCONNAME(request.getParameter("CONNAME"));
		vo.setCONJUMINID(request.getParameter("CONJUMINID"));
		vo.setCONADDRESS(request.getParameter("CONADDRESS"));
		vo.setCONTELNO(request.getParameter("CONTELNO"));
		vo.setCONM2(request.getParameter("CONM2"));
		vo.setCONPY(request.getParameter("CONPY"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		//dtl
		vo.setBRROWTYPE(request.getParameter("BRROWTYPE"));
		vo.setBRROWAMT(request.getParameter("BRROWAMT"));
		vo.setBRROWPERIOD(request.getParameter("BRROWPERIOD"));
		vo.setPERIODGUBUN(request.getParameter("PERIODGUBUN"));
		vo.setBRROWDATE(request.getParameter("BRROWDATE"));
		vo.setEXPIREYN("on".equals(request.getParameter("EXPIREYN")) ? "Y" : "N");
		vo.setEXPIREDATE(request.getParameter("EXPIREDATE"));
		vo.setPAYRATE(request.getParameter("PAYRATE"));
		vo.setPAYAMT(request.getParameter("PAYAMT"));
		vo.setPAYACCOUNT(request.getParameter("PAYACCOUNT"));
		vo.setPAYBANK(request.getParameter("PAYBANK"));
		vo.setEXTENDYN("on".equals(request.getParameter("EXTENDYN")) ? "Y" : "N");
		vo.setEXTENDDATE(request.getParameter("EXTENDDATE"));
		vo.setCANCELYN("on".equals(request.getParameter("CANCELYN")) ? "Y" : "N");
		vo.setCANCELDATE(request.getParameter("CANCELDATE"));
		vo.setPAYOWNER(request.getParameter("PAYOWNER"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_L");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SA011002Biz.insertDataSaleMstBDtl(vo) == true) {
				json.put("SALEID", vo.getSALEID_PK());
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SA011002Biz.updateDataSaleMstBDtl(vo) == true) {
				json.put("SALEID", vo.getSALEID());
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 수정하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]수정 중 오류가 발생하였습니다.";
			 }
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]매출관리-소비대차 처리 중 오류가 발생했습니다.";
		}
		
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataSaleMstBDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	
	@RequestMapping("/home/deleteDataSaleMstBDtl.do")
	public ModelAndView deleteDataSaleMstBDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011002VO vo = new SA011002VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SA011002Biz.deleteAllJointnameTbBDtl(vo) == true) {
			if (SA011002Biz.deleteDataSalebDtl(vo) == true) {
				if (SA011002Biz.deleteDataSaleMstBDtl(vo) == true) {
					resultCode ="SUCCESS";
					resultMsg = "정상적으로 삭제하였습니다.";
				} else {
					resultCode ="FAILED";
					resultMsg = "[ERROR]선택된 매출 - 소비대차 삭제 중 오류가 발생하였습니다.";
				}
			} else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]선택된 매출 - 소비대차 상세 삭제 중 오류가 발생하였습니다.";
			}
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]선택된 등기 관리 - 소비대차 전체 삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataSaleMstBDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * 등기 관리 - 소비대차
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaJointNameTbBDtl.do")
	public ModelAndView selectListEnaJointNameTbBDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011001VO vo = new SA011001VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		
		List<SA011001VO> lst = SA011002Biz.selectListEnaJointNameTbBDtl(vo);
		
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
			obj.put("PAPERREGYN", lst.get(i).getPAPERREGYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaJointNameTbBDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataEnaJointNameTbBDtl.do")
	public ModelAndView insertDataEnaJointNameTbBDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011001VO vo = new SA011001VO();
		
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
			vo.setPAPERREGYN(request.getParameter("PAPERREGYN"));
			vo.setREMARK(request.getParameter("REMARK"));
		}
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		String IU_Flag = request.getParameter("S_FLAG_R");
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if ("I".equals(IU_Flag)) {
			if (SA011002Biz.insertDataEnaJointNameTbBDtl(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 저장하였습니다.";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else if ("U".equals(IU_Flag)) {
			if (SA011002Biz.updateDataEnaJointNameTbBDtl(vo) == true) {
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

		logger.debug("[insertDataEnaJointNameTbBDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/deleteDataEnaJointNameTbBDtl.do")
	public ModelAndView deleteDataEnaJointNameTbBDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011001VO vo = new SA011001VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setJOINTSEQ(request.getParameter("JOINTSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SA011002Biz.deleteDataEnaJointNameTbBDtl(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataEnaJointNameTbBDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011002_searchPopup.do")
	public ModelAndView SA011002_searchPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011002_searchPopup");
	}
	
	@RequestMapping("/home/selectListEanSaleMstBDtlPopup.do")
	public ModelAndView selectListEanSaleMstBDtlPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011002VO vo = new SA011002VO();
		
		vo.setSALEDATE(request.getParameter("SALEDATE"));
		
		List<SA011002VO> lst = SA011002Biz.selectListEanSaleMstBDtlPopup(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("MANAGENO", lst.get(i).getMANAGENO());
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("BRROWAMT", lst.get(i).getBRROWAMT());
			obj.put("PAYAMT", lst.get(i).getPAYAMT());
			
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListEanSaleMstBDtlPopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011002_searchManagePopup.do")
	public ModelAndView SA011002_searchManagePopup(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011002_searchManagePopup");
	}
	
	@RequestMapping("/home/selectListEnaBuyMstBDtlPopup.do")
	public ModelAndView selectListEnaBuyMstBDtlPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();

		List<MM011001VO> lst = SA011002Biz.selectListEnaBuyMstBDtlPopup(vo);
		
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
			
			jCell.add(obj);
			
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaBuyMstBDtlPopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
