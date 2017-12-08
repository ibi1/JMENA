package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY021001Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY021001Ctr {
	
	@Resource(name = "SY021001Biz")
	private SY021001Biz SY021001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SY021001Ctr() {}
	
	/**
	 * @name 사업자관리 Main 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY021001.do")
	public ModelAndView SY021001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/systemMng/SY021001");
	}

	
	/**
	 * @name 사업자관리 Main 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSY021001.do")
	public ModelAndView selectListSY021001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021001VO vo = new SY021001VO();

		List<SY021001VO> lst = SY021001Biz.selectListEnaCompanyMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("COMPANYNO", lst.get(i).getCOMPANYNO());
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
				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			
			obj.put("COMPANYNO", "");
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
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		logger.debug("[selectListSY021001]" + json);
		
		return new ModelAndView("jsonView", json);	
	}
	
	
	/**
	 * @name 사업자관리 Main 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/updateSY021001.do")
	public ModelAndView updateSY021001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SY021001VO vo = new SY021001VO();
		
		List<SY021001VO> lst = SY021001Biz.selectListEnaCompanyMst(vo);

		int updateCnt = 0;
		int insertCnt = 0;

		vo.setCOMPANYNO(request.getParameter("COMPANYNO"));
		vo.setSANGHO(request.getParameter("SANGHO"));
		vo.setOWNERNAME(request.getParameter("OWNERNAME"));
		vo.setOPENDATE(request.getParameter("OPENDATE"));
		vo.setREGISTNO(request.getParameter("REGISTNO"));
		vo.setADDRESS(request.getParameter("ADDRESS"));
		vo.setADDRESS_HEAD(request.getParameter("ADDRESS_HEAD"));
		vo.setUPTAE(request.getParameter("UPTAE"));
		vo.setUPJONG(request.getParameter("UPJONG"));
		vo.setTELNO(request.getParameter("TELNO"));
		vo.setRELEASEDATE(request.getParameter("RELEASEDATE"));
		vo.setRELEASEDESC(request.getParameter("RELEASEDESC"));
		vo.setTAXOFFICE(request.getParameter("TAXOFFICE"));
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			updateCnt = SY021001Biz.updateEnaCompanyMst(vo);
			
			
			JSONObject obj = new JSONObject();
			if(updateCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
			jCell.add(obj);
			json.put("rows", jCell);
			
		}else{
			insertCnt = SY021001Biz.insertEnaCompanyMst(vo);
			
			JSONObject obj = new JSONObject();
			obj.put("insertCnt", insertCnt);
			json.put("rows", jCell);
			if(insertCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
			jCell.add(obj);
			json.put("rows", jCell);
		}
				
		return new ModelAndView("jsonView", json);	
	}
	
	
	
	
}
