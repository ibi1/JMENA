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
	 * @name 수당관리 조회 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectListEnaMonthPayMst.do")
	public ModelAndView selectListEnaMonthPayMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011002VO vo = new EP011002VO();			
		
//		String s_branchcode = request.getParameter("S_BRANCHCODE") != null ? request.getParameter("S_BRANCHCODE") : ""; 
//		String s_deptcode = request.getParameter("S_DEPTCODE") != null ? request.getParameter("S_DEPTCODE") : ""; 
		
//		vo.setS_BRANCHCODE(s_branchcode);
//		vo.setS_DEPTCODE(s_deptcode);
		
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
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("BASICAMT", lst.get(i).getBASICAMT());
				obj.put("ACTAMT", lst.get(i).getACTAMT());
				obj.put("PRIZEAMT", lst.get(i).getPRIZEAMT());
				obj.put("DAILYAMT", lst.get(i).getDAILYAMT());
				obj.put("TOTALAMT", lst.get(i).getTOTALAMT());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				obj.put("BANKID", lst.get(i).getBANKID());
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
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSY021001]" + json);
		
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
	@RequestMapping("/home/updateEnaMonthPayMst.do")
	public ModelAndView updateEnaMonthPayMst(HttpServletRequest request, HttpServletResponse response) throws Exception {

		EP011002VO vo = new EP011002VO();		
		
		String IU_Flag = request.getParameter("S_FLAG_B1");
		int updateCnt = 0;
		int insertCnt = 0;
		
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
		
		if ("I".equals(IU_Flag)) {
			insertCnt = EP011002Biz.insertEnaMonthPayMst(vo);
			if(insertCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}			
		} else if ("U".equals(IU_Flag)) {
			updateCnt = EP011002Biz.updateEnaMonthPayMst(vo);
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
	
		
	
			
	
}
