package kr.co.jmena.www.web.home.systemMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Biz.SY011002Biz;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SY011002Ctr {
	
	@Resource(name = "SY011002Biz")
	private SY011002Biz SY011002Biz;
	
	public SY011002Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());

	/**
	 * @name 프로그램 관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SY011002.do")
	public ModelAndView SY011002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/systemMng/SY011002");
	}
	
	/**
	 * 프로그램 리스트 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListMenuPgmTb.do")
	public ModelAndView selectListMenuPgmTb(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SY011002VO vo = new SY011002VO();
		
		String sysId = ("ALL".equals(request.getParameter("SYSID"))) ? "" : request.getParameter("SYSID");
		String menuId = ("ALL".equals(request.getParameter("MENUID"))) ? "" : request.getParameter("MENUID");
		
		vo.setSYSID(sysId);
		vo.setMENUID(menuId);
		
		List<SY011002VO> lst = SY011002Biz.selectListMenuPgmTb(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			//jData.put("id", i+1);
			obj.put("SYSID", lst.get(i).getSYSID());
			obj.put("SYSNAME", lst.get(i).getSYSNAME());
			obj.put("MENUID", lst.get(i).getMENUID());
			obj.put("MENUNAME", lst.get(i).getMENUNAME());
			obj.put("PGMID", lst.get(i).getPGMID());
			obj.put("PGMNAME", lst.get(i).getPGMNAME());
			obj.put("SORTKEY", lst.get(i).getSORTKEY());
			obj.put("REMARK", lst.get(i).getREMARK());
			obj.put("USEYN", lst.get(i).getUSEYN());
			
			jCell.add(obj);
		}
		
//		json.put("page", 1);
//		json.put("total", 1);
//		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
