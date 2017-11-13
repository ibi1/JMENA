package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.expayMng.Biz.EP011001Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;

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
		System.out.println("/home/selectListEnaSudangMst.do");
		
		List<EP011001VO> lst = EP011001Biz.selectListEnaSudangMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				System.out.println("aaaaaa");
				System.out.println("ADDRESS       =  "  + lst.get(i).getADDRESS());
				
				JSONObject obj = new JSONObject();			
				
				
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("SALERCD", lst.get(i).getSALERCD());
				obj.put("SALERNM", lst.get(i).getSALERNM());
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
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("REMARK", lst.get(i).getREMARK());
				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			obj.put("PAYDATE", "");
			obj.put("SALERCD", "");
			obj.put("SALERNM", "");
			obj.put("SELLAMT", "");
			obj.put("PAYAMT", "");
			obj.put("TAXAMT", "");
			obj.put("DEDUCTAMT", "");
			obj.put("SALEDATE", "");
			obj.put("SALEID", "");
			obj.put("SALEGUBUN", "");
			obj.put("BRANCHCODE", "");
			obj.put("MANAGENO", "");
			obj.put("CITYCODE", "");
			obj.put("ADDRESS", "");
			obj.put("CONNAME", "");
			obj.put("CONM2", "");
			obj.put("CONPY", "");
			obj.put("SALEAMT", "");
			obj.put("SALEDANGA", "");
			obj.put("DCGUBUN", "");
			obj.put("DCRATE", "");
			obj.put("DCAMT", "");
			obj.put("SELLAMT", "");
			obj.put("SUDANGRATE", "");
			obj.put("ADDRATE", "");
			obj.put("TAXGUBUN", "");
			obj.put("TAXINCOME", "");
			obj.put("TAXLOCAL", "");
			obj.put("SUPPLYTAX", "");
			obj.put("REMARK", "");		
			

			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListEnaSudangMst]" + json);
		
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
		System.out.println("/home/selectListEnaSudangMst.do");
		
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
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				obj.put("SUDANGRATE", lst.get(i).getSUDANGRATE());
				obj.put("ADDRATE", lst.get(i).getADDRATE());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				obj.put("BANKID", lst.get(i).getBANKID());
				obj.put("ACCTNO", lst.get(i).getACCTNO());
				obj.put("ACCTOWNER", lst.get(i).getACCTOWNER());
				obj.put("PAYNUM", lst.get(i).getPAYNUM());
				obj.put("REMARK", lst.get(i).getREMARK());				
				
				jCell.add(obj);			
			}
		}else{
			JSONObject obj = new JSONObject();
			obj.put("SALEID", "");
			obj.put("PAYSEQ", "");
			obj.put("REGISTERSEQ", "");
			obj.put("PAYERNAME", "");
			obj.put("PAYERID", "");
			obj.put("PAYAMT", "");
			obj.put("GRADE", "");
			obj.put("DUTY", "");
			obj.put("SUDANGRATE", "");
			obj.put("ADDRATE", "");
			obj.put("TAXGUBUN", "");
			obj.put("TAXINCOME", "");
			obj.put("TAXLOCAL", "");
			obj.put("SUPPLYTAX", "");
			obj.put("DEDUCTAMT", "");
			obj.put("BANKID", "");
			obj.put("ACCTNO", "");
			obj.put("ACCTOWNER", "");
			obj.put("PAYNUM", "");
			obj.put("REMARK", "");
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListEnaSudangMst]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}	
	
	/**
	 * @name 수당관리 화면 - 팝업창 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/home/selectListEnaSaleSudangList.do")
	public ModelAndView selectListEnaSaleSudangList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		System.out.println("/home/selectListEnaSaleSudangList.do");
		
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
				
				jCell.add(obj);			
			}
		}else{
			JSONObject obj = new JSONObject();
			obj.put("SALEDATE", "");
			obj.put("SALEID", "");
			obj.put("SALERNM", "");
			obj.put("SALEAMT", "");
			obj.put("CONNAME", "");
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListEnaSaleSudangList]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}		
	
	
}
