package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012003Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012003VO;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA012003Ctr {
	
	@Resource(name = "SA012003Biz")
	private SA012003Biz SA012003Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012003Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012003.do")
	public ModelAndView SA012003(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012003");
	}

	/**
	 * @name 매출관리 화면 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012003.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012003VO vo = new SA012003VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = ("ALL".equals(request.getParameter("S_DEPTCODE"))) ? "" : request.getParameter("S_DEPTCODE");
		
		vo.setS_SALEDATE_FR(request.getParameter("S_SALEDATE_FR"));
		vo.setS_SALEDATE_TO(request.getParameter("S_SALEDATE_TO"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(request.getParameter("S_KNAME"));

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(!(request.getParameter("S_SALEDATE_FR").equals("") && 
				request.getParameter("S_SALEDATE_TO").equals("") && 
				S_BRANCHCODE.equals("") && 
				S_DEPTCODE.equals("") && 
				request.getParameter("S_KNAME").equals(""))){
		
			List<SA012003VO> lst = SA012003Biz.selectListSA012003(vo);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
				obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
				obj.put("SALEDATE",lst.get(i).getSALEDATE());
				obj.put("SALEID",lst.get(i).getSALEID());
				obj.put("KNAME",lst.get(i).getKNAME());
				obj.put("CONNAME",lst.get(i).getCONNAME());
				obj.put("CONJUMINID",lst.get(i).getCONJUMINID());
				obj.put("BRROWTYPE",lst.get(i).getBRROWTYPE());
				obj.put("BRROWTERM",lst.get(i).getBRROWTERM());
				obj.put("BRROWAMT",lst.get(i).getBRROWAMT());
				obj.put("PAYRATE",lst.get(i).getPAYRATE());
				obj.put("PAYAMT",lst.get(i).getPAYAMT());
				obj.put("TAXAMT",lst.get(i).getTAXAMT());
				obj.put("JIGUEBAMT",lst.get(i).getJIGUEBAMT());
				obj.put("EXPIREDATE",lst.get(i).getEXPIREDATE());
				obj.put("EXTENDYN",lst.get(i).getEXTENDYN());
				obj.put("EXTENDDATE",lst.get(i).getEXTENDDATE());
				obj.put("CANCELYN",lst.get(i).getCANCELYN());
				obj.put("CANCELDATE",lst.get(i).getCANCELDATE());
				obj.put("ADDRESS",lst.get(i).getADDRESS());
				obj.put("BANKNAME",lst.get(i).getBANKNAME());
				obj.put("PAYACCOUNT",lst.get(i).getPAYACCOUNT());
				obj.put("PAYOWNER",lst.get(i).getPAYOWNER());
				obj.put("REMARK",lst.get(i).getREMARK());
	
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
}
