package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.buyingMng.Biz.MM011001Biz;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MM011001Ctr {
	
	@Resource(name = "MM011001Biz")
	private MM011001Biz MM011001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	public MM011001Ctr() {}
	
	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM011001.do")
	public ModelAndView MM011001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/buyingMng/MM011001");
	}

	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaBuyMst.do")
	public ModelAndView selectListEnaBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setLS_BUYDATE_FR(request.getParameter("LS_BUYDATE_FR"));
		vo.setLS_BUYDATE_TO(request.getParameter("LS_BUYDATE_TO"));
		vo.setLS_INSERTUSER(request.getParameter("LS_INSERTUSER"));
		vo.setLS_ADDRESS(request.getParameter("LS_ADDRESS"));
		
		List<MM011001VO> lst = MM011001Biz.selectListEnaBuyMst(vo);
		
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
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYPY", lst.get(i).getBUYPY());
			obj.put("BUNJANM2", lst.get(i).getBUNJANM2());
			obj.put("BUNJANPY", lst.get(i).getBUNJANPY());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			obj.put("REGYN", lst.get(i).getREGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
			
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaPayScheduleTb.do")
	public ModelAndView selectListEnaPayScheduleTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		
		List<MM011001VO> lst = MM011001Biz.selectListEnaPayScheduleTb(vo);
		
		System.out.println("lst.size()====>"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYSEQ", lst.get(i).getBUYSEQ());
			obj.put("PAYGUBUN", lst.get(i).getPAYGUBUN());
			obj.put("PAYDATE", lst.get(i).getPAYDATE());
			obj.put("PAYAMT", lst.get(i).getPAYAMT());
			obj.put("PAYYN", lst.get(i).getPAYYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 매입관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaSalesOpenTb.do")
	public ModelAndView selectListEnaSalesOpenTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM011001VO vo = new MM011001VO();
		
		vo.setBUYID(request.getParameter("BUYID"));
		
		List<MM011001VO> lst = MM011001Biz.selectListEnaSalesOpenTb(vo);
		
		System.out.println("lst.size()====>"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("OPENYN", lst.get(i).getOPENYN());
			obj.put("HOLDINGYN", lst.get(i).getHOLDINGYN());
			obj.put("HOLDINGM2", lst.get(i).getHOLDINGM2());
			obj.put("HOLDINGPY", lst.get(i).getHOLDINGPY());
			obj.put("HOLDINGDATE", lst.get(i).getHOLDINGDATE());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	
}
