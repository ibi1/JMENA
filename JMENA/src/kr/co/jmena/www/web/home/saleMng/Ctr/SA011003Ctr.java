package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011003VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA011003Biz;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA011003Ctr {
	
	@Resource(name = "SA011003Biz")
	private SA011003Biz SA011003Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA011003Ctr() {}
	
	/**
	 * @name 입금관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011003.do")
	public ModelAndView SA011003(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011003");
	}
	
	/**
	 * @name 입금관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaIpgumMst.do")
	public ModelAndView selectListEnaIpgumMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011003VO vo = new SA011003VO();

		vo.setSL_IPGUMID(request.getParameter("SL_IPGUMID"));
		
		vo.setSL_IPGUMDATE_FR(request.getParameter("SL_IPGUMDATE_FR"));
		vo.setSL_IPGUMDATE_TO(request.getParameter("SL_IPGUMDATE_TO"));
		vo.setSL_KNAME(request.getParameter("SL_KNAME"));
		vo.setSL_IPGUMGUBUN(request.getParameter("SL_IPGUMGUBUN"));
		vo.setSL_BANKGUBUN(request.getParameter("SL_BANKGUBUN"));
		vo.setSL_IPGUMAMT(request.getParameter("SL_IPGUMAMT"));
		
		
		List<SA011003VO> lst = SA011003Biz.selectListEnaIpgumMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("IPGUMDATE", lst.get(i).getIPGUMDATE());
			obj.put("IPGUMID", lst.get(i).getIPGUMID());
			obj.put("IPGUMTYPE", lst.get(i).getIPGUMTYPE());
			obj.put("IPGUMGUBUN", lst.get(i).getIPGUMGUBUN());
			obj.put("BANKGUBUN", lst.get(i).getBANKGUBUN());
			obj.put("IPGUMPERSON", lst.get(i).getIPGUMPERSON());
			obj.put("IPGUMAMT", lst.get(i).getIPGUMAMT());
			obj.put("SUGUMAMT", lst.get(i).getSUGUMAMT());
			obj.put("JANAMT", lst.get(i).getJANAMT());
			obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			
			jCell.add(obj);
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSA011003]" + json);
		
		return new ModelAndView("jsonView", json);	
	}

	/**
	 * @name 입금관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaIpgumDtl.do")
	public ModelAndView selectListEnaIpgumDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011003VO vo = new SA011003VO();

		vo.setIPGUMID(request.getParameter("IPGUMID"));
		
		List<SA011003VO> lst = SA011003Biz.selectListEnaIpgumDtl(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONTELNO", lst.get(i).getCONTELNO());
			obj.put("CONADDRESS", lst.get(i).getCONADDRESS());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("DEPOSITGUBUN", lst.get(i).getDEPOSITGUBUN());
			obj.put("DEPOSITDATE", lst.get(i).getDEPOSITDATE());
			obj.put("DEPOSITAMT", lst.get(i).getDEPOSITAMT());
			obj.put("SUGUMAMT", lst.get(i).getSUGUMAMT());
			
			obj.put("SEQ", lst.get(i).getSEQ());
			obj.put("IPGUMSEQ", lst.get(i).getIPGUMSEQ());
			obj.put("SUGUMAMT", lst.get(i).getSUGUMAMT());
			
			jCell.add(obj);
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSA011003]" + json);
		
		return new ModelAndView("jsonView", json);	
	}
	
	
	/**
	 * @name 인사 기본 정보 관리 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaIpgumMst.do")
	public ModelAndView updateEnaIpgumMst(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SA011003VO vo = new SA011003VO();		
		
		int updateCnt = 0;
		int insertCnt = 0;
		
		vo.setIPGUMID(request.getParameter("IPGUMID"));
		vo.setIPGUMDATE(request.getParameter("IPGUMDATE"));
		vo.setIPGUMTYPE(request.getParameter("IPGUMTYPE"));
		vo.setIPGUMGUBUN(request.getParameter("IPGUMGUBUN"));
		vo.setBANKGUBUN(request.getParameter("BANKGUBUN"));
		vo.setIPGUMPERSON(request.getParameter("IPGUMPERSON"));
		vo.setIPGUMAMT(request.getParameter("IPGUMAMT"));
		vo.setSUGUMAMT(request.getParameter("SUGUMAMT"));
		vo.setJANAMT(request.getParameter("JANAMT"));
		vo.setBRANCHNAME(request.getParameter("BRANCHNAME"));
		vo.setKNAME(request.getParameter("KNAME"));
		vo.setADDRESS(request.getParameter("ADDRESS"));
		vo.setCONNAME(request.getParameter("CONNAME"));
		vo.setCONPY(request.getParameter("CONPY"));
		vo.setREMARK(request.getParameter("REMARK"));

		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		System.out.println("***************************************************");
		System.out.println("IPGUMDATE==>"+request.getParameter("IPGUMDATE"));
		System.out.println("IPGUMTYPE==>"+request.getParameter("IPGUMTYPE"));
		System.out.println("IPGUMGUBUN==>"+request.getParameter("IPGUMGUBUN"));
		System.out.println("BANKGUBUN==>"+request.getParameter("BANKGUBUN"));
		System.out.println("IPGUMPERSON==>"+request.getParameter("IPGUMPERSON"));
		System.out.println("IPGUMAMT==>"+request.getParameter("IPGUMAMT"));
		System.out.println("SUGUMAMT==>"+request.getParameter("SUGUMAMT"));
		System.out.println("JANAMT==>"+request.getParameter("JANAMT"));
		System.out.println("BRANCHNAME==>"+request.getParameter("BRANCHNAME"));
		System.out.println("KNAME==>"+request.getParameter("KNAME"));
		System.out.println("ADDRESS==>"+request.getParameter("ADDRESS"));
		System.out.println("CONNAME==>"+request.getParameter("CONNAME"));
		System.out.println("CONPY==>"+request.getParameter("CONPY"));
		System.out.println("REMARK==>"+request.getParameter("REMARK"));

		System.out.println("***************************************************");
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		

		JSONObject obj = new JSONObject();
		
		if (SA011003Biz.selectOneEnaIpgumMst(vo) == 0) {
			insertCnt = SA011003Biz.insertEnaIpgumMst(vo);
			if(insertCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}			
		}else{
			updateCnt = SA011003Biz.updateEnaIpgumMst(vo);
			if(updateCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
		}

		jCell.add(obj);
		json.put("rows", jCell);
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	

	
	}
	

	@RequestMapping("/home/deleteEnaIpgumMst.do")
	public ModelAndView deleteEnaIpgumMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011003VO vo = new SA011003VO();
		
		vo.setIPGUMID(request.getParameter("IPGUMID"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		

		if (SA011003Biz.deleteEnaIpgumDtl(vo) == true) {
			if (SA011003Biz.deleteEnaIpgumMst(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 삭제하였습니다.";
			} else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]선택된 입금관리 전체 삭제 중 오류가 발생하였습니다.";
			}
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]선택된 입금관리 상세데이터 삭제 중 오류가 발생하였습니다.";
		}
		
		
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataBuyMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/SA011003_salePopup.do")
	public ModelAndView SA011003_salePopup(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011003_salePopup");
	}

	/**
	 * @name 인사 기본 정보 관리 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaIpgumDtl.do")
	public ModelAndView updateEnaIpgumDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SA011003VO vo = new SA011003VO();		
		
		int updateCnt = 0;
		int insertCnt = 0;
		
		vo.setIPGUMID(request.getParameter("IPGUMID"));
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setIPGUMSEQ(request.getParameter("IPGUMSEQ"));
		vo.setSEQ(request.getParameter("SEQ"));
		vo.setSUGUMAMT(request.getParameter("SUGUMAMT"));
		System.out.println("IPGUMID==>"+request.getParameter("IPGUMID"));
		System.out.println("SALEID==>"+request.getParameter("SALEID"));
		System.out.println("IPGUMSEQ==>"+request.getParameter("IPGUMSEQ"));
		System.out.println("SEQ==>"+request.getParameter("SEQ"));
		System.out.println("SUGUMAMT==>"+request.getParameter("SUGUMAMT"));
		vo.setREMARK("");

		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		

		JSONObject obj = new JSONObject();
		
		if (SA011003Biz.selectOneEnaIpgumDtl(vo) == 0) {
			insertCnt = SA011003Biz.insertEnaIpgumDtl(vo);
			if(insertCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}			
		}else{
			updateCnt = SA011003Biz.updateEnaIpgumDtl(vo);
			if(updateCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
		}

		jCell.add(obj);
		json.put("rows", jCell);
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	

	
	}
	

	@RequestMapping("/home/deleteEnaIpgumDtl.do")
	public ModelAndView deleteEnaIpgumDtl2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011003VO vo = new SA011003VO();
		
		vo.setIPGUMID(request.getParameter("IPGUMID"));
		vo.setSEQ(request.getParameter("SEQ"));
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setIPGUMSEQ(request.getParameter("IPGUMSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (SA011003Biz.deleteEnaIpgumDtl2(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			resultCode ="FAILED";
			resultMsg = "[ERROR]선택된 입금관리 상세데이터 삭제 중 오류가 발생하였습니다.";
		}
		
		
		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataBuyMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	@RequestMapping("/home/selectListEanSalePopup.do")
	public ModelAndView selectListEanSalePopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011003VO vo = new SA011003VO();

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		vo.setSALEDATE(request.getParameter("SALEDATE"));
		
		if(request.getParameter("SALEDATE").equals("")){
/*			
			JSONObject obj_ = new JSONObject();
			obj_.put("SALEID", "");
			obj_.put("SALEDATE", "");
			obj_.put("SALEGUBUN", "");
			obj_.put("CONNAME", "");
			obj_.put("CONTELNO", "");
			obj_.put("CONADDRESS", "");
			obj_.put("CONM2", "");
			obj_.put("CONPY", "");
			obj_.put("SELLAMT", "");
			obj_.put("DEPOSITGUBUN", "");
			obj_.put("DEPOSITDATE", "");
			obj_.put("DEPOSITAMT", "");
			obj_.put("IPGUMSEQ", "");
			
			
			jCell.add(obj_);
*/			
		}else{
		
			List<SA011003VO> lst = SA011003Biz.selectListEanSalePopup(vo);
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("SALEDATE", lst.get(i).getSALEDATE());
				obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONTELNO", lst.get(i).getCONTELNO());
				obj.put("CONADDRESS", lst.get(i).getCONADDRESS());
				obj.put("CONM2", lst.get(i).getCONM2());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("SELLAMT", lst.get(i).getSELLAMT());
				obj.put("DEPOSITGUBUN", lst.get(i).getDEPOSITGUBUN());
				obj.put("DEPOSITDATE", lst.get(i).getDEPOSITDATE());
				obj.put("DEPOSITAMT", lst.get(i).getDEPOSITAMT());
				obj.put("IPGUMSEQ", lst.get(i).getIPGUMSEQ());
								
				jCell.add(obj);
				
			}
			
			json.put("records", lst.size());
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEanSalePopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
}
