package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012013Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012013VO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SA012013Ctr {

	@Resource(name = "SA012013Biz")
	private SA012013Biz SA012013Biz;
	
	/**
	 * @name 해약현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012013.do")
	public ModelAndView SA012013(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/saleMng/SA012013");
	}
	
	/**
	 * @name 해약현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012013_s1.do")
	public ModelAndView selectListIpgumMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012013VO vo = new SA012013VO();
		
		String S_CHGDATE_FR = request.getParameter("S_CHGDATE_FR");
		String S_CHGDATE_TO = request.getParameter("S_CHGDATE_TO");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_KNAME = request.getParameter("S_KNAME");
		String S_CONNAME = request.getParameter("S_CONNAME");
		String S_ADDRESS = request.getParameter("S_ADDRESS");
		
		vo.setS_CHGDATE_FR(S_CHGDATE_FR);
		vo.setS_CHGDATE_TO(S_CHGDATE_TO);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_CONNAME(S_CONNAME);
		vo.setS_ADDRESS(S_ADDRESS);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<SA012013VO> lst = SA012013Biz.selectListSaleMst(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("SALEGUBUN", lst.get(i).getSALEGUBUN());
			obj.put("NAME_SALEGUBUN", lst.get(i).getNAME_SALEGUBUN());
			obj.put("SALERCD", lst.get(i).getSALERCD());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("CHGDATE", lst.get(i).getCHGDATE());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("CONPYDANGA", lst.get(i).getCONPYDANGA());
			obj.put("SUGUMAMT1", lst.get(i).getSUGUMAMT1());
			obj.put("SUGUMAMT2", lst.get(i).getSUGUMAMT2());
			obj.put("SUGUMAMT3", lst.get(i).getSUGUMAMT3());
			obj.put("SUM_SUGUMAMT", lst.get(i).getSUM_SUGUMAMT());
			obj.put("REFUNDAMT", lst.get(i).getREFUNDAMT());
			obj.put("REFUNDDATE", lst.get(i).getREFUNDDATE());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("NAME_BRANCHCODE", lst.get(i).getNAME_BRANCHCODE());
			obj.put("SUM_SUGUMRATE", lst.get(i).getSUM_SUGUMRATE());
			obj.put("REFUNDRATE", lst.get(i).getREFUNDRATE());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
}
