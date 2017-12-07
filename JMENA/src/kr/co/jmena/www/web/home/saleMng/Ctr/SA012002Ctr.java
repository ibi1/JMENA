package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012002Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012002VO;

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
public class SA012002Ctr {
	
	@Resource(name = "SA012002Biz")
	private SA012002Biz SA012002Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012002Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012002.do")
	public ModelAndView SA012002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012002");
	}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012002.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012002VO vo = new SA012002VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = ("ALL".equals(request.getParameter("S_DEPTCODE"))) ? "" : request.getParameter("S_DEPTCODE");
		String S_DCODE = ("ALL".equals(request.getParameter("S_DCODE"))) ? "" : request.getParameter("S_DCODE");
		
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_SALEDATE_FR(request.getParameter("S_SALEDATE_FR"));
		vo.setS_SALEDATE_TO(request.getParameter("S_SALEDATE_TO"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_DCODE(S_DCODE);
		vo.setS_KNAME(S_KNAME);
		
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_SALEDATE_FR").equals("") && 
				request.getParameter("S_SALEDATE_TO").equals(""))){
			
			List<SA012002VO> lst = SA012002Biz.selectListSA012002(vo);
			
//			System.out.println("******************************************");
//			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
				obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
				obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
				obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
				obj.put("SALEDATE",lst.get(i).getSALEDATE());
				obj.put("DCODENAME",lst.get(i).getDCODENAME());
				obj.put("SALEID",lst.get(i).getSALEID());
				obj.put("KNAME",lst.get(i).getKNAME());
				obj.put("CONNAME",lst.get(i).getCONNAME());
				obj.put("ADDRESS",lst.get(i).getADDRESS());
				obj.put("CONM2",lst.get(i).getCONM2());
				obj.put("CONPY",lst.get(i).getCONPY());
				obj.put("SALEAMT",lst.get(i).getSALEAMT());
				obj.put("DCRATE",lst.get(i).getDCRATE());
				obj.put("SELLAMT",lst.get(i).getSELLAMT());
				obj.put("SALEDANGA",lst.get(i).getSALEDANGA());
				obj.put("AGENCY_AMT",lst.get(i).getAGENCYAMT());
				obj.put("DEPOSITAMT1",lst.get(i).getDEPOSITAMT1());
				obj.put("DEPOSITAMT2",lst.get(i).getDEPOSITAMT2());
				obj.put("DEPOSITAMT3",lst.get(i).getDEPOSITAMT3());
				obj.put("SUGUMAMT1",lst.get(i).getSUGUMAMT1());
				obj.put("SUGUMAMT2",lst.get(i).getSUGUMAMT2());
				obj.put("SUGUMAMT3",lst.get(i).getSUGUMAMT3());
				obj.put("SUGUMAMT",lst.get(i).getSUGUMAMT());
				obj.put("REMNAMT",lst.get(i).getREMNAMT());
				obj.put("IPGUMRATE",lst.get(i).getIPGUMRATE());
				obj.put("REMARK",lst.get(i).getREMARK());
	
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}


}
