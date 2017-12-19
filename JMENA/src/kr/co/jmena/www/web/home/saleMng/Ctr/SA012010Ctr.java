package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012010Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012010VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SA012010Ctr {

	@Resource(name = "SA012010Biz")
	private SA012010Biz SA012010Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012010Ctr() {}
	
	/**
	 * @name 위탁매출 - 위탁수수료 현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012010.do")
	public ModelAndView SA012010(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/saleMng/SA012010");
	}
	
	/**
	 * @name 위탁매출 - 위탁수수료 현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012010.do")
	public ModelAndView selectListSA012010(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012010VO vo = new SA012010VO();
		
		String S_SALEDATE = request.getParameter("S_SALEDATE");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_SALEDATE_FR(S_SALEDATE +"-01");
		vo.setS_SALEDATE_TO(S_SALEDATE +"-31");
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<SA012010VO> lst = SA012010Biz.selectListSA012010(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("DEPOSITDATE", lst.get(i).getDEPOSITDATE());
			obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			obj.put("DEPTNAME", lst.get(i).getDEPTNAME());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("MNGRNAME", lst.get(i).getMNGRNAME());
			obj.put("FULLADDRESS", lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("SALEAMT", lst.get(i).getSALEAMT());
			obj.put("AGENCYAMT", lst.get(i).getAGENCYAMT());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}	
}
