package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012011Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012011VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SA012011Ctr {
	
	@Resource(name = "SA012011Biz")
	private SA012011Biz SA012011Biz;

	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012011Ctr() {}
	
	/**
	 * @name 매출현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012011.do")
	public ModelAndView SA012011(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/saleMng/SA012011");
	}
	
	/**
	 * @name 매출현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012011.do")
	public ModelAndView selectListSA012011(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012011VO vo = new SA012011VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");		
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = URLDecoder.decode(request.getParameter("S_KNAME"), "UTF-8");
		String S_SALEGUBUN = request.getParameter("S_SALEGUBUN");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_SALEGUBUN(S_SALEGUBUN);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<SA012011VO> lst = SA012011Biz.selectListSA012011(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEGUBUNNAME", lst.get(i).getSALEGUBUNNAME());
			obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("MNGRNAME", lst.get(i).getMNGRNAME());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("FULLADDRESS", lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("SALEAMT", lst.get(i).getSALEAMT());
			obj.put("DCAMT", lst.get(i).getDCAMT());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("AGENCYAMT", lst.get(i).getAGENCYAMT());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSA012011]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
