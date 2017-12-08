package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012004Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012004VO;

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
public class SA012004Ctr {
	
	@Resource(name = "SA012004Biz")
	private SA012004Biz SA012004Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012004Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012004.do")
	public ModelAndView SA012004(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012004");
	}

	/**
	 * @name 매출관리 화면 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012004.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012004VO vo = new SA012004VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_SALERCD = ("ALL".equals(request.getParameter("S_SALERCD"))) ? "" : request.getParameter("S_SALERCD");
		
		String S_IPGUMPERSON = (URLDecoder.decode(request.getParameter("S_IPGUMPERSON"),"UTF-8"));
		
		vo.setS_IPGUMDATE_FR(request.getParameter("S_IPGUMDATE_FR"));
		vo.setS_IPGUMDATE_TO(request.getParameter("S_IPGUMDATE_TO"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_SALERCD(S_SALERCD);
		vo.setS_IPGUMGUBUN(request.getParameter("S_IPGUMGUBUN"));
		vo.setS_IPGUMPERSON(S_IPGUMPERSON);
		vo.setS_IPGUMAMT(request.getParameter("S_IPGUMAMT"));

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_IPGUMDATE_FR").equals("") && 
				request.getParameter("S_IPGUMDATE_TO").equals("") && 
				request.getParameter("S_IPGUMGUBUN").equals("") && 
				request.getParameter("S_IPGUMPERSON").equals("") && 
				request.getParameter("S_IPGUMAMT").equals(""))){
		
			List<SA012004VO> lst = SA012004Biz.selectListSA012004(vo);
			
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("IPGUMDATE",lst.get(i).getIPGUMDATE());
				obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
				obj.put("KNAME",lst.get(i).getKNAME());
				obj.put("CONNAME",lst.get(i).getCONNAME());
				obj.put("IPGUMGUBUN",lst.get(i).getIPGUMGUBUN());
				obj.put("IPGUMAMT",lst.get(i).getIPGUMAMT());
				obj.put("SUGUMAMT",lst.get(i).getSUGUMAMT());
				obj.put("JANGUMAMT",lst.get(i).getJANGUMAMT());
				obj.put("BANKNAME",lst.get(i).getBANKNAME());
				obj.put("IPGUMTYPE",lst.get(i).getIPGUMTYPE());
				obj.put("ADDRESS",lst.get(i).getADDRESS());
				obj.put("CONPY",lst.get(i).getCONPY());
				obj.put("REMARK",lst.get(i).getREMARK());
				
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	
}
