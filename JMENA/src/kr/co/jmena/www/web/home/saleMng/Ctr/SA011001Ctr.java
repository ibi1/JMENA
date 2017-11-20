package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA011001Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA011001Ctr {
	
	@Resource(name = "SA011001Biz")
	private SA011001Biz SA011001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA011001Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011001.do")
	public ModelAndView SA011001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011001");
	}

	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEanSaleMst.do")
	public ModelAndView selectListEanSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011001VO vo = new SA011001VO();
		
		vo.setSL_SALEDATE_FR(request.getParameter("SL_SALEDATE_FR"));
		vo.setSL_SALEDATE_TO(request.getParameter("SL_SALEDATE_TO"));
		vo.setSALERCD(request.getParameter("SL_SALERNAME"));			//담당자
		vo.setADDRESS(request.getParameter("SL_ADDRESS"));
		
		List<SA011001VO> lst = SA011001Biz.selectListEanSaleMst(vo);
		
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
		
		logger.debug("[selectListEanSaleMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
}
