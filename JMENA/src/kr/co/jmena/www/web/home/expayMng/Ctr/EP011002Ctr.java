package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.expayMng.Vo.EP011002VO;
import kr.co.jmena.www.web.home.expayMng.Biz.EP011002Biz;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EP011002Ctr {
	
//	@Resource(name = "enaSampleBiz")
//	private EnaSampleBiz enaSampleBiz;
	
	public EP011002Ctr() {}
	
	@Resource(name = "EP011002Biz")
	private EP011002Biz EP011002Biz;
	
	
	protected final Logger logger = Logger.getLogger(getClass());
	/**
	 * @name 급여관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP011002.do")
	public ModelAndView EP011002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP011002");
	}
	
	
	/**
	 * @name 급여관리 조회 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectListEnaMonthPayMst.do")
	public ModelAndView selectListEnaMonthPayMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011002VO vo = new EP011002VO();		
 
		vo.setS_YEARMONTH(request.getParameter("S_YEARMONTH"));
		vo.setS_PAYDATE(request.getParameter("S_PAYDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		
		List<EP011002VO> lst = EP011002Biz.selectListEnaMonthPayMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("YEARMONTH", lst.get(i).getYEARMONTH());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("DEPTCODE", lst.get(i).getDEPTCODE());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
				obj.put("DEPTNAME", lst.get(i).getDEPTNAME());
				obj.put("GRADENAME", lst.get(i).getGRADENAME());
				obj.put("DUTYNAME", lst.get(i).getDUTYNAME());
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("BASICAMT", lst.get(i).getBASICAMT());
				obj.put("ACTAMT", lst.get(i).getACTAMT());
				obj.put("PRIZEAMT", lst.get(i).getPRIZEAMT());
				obj.put("DAILYAMT", lst.get(i).getDAILYAMT());
				obj.put("TOTALAMT", lst.get(i).getTOTALAMT());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXGUBUNNM", lst.get(i).getTAXGUBUNNM());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				obj.put("BANKID", lst.get(i).getBANKID());
				obj.put("BANKNAME", lst.get(i).getBANKNAME());
				obj.put("ACCTNO", lst.get(i).getACCTNO());
				obj.put("ACCTOWNER", lst.get(i).getACCTOWNER());
				jCell.add(obj);
			}
		}else{
//			JSONObject obj = new JSONObject();
//			
//			obj.put("YEARMONTH", "");
//			obj.put("BRANCHCODE", "");
//			obj.put("DEPTCODE", "");
//			obj.put("GRADE", "");
//			obj.put("DUTY", "");
//			obj.put("INSACODE", "");
//			obj.put("KNAME", "");
//			obj.put("PAYDATE", "");
//			obj.put("BASICAMT", "");
//			obj.put("ACTAMT", "");
//			obj.put("PRIZEAMT", "");
//			obj.put("DAILYAMT", "");
//			obj.put("TOTALAMT", "");
//			obj.put("TAXGUBUN", "");
//			obj.put("TAXINCOME", "");
//			obj.put("TAXLOCAL", "");
//			obj.put("SUPPLYTAX", "");
//			obj.put("DEDUCTAMT", "");
//			obj.put("BANKID", "");
//			obj.put("ACCTNO", "");
//			obj.put("ACCTOWNER", "");
//			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		logger.debug("[selectListEnaMonthPayMst]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}

	/**
	 * @name 급여관리 생성
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectListEnaMonthPayMstCrt.do")
	public ModelAndView selectListEnaMonthPayMstCrt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011002VO vo = new EP011002VO();		
 
		vo.setS_YEARMONTH(request.getParameter("S_YEARMONTH"));
		vo.setS_PAYDATE(request.getParameter("S_PAYDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		
		List<EP011002VO> lst = EP011002Biz.selectListEnaMonthPayMstCrt(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("YEARMONTH", lst.get(i).getYEARMONTH());
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("DEPTCODE", lst.get(i).getDEPTCODE());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
				obj.put("DEPTNAME", lst.get(i).getDEPTNAME());
				obj.put("GRADENAME", lst.get(i).getGRADENAME());
				obj.put("DUTYNAME", lst.get(i).getDUTYNAME());
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("BASICAMT", lst.get(i).getBASICAMT());
				obj.put("BANKID", lst.get(i).getBANKID());
				obj.put("BANKNAME", lst.get(i).getBANKNAME());
				obj.put("ACCTNO", lst.get(i).getACCTNO());
				obj.put("ACCTOWNER", lst.get(i).getACCTOWNER());
				obj.put("TAXGUBUN", "001");
				obj.put("TAXGUBUNNM", "");
				obj.put("ACTAMT", "0");
				obj.put("PRIZEAMT", "0");
				obj.put("DAILYAMT", "0");
				obj.put("TOTALAMT", "0");
				obj.put("TAXINCOME", "0");
				obj.put("TAXLOCAL", "0");
				obj.put("SUPPLYTAX", "0");
				obj.put("DEDUCTAMT", "0");
				jCell.add(obj);
				
			}
			json.put("rows", jCell);
		}
		logger.debug("[selectListSY021001]" + json);
		
		return new ModelAndView("jsonView", json);
		
		}
	

	@SuppressWarnings("unchecked")
	@RequestMapping("/home/insertEnaMonthPayMst.do")
	public ModelAndView insertEnaMonthPayMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject json = new JSONObject();
		
		JSONArray jCell = new JSONArray();

		JSONObject obj = new JSONObject();
		if(EP011002Biz.insertEnaMonthPayMst(request) == true){
			obj.put("MSG", "SUCCESS");
		}else{
			obj.put("MSG", "ERROR");
		}
		jCell.add(obj);
		json.put("rows", jCell);
		
		logger.debug("[insertEnaMonthPayMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
		
/*	
	
	*//**
	 * @name 인사 기본 정보 관리 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 *//*
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/saveEnaMonthPayMst.do")
	public ModelAndView saveEnaMonthPayMst(HttpServletRequest request, HttpServletResponse response) throws Exception {

		EP011002VO vo = new EP011002VO();		
		int insertCnt =0;
		vo.setPAYDATE(request.getParameter("PAYDATE"));
		vo.setYEARMONTH(request.getParameter("YEARMONTH"));
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		vo.setDEPTCODE(request.getParameter("DEPTCODE"));
		vo.setGRADE(request.getParameter("GRADE"));
		vo.setDUTY(request.getParameter("DUTY"));
		vo.setINSACODE(request.getParameter("INSACODE"));
		vo.setKNAME(request.getParameter("KNAME"));
		vo.setBASICAMT(request.getParameter("BASICAMT"));
		vo.setACTAMT(request.getParameter("ACTAMT"));
		vo.setDAILYAMT(request.getParameter("DAILYAMT"));
		vo.setPRIZEAMT(request.getParameter("PRIZEAMT"));
		vo.setTOTALAMT(request.getParameter("TOTALAMT"));
		vo.setTAXGUBUN(request.getParameter("TAXGUBUN"));
		vo.setTAXINCOME(request.getParameter("TAXINCOME"));
		vo.setTAXLOCAL(request.getParameter("TAXLOCAL"));
		vo.setSUPPLYTAX(request.getParameter("SUPPLYTAX"));
		vo.setDEDUCTAMT(request.getParameter("DEDUCTAMT"));
		vo.setBANKID(request.getParameter("BANKID"));
		vo.setACCTNO(request.getParameter("ACCTNO"));
		vo.setACCTOWNER(request.getParameter("ACCTOWNER"));

		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		

		JSONObject obj = new JSONObject();
		if(insertCnt > EP011002Biz.insertEnaMonthPayMst(request)){
			obj.put("MSG", "success");
		}else{
			obj.put("MSG", "error");
		}
		jCell.add(obj);
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);	
	}
	*/
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/deleteEnaMonthPayMst.do")
	public ModelAndView deleteEnaMonthPayMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011002VO vo = new EP011002VO();
		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
				
		vo.setYEARMONTH(request.getParameter("YEARMONTH"));
		vo.setINSACODE(request.getParameter("INSACODE"));
		
		JSONObject json = new JSONObject();
		
		JSONArray jCell = new JSONArray();

		JSONObject obj = new JSONObject();
		
		if (EP011002Biz.deleteEnaMonthPayMst(vo) == true) {
			obj.put("MSG", "success");
		}else{
			obj.put("MSG", "error");
		}
		jCell.add(obj);
		json.put("rows", jCell);

		logger.debug("[deleteEnaSudangPTb]" + json);
		
		return new ModelAndView("jsonView", json);
	}	
		
}
