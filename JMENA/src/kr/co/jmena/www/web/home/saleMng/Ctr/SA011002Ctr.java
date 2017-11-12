package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA011002Biz;
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
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaSaleMst2.do")
	public ModelAndView selectListEnaSaleMst2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011002VO vo = new SA011002VO();

		vo.setSL_SALEID(request.getParameter("SL_SALEID"));
		
		vo.setSL_SALEDATE_TO(request.getParameter("SL_SALEDATE_TO"));
		vo.setSL_SALERCD(request.getParameter("SL_SALERCD"));
		vo.setSL_ADDRESS(request.getParameter("SL_ADDRESS"));
		
		
		List<SA011002VO> lst = SA011002Biz.selectListEnaSaleMst2(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("SALEDATE", lst.get(i).getSALEDATE());
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("SALERCD", lst.get(i).getSALERCD());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
				obj.put("CITYCODE", lst.get(i).getCITYCODE());
				obj.put("MANAGENO", lst.get(i).getMANAGENO());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("BUYM2", lst.get(i).getBUYM2());
				obj.put("JANM2", lst.get(i).getJANM2());
				obj.put("BUYPY", lst.get(i).getBUYPY());
				obj.put("JANPY", lst.get(i).getJANPY());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONJUMINID", lst.get(i).getCONJUMINID());
				obj.put("CONTELNO", lst.get(i).getCONTELNO());
				obj.put("CONADDRESS", lst.get(i).getCONADDRESS());
				obj.put("CONM2", lst.get(i).getCONM2());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("BRROWTYPE", lst.get(i).getBRROWTYPE());
				obj.put("BRROWAMT", lst.get(i).getBRROWAMT());
				obj.put("BRROWPERIOD", lst.get(i).getBRROWPERIOD());
				obj.put("PERIODGUBUN", lst.get(i).getPERIODGUBUN());
				obj.put("PAYRATE", lst.get(i).getPAYRATE());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("PAYACCOUNT", lst.get(i).getPAYACCOUNT());
				obj.put("PAYBANK", lst.get(i).getPAYBANK());
				obj.put("PAYOWNER", lst.get(i).getPAYOWNER());
				obj.put("BRROWDATE", lst.get(i).getBRROWDATE());
				obj.put("EXPIREDATE", lst.get(i).getEXPIREDATE());
				obj.put("EXTENDYN", lst.get(i).getEXTENDYN());
				obj.put("EXTENDDATE", lst.get(i).getEXTENDDATE());
				obj.put("CANCELYN", lst.get(i).getCANCELYN());
				obj.put("CANCELDATE", lst.get(i).getCANCELDATE());
				obj.put("REMARK", lst.get(i).getREMARK());
				obj.put("JOINYN", lst.get(i).getJOINYN());
				obj.put("REGYN", lst.get(i).getREGYN());
				obj.put("REGDATE", lst.get(i).getREGDATE());
				
				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			
			obj.put("SALEDATE", "");
			obj.put("SALEID", "");
			obj.put("SALERCD", "");
			obj.put("BRANCHNAME", "");
			obj.put("CITYCODE", "");
			obj.put("MANAGENO", "");
			obj.put("ADDRESS", "");
			obj.put("BUYM2", "");
			obj.put("JANM2", "");
			obj.put("BUYPY", "");
			obj.put("JANPY", "");
			obj.put("CONNAME", "");
			obj.put("CONJUMINID", "");
			obj.put("CONTELNO", "");
			obj.put("CONADDRESS", "");
			obj.put("CONM2", "");
			obj.put("CONPY", "");
			obj.put("BRROWTYPE", "");
			obj.put("BRROWAMT", "");
			obj.put("BRROWPERIOD", "");
			obj.put("PERIODGUBUN", "");
			obj.put("PAYRATE", "");
			obj.put("PAYAMT", "");
			obj.put("PAYACCOUNT", "");
			obj.put("PAYBANK", "");
			obj.put("PAYOWNER", "");
			obj.put("BRROWDATE", "");
			obj.put("EXPIREDATE", "");
			obj.put("EXTENDYN", "");
			obj.put("EXTENDDATE", "");
			obj.put("CANCELYN", "");
			obj.put("CANCELDATE", "");
			obj.put("REMARK", "");
			obj.put("JOINYN", "");
			obj.put("REGYN", "");
			obj.put("REGDATE", "");
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSA011002]" + json);
		
		return new ModelAndView("jsonView", json);	
	}

	
}
