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
	 * @name 수당관리 화면 - 수당관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings({ "unused", "unchecked" })
	@RequestMapping("/home/selectListEnaSudangMst.do")
	public ModelAndView selectListEnaSudangMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP011001VO vo = new EP011001VO();
		
		List<EP011001VO> lst = EP011001Biz.selectListEnaSudangMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				System.out.println("aaaaaa");
				System.out.println("ADDRESS       =  "  + lst.get(i).getADDRESS());
				
				JSONObject obj = new JSONObject();				
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
								
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				/*				obj.put("SALERCD", lst.get(i).getS_SALERCD());
				obj.put("SALERNM", lst.get(i).getSALERNM());
				obj.put("SUDANGRATE", lst.get(i).getSUDANGRATE());
				obj.put("ADDRATE", lst.get(i).getADDRATE());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("TAXGUBUN", lst.get(i).getTAXGUBUN());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());*/
				obj.put("REMARK", lst.get(i).getREMARK());
				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			
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
			
			obj.put("PAYDATE", "");
			/*			obj.put("SALERCD", "");
			obj.put("SALERNM", "");
			obj.put("SUDANGRATE", "");
			obj.put("ADDRATE", "");
			obj.put("PAYAMT", "");
			obj.put("TAXGUBUN", "");
			obj.put("TAXINCOME", "");
			obj.put("TAXLOCAL", "");
			obj.put("SUPPLYTAX", "");
			obj.put("DEDUCTAMT", "");*/
			obj.put("REMARK", "");			
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListEnaSudangMst]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}	
}
