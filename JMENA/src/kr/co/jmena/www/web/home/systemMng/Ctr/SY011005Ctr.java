package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011005Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011005VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011005Ctr {
	
	@Resource(name = "SY011005Biz")
	private SY011005Biz SY011005Biz;
	
	public SY011005Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	/**
	 * @name 공통코드관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011005.do")
	public ModelAndView SY011005(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011005");
	}
	
	/**
	 * sy_ccodemst 리스크 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListCcodeMst.do")
	public ModelAndView selectListCcodeMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011005VO vo = new SY011005VO();
		
		vo.setCCODENAME(request.getParameter("CCODENAME"));
		
		List<SY011005VO> lst = SY011005Biz.selectListCcodeMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("CCODE", lst.get(i).getCCODE());
			obj.put("CCODENAME", lst.get(i).getCCODENAME());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListCcodeMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * sy_ccodedtl 리스크 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListCcodeDtl.do")
	public ModelAndView selectListCcodeDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011005VO vo = new SY011005VO();
		
		vo.setCCODE(request.getParameter("CCODE"));
		
		List<SY011005VO> lst = SY011005Biz.selectListCcodeDtl(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("DCODE", lst.get(i).getDCODE());
			obj.put("DCODENAME", lst.get(i).getDCODENAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("AUX1", lst.get(i).getAUX1());
			obj.put("AUX1DESC", lst.get(i).getAUX1DESC());
			obj.put("AUX2", lst.get(i).getAUX2());
			obj.put("AUX2DESC", lst.get(i).getAUX2DESC());
			obj.put("AUX3", lst.get(i).getAUX3());
			obj.put("AUX3DESC", lst.get(i).getAUX3DESC());
			obj.put("AUX4", lst.get(i).getAUX4());
			obj.put("AUX4DESC", lst.get(i).getAUX4DESC());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListCcodeDtl]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
