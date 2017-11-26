package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.expayMng.Biz.EP012001Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EP012001Ctr {
	
	@Resource(name = "EP012001Biz")
	private EP012001Biz EP012001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public EP012001Ctr() {}
	
	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012001.do")
	public ModelAndView EP012001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP012001");
	}
	
	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEP012001.do")
	public ModelAndView selectListEP012001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012001VO vo = new EP012001VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = ("ALL".equals(request.getParameter("S_DEPTCODE"))) ? "" : request.getParameter("S_DEPTCODE");

		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_PAYDATE(request.getParameter("S_PAYDATE"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(!(request.getParameter("S_PAYDATE").equals("") && 
				S_BRANCHCODE.equals("") && 
				S_DEPTCODE.equals("") && 
				request.getParameter("S_KNAME").equals(""))){
		
		
			List<EP012001VO> lst = EP012001Biz.selectListEP012001(vo);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
				obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
				obj.put("PAYDATE",lst.get(i).getPAYDATE());
				obj.put("CONNAME",lst.get(i).getCONNAME());
				obj.put("ADDRESS",lst.get(i).getADDRESS());
				obj.put("CONM2",lst.get(i).getCONM2());
				obj.put("CONPY",lst.get(i).getCONPY());
				obj.put("KNAME",lst.get(i).getKNAME());
				obj.put("PAYERNAME",lst.get(i).getPAYERNAME());
				obj.put("PAYERID",lst.get(i).getPAYERID());
				obj.put("PAYAMT",lst.get(i).getPAYAMT());
				obj.put("TAXINCOME",lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL",lst.get(i).getTAXLOCAL());
				obj.put("TOTTAX",lst.get(i).getTOTTAX());
				obj.put("DEDUCTAMT",lst.get(i).getDEDUCTAMT());
				
				jCell.add(obj);
			}
		}
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEP012001_2.do")
	public ModelAndView selectListEP012001_2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012001VO vo = new EP012001VO();
		
		vo.setS_PAYDATE(request.getParameter("S_PAYDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(request.getParameter("S_KNAME"));

		List<EP012001VO> lst = EP012001Biz.selectListEP012001_2(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
			obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
			obj.put("PAYDATE",lst.get(i).getPAYDATE());
			obj.put("CONNAME",lst.get(i).getCONNAME());
			obj.put("ADDRESS",lst.get(i).getADDRESS());
			obj.put("CONM2",lst.get(i).getCONM2());
			obj.put("CONPY",lst.get(i).getCONPY());
			obj.put("KNAME",lst.get(i).getKNAME());
			obj.put("SAUPOWNER",lst.get(i).getSAUPOWNER());
			obj.put("PAYERID",lst.get(i).getPAYERID());
			obj.put("PAYAMT",lst.get(i).getPAYAMT());
			obj.put("SUPPLYAMT",lst.get(i).getSUPPLYAMT());
			obj.put("SUPPLYTAX",lst.get(i).getSUPPLYTAX());
			obj.put("SUPPLYTAX2",lst.get(i).getSUPPLYTAX2());
			obj.put("DEDUCTAMT",lst.get(i).getDEDUCTAMT());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
}
