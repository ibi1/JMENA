package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	@RequestMapping("/home/selectListEnaSaleMst.do")
	public ModelAndView selectListEnaSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SA011001VO vo = new SA011001VO();

		List<SA011001VO> lst = SA011001Biz.selectListEnaSaleMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
/*				obj.put("COMPANYNO", lst.get(i).getCOMPANYNO());
				obj.put("SANGHO", lst.get(i).getSANGHO());
				obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
				obj.put("OPENDATE", lst.get(i).getOPENDATE());
				obj.put("REGISTNO", lst.get(i).getREGISTNO());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("ADDRESS_HEAD", lst.get(i).getADDRESS_HEAD());
				obj.put("UPTAE", lst.get(i).getUPTAE());
				obj.put("UPJONG", lst.get(i).getUPJONG());
				obj.put("TELNO", lst.get(i).getTELNO());
				obj.put("RELEASEDATE", lst.get(i).getRELEASEDATE());
				obj.put("RELEASEDESC", lst.get(i).getRELEASEDESC());
				obj.put("TAXOFFICE", lst.get(i).getTAXOFFICE());
*/				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			
/*			obj.put("COMPANYNO", "");
			obj.put("SANGHO", "");
			obj.put("OWNERNAME", "");
			obj.put("OPENDATE", "");
			obj.put("REGISTNO", "");
			obj.put("ADDRESS", "");
			obj.put("ADDRESS_HEAD", "");
			obj.put("UPTAE", "");
			obj.put("UPJONG", "");
			obj.put("TELNO", "");
			obj.put("RELEASEDATE", "");
			obj.put("RELEASEDESC", "");
			obj.put("TAXOFFICE", "");
*/			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSA011001]" + json);
		
		return new ModelAndView("jsonView", json);	
	}
	
}
