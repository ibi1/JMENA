package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011001Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011001Ctr {
	
	@Resource(name = "SY011001Biz")
	private SY011001Biz SY011001Biz;
	
	public SY011001Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	/**
	 * @name 시스템 및 메뉴 관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011001.do")
	public ModelAndView SY011001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011001");
	}
	
	/**
	 * 시스템 메뉴 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSysMst.do")
	public ModelAndView selectListSysMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<SY011001VO> lst = SY011001Biz.selectListSysMst();
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			//jData.put("id", i+1);
			obj.put("SYSID", lst.get(i).getSYSID());
			obj.put("SYSNAME", lst.get(i).getSYSNAME());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			
			jCell.add(obj);
		}
		
//		json.put("page", 1);
//		json.put("total", 1);
//		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * 시스템 별 메뉴 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSysDtl.do")
	public ModelAndView selectListSysDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011001VO vo = new SY011001VO();
		
		vo.setSYSID(request.getParameter("SYSID"));
		
		List<SY011001VO> lst = SY011001Biz.selectListSysDtl(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			//jData.put("id", i+1);
			obj.put("MENUID", lst.get(i).getMENUID());
			obj.put("MENUNAME", lst.get(i).getMENUNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			
			jCell.add(obj);
		}
		
//		json.put("page", 1);
//		json.put("total", 1);
//		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	@RequestMapping("/home/insertDataSysMst.do")
	public ModelAndView insertDataSysMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011001VO vo = new SY011001VO();
		
		vo.setSYSID(request.getParameter("S_SYSID"));
		vo.setSYSNAME(request.getParameter("S_SYSNAME"));
		vo.setSORTKEY(request.getParameter("S_SORTKEY"));
		
		JSONObject json = new JSONObject();
		
		//SYSID Check
		boolean chkFlag = SY011001Biz.selectCheckSysId(vo);
		String resultCode = "";
		String resultMsg = "";
		
		//Insert SysMst
		if (chkFlag == true) { //New
			 if (SY011001Biz.insertDataSysMst(vo) == true) {
				resultCode ="SUCCESS";
			 } else {
				 resultCode ="FAILED";
				 resultMsg = "[ERROR]저장 중 오류가 발생하였습니다.";
			 }
		} else {
			 resultCode ="FAILED";
			 resultMsg = "[ERROR]동일한 시스템코드가 있습니다.";
		}

		json.put("resultCode", resultCode);
		json.put("resultMsg", resultMsg);

		logger.debug("[insertDataSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	
	
}
