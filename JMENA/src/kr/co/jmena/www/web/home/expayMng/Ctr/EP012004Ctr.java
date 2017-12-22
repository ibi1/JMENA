package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.expayMng.Biz.EP012004Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012004VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EP012004Ctr {

	@Resource(name = "EP012004Biz")
	private EP012004Biz EP012004Biz;

	protected final Logger logger = Logger.getLogger(getClass());
	
	public EP012004Ctr() {}
	
	/**
	 * @name 소득세 및 부가세신고 현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012004.do")
	public ModelAndView EP012004(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/expayMng/EP012004");
	}
	
	/**
	 * @name 소득세 및 부가세신고 현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEP012004.do")
	public ModelAndView selectListEP012004(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012004VO vo = new EP012004VO();
		
		String S_PAYDATE_FR = request.getParameter("S_PAYDATE_FR");
		String S_PAYDATE_TO = request.getParameter("S_PAYDATE_TO");		
		String S_TAXGUBUN = request.getParameter("S_TAXGUBUN");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = URLDecoder.decode(request.getParameter("S_KNAME"), "UTF-8");
		
		vo.setS_PAYDATE_FR(S_PAYDATE_FR);
		vo.setS_PAYDATE_TO(S_PAYDATE_TO);
		vo.setS_TAXGUBUN(S_TAXGUBUN);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<EP012004VO> lst = EP012004Biz.selectListEP012004(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());			
			obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
			obj.put("REGISTERSEQ", lst.get(i).getREGISTERSEQ());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("PAYERNAME", lst.get(i).getPAYERNAME());
			obj.put("PAYERID", lst.get(i).getPAYERID());
			obj.put("PAYDATE", lst.get(i).getPAYDATE());
			obj.put("FULLADDRESS", lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("PAYAMT", lst.get(i).getPAYAMT());
			obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
			obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
			obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
			obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEP012004]" + json);
		
		return new ModelAndView("jsonView", json);
	}		
}
