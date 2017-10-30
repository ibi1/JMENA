package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.personMng.Biz.HR011001Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR011001Ctr {
	
	@Resource(name = "HR011001Biz")
	private HR011001Biz HR011001Biz;
	
	public HR011001Ctr() {}
	
	/**
	 * @name 인사관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR011001.do")
	public ModelAndView HR011001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR011001");
	}
	
	/**
	 * @name 인사관리 화면 - 인사관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaInsaMst.do")
	public ModelAndView selectListEnaInsaMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<HR011001VO> lst = HR011001Biz.selectListEnaInsaMst();
		
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

	/**
	 * @name 인사관리 화면 - 발령사항 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaAppointItem.do")
	public ModelAndView selectListEnaAppointItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<HR011001VO> lst = HR011001Biz.selectListEnaInsaMst();
		
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
	
	/**
	 * @name 인사관리 화면 - 신고인 관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaTexPayerItem.do")
	public ModelAndView selectListEnaTexPayerItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<HR011001VO> lst = HR011001Biz.selectListEnaInsaMst();
		
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
