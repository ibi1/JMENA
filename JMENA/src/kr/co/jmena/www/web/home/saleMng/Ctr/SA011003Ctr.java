package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Vo.SA011003VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA011003Biz;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA011003Ctr {
	
	@Resource(name = "SA011003Biz")
	private SA011003Biz SA011003Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA011003Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA011003.do")
	public ModelAndView SA011003(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA011003");
	}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaIpgumMst.do")
	public ModelAndView selectListEnaIpgumMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA011003VO vo = new SA011003VO();

		vo.setSL_IPGUMID(request.getParameter("SL_IPGUMID"));
		
		vo.setSL_IPGUMDATE_FR(request.getParameter("SL_IPGUMDATE_FR"));
		vo.setSL_IPGUMDATE_TO(request.getParameter("SL_IPGUMDATE_TO"));
		vo.setSL_KNAME(request.getParameter("SL_KNAME"));
		vo.setSL_IPGUMGUBUN(request.getParameter("SL_IPGUMGUBUN"));
		vo.setSL_BANKGUBUN(request.getParameter("SL_BANKGUBUN"));
		vo.setSL_IPGUMAMT(request.getParameter("SL_IPGUMAMT"));
		
		
		List<SA011003VO> lst = SA011003Biz.selectListEnaIpgumMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("IPGUMDATE", lst.get(i).getIPGUMDATE());
				obj.put("IPGUMID", lst.get(i).getIPGUMID());
				obj.put("IPGUMTYPE", lst.get(i).getIPGUMTYPE());
				obj.put("IPGUMGUBUN", lst.get(i).getIPGUMGUBUN());
				obj.put("BANKGUBUN", lst.get(i).getBANKGUBUN());
				obj.put("IPGUMPERSON", lst.get(i).getIPGUMPERSON());
				obj.put("IPGUMAMT", lst.get(i).getIPGUMAMT());
				obj.put("SUGUMAMT", lst.get(i).getSUGUMAMT());
				obj.put("JANAMT", lst.get(i).getJANAMT());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("REMARK", lst.get(i).getREMARK());
				
				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			
			obj.put("IPGUMDATE", "");
			obj.put("IPGUMID", "");
			obj.put("IPGUMTYPE", "");
			obj.put("IPGUMGUBUN", "");
			obj.put("BANKGUBUN", "");
			obj.put("IPGUMPERSON", "");
			obj.put("IPGUMAMT", "");
			obj.put("SUGUMAMT", "");
			obj.put("JANAMT", "");
			obj.put("BRANCHNAME", "");
			obj.put("KNAME", "");
			obj.put("ADDRESS", "");
			obj.put("CONNAME", "");
			obj.put("CONPY", "");
			obj.put("REMARK", "");
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSA011003]" + json);
		
		return new ModelAndView("jsonView", json);	
	}

	
}
