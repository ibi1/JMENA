package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.expayMng.Biz.EP012002Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EP012002Ctr {
	
	@Resource(name = "EP012002Biz")
	private EP012002Biz EP012002Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public EP012002Ctr() {}
	
	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012002.do")
	public ModelAndView EP012002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP012002");
	}

	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEP012002.do")
	public ModelAndView selectListEP012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012002VO vo = new EP012002VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = ("ALL".equals(request.getParameter("S_DEPTCODE"))) ? "" : request.getParameter("S_DEPTCODE");
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));

		
		vo.setS_PAYDATE(request.getParameter("S_PAYDATE"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		List<EP012002VO> lst = EP012002Biz.selectListEP012002(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("PAYDATE",lst.get(i).getPAYDATE());
			obj.put("CONNAME",lst.get(i).getCONNAME());
			obj.put("CONADDRESS",lst.get(i).getCONADDRESS());
			obj.put("CONPY",lst.get(i).getCONPY());
			obj.put("PAYAMT",lst.get(i).getPAYAMT());
			
			if(lst.get(i).getEMPLOYGUBUN().equals("F")){
				obj.put("TAXAMT",lst.get(i).getTAXINCOME());
			}else{
				obj.put("TAXAMT",lst.get(i).getSUPPLYTAX());
			}
			
			obj.put("TAXLOCAL",lst.get(i).getTAXLOCAL());
			obj.put("DEDUCTAMT",lst.get(i).getDEDUCTAMT());
			
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
}
