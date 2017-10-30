package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY021003Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021003VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY021003Ctr {
	
	@Resource(name = "SY021003Biz")
	private SY021003Biz SY021003Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SY021003Ctr() {}
	
	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY021003.do")
	public ModelAndView SY021003(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY021003");
	}
	
	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaCityMst.do")
	public ModelAndView selectListEnaCityMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		List<SY021003VO> lst = SY021003Biz.selectListEnaCityMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			//jData.put("id", i+1);
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaCityDtl.do")
	public ModelAndView selectListEnaCityDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		System.out.println("CITYCODE====>"+request.getParameter("CITYCODE"));
		
		List<SY021003VO> lst = SY021003Biz.selectListEnaCityDtl(vo);
		
		System.out.println("lst.size()====>"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("BOROUGHCODE", lst.get(i).getBOROUGHCODE());
			obj.put("BOROUGHNAME", lst.get(i).getBOROUGHNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			obj.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * @name 지역관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/saveEnaCityMst.do")
	public ModelAndView saveEnaBranchMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY021003VO vo = new SY021003VO();
		
		System.out.println("BRANCHCODE==>"+request.getParameter("RS_CITYCODE"));
		System.out.println("BRANCHNAME==>"+request.getParameter("RS_CITYNAME"));
		System.out.println("USEYN==>"+request.getParameter("RS_SORTKEY"));
		
		vo.setCITYCODE(request.getParameter("RS_CITYCODE"));
		vo.setCITYNAME(request.getParameter("RS_CITYNAME"));
		vo.setSORTKEY(request.getParameter("RS_SORTKEY"));
		
		int updateCnt = 0;
		int insertCnt = 0;

		List<SY021003VO> lst = SY021003Biz.selectListEnaCityMst(vo);
		System.out.println("lst.size()==>"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			updateCnt = SY021003Biz.updateEnaCityMst(vo);
			
			
			JSONObject obj = new JSONObject();
			if(updateCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
			jCell.add(obj);
			json.put("rows", jCell);
			
		}else{
			insertCnt = SY021003Biz.insertEnaCityMst(vo);
			
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
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	
	}
	
}
