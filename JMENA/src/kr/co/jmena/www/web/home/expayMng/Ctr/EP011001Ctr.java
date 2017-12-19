package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.expayMng.Biz.EP011001Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EP011001Ctr {
	
	@Resource(name = "EP011001Biz")
	private EP011001Biz EP011001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());

	public EP011001Ctr() {}
	
	
	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP011001.do")
	public ModelAndView EP011001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP011001");
	}
	
	
	
	/**
	 * @name 수당관리 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP011001_1.do")
	public ModelAndView EP011001_1(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP011001_1");
	}
		
	/**
	 * @name 신고인 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP011001_2.do")
	public ModelAndView EP011001_2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/expayMng/EP011001_2");
	}
	
	
	/**
	 * @name 수당수령인 추가 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP011001_3.do")
	public ModelAndView EP011001_3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/expayMng/EP011001_3");
	}
	
	/**
	 * @name 수당관리 화면 - 수당관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/home/selectListEnaSudangMst.do")
	public ModelAndView selectListEnaSudangMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		
		vo.setS_SALEID(request.getParameter("S_SALEID"));
		vo.setS_PAYSEQ(request.getParameter("S_PAYSEQ"));
		vo.setS_SALERCD(request.getParameter("S_SALERCD"));
		vo.setS_SALEDATESYM(request.getParameter("S_SALEDATESYM"));
		vo.setS_SALEDATEEYM(request.getParameter("S_SALEDATEEYM"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));		
		
		List<EP011001VO> lst = EP011001Biz.selectListEnaSudangMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				
				JSONObject obj = new JSONObject();			
				
				
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
				obj.put("SALERCD", lst.get(i).getSALERCD());
				obj.put("SALERNM", lst.get(i).getSALERNM());
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("SELLAMT", lst.get(i).getSELLAMT());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("TAXAMT", lst.get(i).getTAXAMT());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				
				obj.put("SALEDATE", lst.get(i).getSALEDATE());
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("MANAGENO", lst.get(i).getMANAGENO());
				obj.put("CITYCODE", lst.get(i).getCITYCODE());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONM2", lst.get(i).getCONM2());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("SALEAMT", lst.get(i).getSALEAMT());
				obj.put("SALEDANGA", lst.get(i).getSALEDANGA());
				obj.put("DCGUBUN", lst.get(i).getDCGUBUN());
				obj.put("DCRATE", lst.get(i).getDCRATE());
				obj.put("DCAMT", lst.get(i).getDCAMT());
				obj.put("SELLAMT", lst.get(i).getSELLAMT());
								
				obj.put("SUDANGRATE", lst.get(i).getSUDANGRATE());
				obj.put("ADDRATE", lst.get(i).getADDRATE());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXGUBUNNAME", lst.get(i).getTAXGUBUNNAME());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("REMARK", lst.get(i).getREMARK());
				obj.put("REGISTERNUM", lst.get(i).getREGISTERNUM());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaSudangMst]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}	
	
	/**
	 * @name 수당관리 화면 - 수당지급 관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/home/selectEnaSudangMstList.do")
	public ModelAndView selectEnaSudangMstList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		
		vo.setS_SALEID(request.getParameter("S_SALEID"));
		vo.setINSACODE(request.getParameter("INSACODE"));		
		vo.setFLAG(request.getParameter("FLAG"));		
		
		List<EP011001VO> lst = EP011001Biz.selectEnaSudangMstList(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				
				JSONObject obj = new JSONObject();			
				
				
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
				obj.put("SALERCD", lst.get(i).getSALERCD());
				obj.put("SALERNM", lst.get(i).getSALERNM());
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("SELLAMT", lst.get(i).getSELLAMT());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("TAXAMT", lst.get(i).getTAXAMT());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				
				obj.put("SALEDATE", lst.get(i).getSALEDATE());
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("MANAGENO", lst.get(i).getMANAGENO());
				obj.put("CITYCODE", lst.get(i).getCITYCODE());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONM2", lst.get(i).getCONM2());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("SALEAMT", lst.get(i).getSALEAMT());
				obj.put("SALEDANGA", lst.get(i).getSALEDANGA());
				obj.put("DCGUBUN", lst.get(i).getDCGUBUN());
				obj.put("DCRATE", lst.get(i).getDCRATE());
				obj.put("DCAMT", lst.get(i).getDCAMT());
				obj.put("SELLAMT", lst.get(i).getSELLAMT());
								
				obj.put("SUDANGRATE", lst.get(i).getSUDANGRATE());
				obj.put("ADDRATE", lst.get(i).getADDRATE());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXGUBUNNAME", lst.get(i).getTAXGUBUNNAME());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("REMARK", lst.get(i).getREMARK());
				obj.put("REGISTERNUM", lst.get(i).getREGISTERNUM());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectEnaSudangMstList]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}	
	
	
	/**
	 * @name 수당관리 화면 - 수당지급인 생성
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/home/selectEnaSudangMstInsert.do")
	public ModelAndView selectEnaSudangMstInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		
		vo.setS_SALEID(request.getParameter("S_SALEID"));
		vo.setSALERCD(request.getParameter("SALERCD"));		
		
		List<EP011001VO> lst = EP011001Biz.selectEnaSudangMstInsert(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				
				JSONObject obj = new JSONObject();					
				
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());	
				
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				
				obj.put("SUDANGRATE","0");
				obj.put("ADDRATE","0");
				obj.put("PAYAMT","");
				obj.put("TAXGUBUN","001");
				obj.put("TAXINCOME","0");
				obj.put("TAXLOCAL","0");
				obj.put("SUPPLYTAX","0");
				obj.put("DEDUCTAMT","0");
				obj.put("REGISTERNUM","");
				obj.put("REMARK","");
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectEnaSudangMstInsert]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}					

	
	/**
	 * @name 수당 마스터 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaSudangMst.do")
	public ModelAndView updateEnaSudangMst(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		

		JSONObject obj = new JSONObject();
		if (EP011001Biz.updateEnaSudangMst(request) == true) {
				obj.put("MSG", "SUCCESS");
		}else{
				obj.put("MSG", "ERROR");
		}
		jCell.add(obj);
		json.put("rows", jCell);
		
		logger.debug("[updateEnaSudangMst]" + json);
		return new ModelAndView("jsonView", json);	
	}
	
	/**
	 * @name 수당관리 화면 - 엑셀
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectEnaSudangMstSheet.do")
	public ModelAndView selectEnaSudangMstSheet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		ModelAndView result = new ModelAndView();
		
		vo.setS_SALEID(request.getParameter("saleId"));
		vo.setS_PAYSEQ(request.getParameter("paySeq"));		
		vo.setINSACODE(request.getParameter("insaCode"));
		
		
		List<EP011001VO> Sheet = EP011001Biz.selectEnaSudangMstSheet(vo);
		List<EP011001VO> SheetList = EP011001Biz.selectEnaSudangMstSheetList(vo);
		
		result.addObject("Sheet", Sheet);
		result.addObject("SheetList", SheetList);
		result.setViewName("home/expayMng/EP011001_4");
		
		return result;
	}	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/deleteEnaSudangMst.do")
	public ModelAndView deleteEnaSudangMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
				
		vo.setSALEID(request.getParameter("SALEID"));
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		JSONObject obj = new JSONObject();
		EP011001Biz.deleteEnaSudangMstPTb(vo);
		if (EP011001Biz.deleteEnaSudangMst(vo) == true) {
			obj.put("MSG", "SUCCESS");
		}else{
			obj.put("MSG", "ERROR");
		}
		jCell.add(obj);
		json.put("rows", jCell);

		logger.debug("[deleteEnaSudangMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
		
	
	/**
	 * @name 수당관리 화면 - 신고인 관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/home/selectListEnaSudangPTb.do")
	public ModelAndView selectListEnaSudangPTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setPAYSEQ(request.getParameter("PAYSEQ"));

		
		List<EP011001VO> lst = EP011001Biz.selectListEnaSudangPTb(vo);
		
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				
				JSONObject obj = new JSONObject();			
				
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
				obj.put("REGISTERSEQ", lst.get(i).getREGISTERSEQ());
				obj.put("PAYERNAME", lst.get(i).getPAYERNAME());
				obj.put("PAYERID", lst.get(i).getPAYERID());
				obj.put("SAUPOWNER", lst.get(i).getSAUPOWNER());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				obj.put("BANKID", lst.get(i).getBANKID());
				obj.put("BANKNAME", lst.get(i).getBANKNAME());
				obj.put("ACCTNO", lst.get(i).getACCTNO());
				obj.put("ACCTOWNER", lst.get(i).getACCTOWNER());
				obj.put("REMARK", lst.get(i).getREMARK());
				
				jCell.add(obj);			
			}
		}
	
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaSudangPTb]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}	
	
	/**
	 * @name 신고인관리 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaSudangPTb.do")
	public ModelAndView updateEnaSudangPTb(HttpServletRequest request, HttpServletResponse response) throws Exception {

		EP011001VO vo = new EP011001VO();		
		
		int updateCnt = 0;
		int insertCnt = 0;
		
		vo.setPAYERNAME(request.getParameter("PAYERNAME"));
		vo.setPAYERID(request.getParameter("PAYERID"));
		vo.setSAUPOWNER(request.getParameter("SAUPOWNER"));
		vo.setPAYAMT(request.getParameter("PAYAMT"));
		vo.setTAXGUBUN(request.getParameter("TAXGUBUN"));
		vo.setTAXINCOME(request.getParameter("TAXINCOME"));
		vo.setTAXLOCAL(request.getParameter("TAXLOCAL"));
		vo.setSUPPLYTAX(request.getParameter("SUPPLYTAX"));
		vo.setDEDUCTAMT(request.getParameter("DEDUCTAMT"));
		vo.setBANKID(request.getParameter("BANKID"));
		vo.setACCTNO(request.getParameter("ACCTNO"));
		vo.setACCTOWNER(request.getParameter("ACCTOWNER"));
		vo.setREMARK(request.getParameter("REMARK"));
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setPAYSEQ(request.getParameter("PAYSEQ"));
		vo.setREGISTERSEQ(request.getParameter("REGISTERSEQ"));
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		

		JSONObject obj = new JSONObject();
		
		String IU_Flag = request.getParameter("S_FLAG");
		if ("I".equals(IU_Flag)) {
			insertCnt = EP011001Biz.insertEnaSudangPTb(vo);
			if(insertCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}	
		} else if ("U".equals(IU_Flag)) {
			updateCnt = EP011001Biz.updateEnaSudangPTb(vo);
			if(updateCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
		}				
		

		jCell.add(obj);
		json.put("rows", jCell);
		
		
		
		return new ModelAndView("jsonView", json);	
	}	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/deleteEnaSudangPTb.do")
	public ModelAndView deleteEnaSudangPTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
				
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setPAYSEQ(request.getParameter("PAYSEQ"));
		vo.setREGISTERSEQ(request.getParameter("REGISTERSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (EP011001Biz.deleteEnaSudangPTb(vo) == true) {
			resultCode ="SUCCESS";
			resultMsg = "정상적으로 삭제하였습니다.";
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteEnaSudangPTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}	
	
	/**
	 * @name 수당관리 화면 - 매출 팝업창 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/home/selectListEnaSaleSudangList.do")
	public ModelAndView selectListEnaSaleSudangList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setSALEDATE(request.getParameter("SALEDATE"));
		
		
		List<EP011001VO> lst = EP011001Biz.selectListEnaSaleSudangList(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				
				JSONObject obj = new JSONObject();			
				
				obj.put("SALEDATE", lst.get(i).getSALEDATE());
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("SALERNM", lst.get(i).getSALERNM());
				obj.put("SALEAMT", lst.get(i).getSALEAMT());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
				obj.put("SALERCD", lst.get(i).getSALERCD());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("MANAGENO", lst.get(i).getMANAGENO());
				obj.put("CITYCODE", lst.get(i).getCITYCODE());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("CONM2", lst.get(i).getCONM2());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("SALEAMT", lst.get(i).getSALEAMT());
				obj.put("SALEDANGA", lst.get(i).getSALEDANGA());
				obj.put("DCGUBUN", lst.get(i).getDCGUBUN());
				obj.put("DCRATE", lst.get(i).getDCRATE());
				obj.put("DCAMT", lst.get(i).getDCAMT());
				obj.put("SELLAMT", lst.get(i).getSELLAMT());
				
				jCell.add(obj);			
			}
		}
//		else{
//			JSONObject obj = new JSONObject();
//			obj.put("SALEDATE", "");
//			obj.put("SALEID", "");
//			obj.put("SALERNM", "");
//			obj.put("SALEAMT", "");
//			obj.put("CONNAME", "");
//			obj.put("SALEGUBUN", "");
//			obj.put("SALERCD", "");
//			obj.put("BRANCHCODE", "");
//			obj.put("MANAGENO", "");
//			obj.put("CITYCODE", "");
//			obj.put("ADDRESS", "");
//			obj.put("CONM2", "");
//			obj.put("CONPY", "");
//			obj.put("SALEAMT", "");
//			obj.put("SALEDANGA", "");
//			obj.put("DCGUBUN", "");
//			obj.put("DCRATE", "");
//			obj.put("DCAMT", "");
//			obj.put("SELLAMT", "");
//			
//			jCell.add(obj);
//			
//		}
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaSaleSudangList]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}	
	
	@RequestMapping("/home/EP011001_5.do")
	public ModelAndView EP011001_5(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/expayMng/EP011001_5");
	}
	
	@RequestMapping("/home/selectListEanHRInsaMstPopup.do")
	public ModelAndView selectListEanHRInsaMstPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HR011001VO vo = new HR011001VO();
		
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		String[] insacodeArr = request.getParameter("INSACODEARR").split("\\^");
		
		vo.setS_KNAME(request.getParameter("S_KNAME"));
		
		
		List<String> insacodeList = new ArrayList<String>();
		
		for (String insacode : insacodeArr) {
			insacodeList.add(insacode);
		}
		
		vo.setINSACODEARR(insacodeList);
		
		List<HR011001VO> lst = EP011001Biz.selectListEanHRInsaMstPopup(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("GRADENAME", lst.get(i).getGRADENAME());
				obj.put("DUTY", lst.get(i).getDUTY());
				obj.put("DUTYNAME", lst.get(i).getDUTYNAME());
				
				jCell.add(obj);			
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEanHRInsaMstPopup]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	
	@RequestMapping("/home/deleteDataEnaSudangMstBottom.do")
	public ModelAndView deleteDataEnaSudangMstBottom(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
				
		vo.setSALEID(request.getParameter("SALEID"));
		vo.setPAYSEQ(request.getParameter("PAYSEQ"));
		
		JSONObject json = new JSONObject();
		
		String resultCode = "";
		String resultMsg = "";
		
		if (EP011001Biz.deleteDataEnaSudangMstPTbBottom(vo) == true) {
			if (EP011001Biz.deleteDataEnaSudangMstBottom(vo) == true) {
				resultCode ="SUCCESS";
				resultMsg = "정상적으로 삭제하였습니다.";
			} else {
				resultCode ="FAILED";
				 resultMsg = "[ERROR]선택된 수당수령인 삭제 중 오류가 발생하였습니다.";
			}
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]선택된 수당수령인의 수당신고인 삭제 중 오류가 발생하였습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[deleteDataEnaSudangMstBottom]" + json);
		
		return new ModelAndView("jsonView", json);
	}	
	
}
