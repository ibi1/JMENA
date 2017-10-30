package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.personMng.Biz.HR012001Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012001VO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR012001Ctr {
	
	@Resource(name = "HR012001Biz")
	private HR012001Biz HR012001Biz;
	
	public HR012001Ctr() {}
	

	/**
	 * @name 입사자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012001.do")
	public ModelAndView HR012001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012001");
	}
	

	/**
	 * @name 인사관리 화면 - 인사관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListHR012001.do")
	public ModelAndView selectListHR012001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<HR012001VO> lst = HR012001Biz.selectListHR012001();
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
/*		for (int i = 0; i < lst.size(); i++) {
			//System.out.println(lst.get(i).getSYSID());
			JSONObject jData = new JSONObject();
			jData.put("SYSID", lst.get(i).getSYSID());
			jData.put("SYSNAME", lst.get(i).getSYSNAME());
			
			jsonArr.add(i, jData);
		}
*/		
		json.put("systemMenu", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
}
