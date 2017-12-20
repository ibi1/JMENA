package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.buyingMng.Biz.MM012002Biz;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MM012002Ctr {

	@Resource(name = "MM012002Biz")
	private MM012002Biz MM012002Biz;

	protected final Logger logger = Logger.getLogger(getClass());
	
	public MM012002Ctr() {}
	
	/**
	 * @name 매출현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012002.do")
	public ModelAndView MM012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/buyingMng/MM012002");
	}
	
	/**
	 * @name 매출현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListMM012002.do")
	public ModelAndView selectListMM012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012002VO vo = new MM012002VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");
		String S_BUYGUBUN = request.getParameter("S_BUYGUBUN");
		String S_REGYN = request.getParameter("S_REGYN");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BUYGUBUN(S_BUYGUBUN);
		vo.setS_REGYN(S_REGYN);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<MM012002VO> lst = MM012002Biz.selectListMM012002(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYDATE", lst.get(i).getBUYDATE());
			obj.put("BUYGUBUNNAME", lst.get(i).getBUYGUBUNNAME());
			obj.put("FULLADDRESS", lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYPY", lst.get(i).getBUYPY());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			obj.put("REGNAME", lst.get(i).getREGNAME());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("REMM2", lst.get(i).getREMM2());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListMM012002]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
