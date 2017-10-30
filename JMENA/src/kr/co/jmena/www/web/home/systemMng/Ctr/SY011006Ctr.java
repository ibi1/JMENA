package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011006Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011006VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011006Ctr {
	
	@Resource(name = "SY011006Biz")
	private SY011006Biz SY011006Biz;
	
	public SY011006Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	/**
	 * @name 공통코드관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011006.do")
	public ModelAndView SY011006(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011006");
	}
	
	/**
	 * sy_bankmst 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListBankMst.do")
	public ModelAndView selectListBankMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011006VO vo = new SY011006VO();
		
		vo.setBANKNAME(request.getParameter("BANKNAME"));
		
		List<SY011006VO> lst = SY011006Biz.selectListBankMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BANKCODE", lst.get(i).getBANKCODE());
			obj.put("BANKNAME", lst.get(i).getBANKNAME());
			obj.put("USEYN", lst.get(i).getUSEYN());
			obj.put("AUXCODE", lst.get(i).getAUXCODE());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListBankMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
