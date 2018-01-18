package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.buyingMng.Biz.MM012003Biz;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012003VO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MM012003Ctr {

	@Resource(name = "MM012003Biz")
	private MM012003Biz MM012003Biz;
	
	/**
	 * @name 계약현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012003.do")
	public ModelAndView MM012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/buyingMng/MM012003");
	}
	
	/**
	 * @name 계약현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012003_s1.do")
	public ModelAndView selectListBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012003VO vo = new MM012003VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");
		String S_BUYGUBUN = request.getParameter("S_BUYGUBUN");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_KNAME = request.getParameter("S_KNAME");
		String S_ADDRESS = request.getParameter("S_ADDRESS");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BUYGUBUN(S_BUYGUBUN);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_ADDRESS(S_ADDRESS);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<MM012003VO> lst = MM012003Biz.selectListBuyMst(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYDATE", lst.get(i).getBUYDATE());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("REMM2", lst.get(i).getREMM2());
			obj.put("DCRATE", lst.get(i).getDCRATE());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("DEPOSITDATE", lst.get(i).getDEPOSITDATE());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("NAME_BRANCHCODE", lst.get(i).getNAME_BRANCHCODE());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
}
