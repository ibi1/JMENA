package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.common.util.ExcelUtil;
import kr.co.jmena.www.web.home.buyingMng.Biz.MM012002Biz;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012002VO;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MM012002Ctr {

	@Resource(name = "MM012002Biz")
	private MM012002Biz MM012002Biz;

	protected final Logger logger = Logger.getLogger(getClass());
	
	public MM012002Ctr() {}
	
	/**
	 * @name 매출현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012002.do")
	public ModelAndView MM012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/buyingMng/MM012002");
	}
	
	/**
	 * @name 매출현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012002_s1.do")
	public ModelAndView selectListBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012002VO vo = new MM012002VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");
		String S_BUYGUBUN = request.getParameter("S_BUYGUBUN");
		String S_REGYN = request.getParameter("S_REGYN");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BUYGUBUN(S_BUYGUBUN);
		vo.setS_REGYN(S_REGYN);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<MM012002VO> lst = MM012002Biz.selectListBuyMst(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BUYID", lst.get(i).getBUYID());
			obj.put("BUYDATE", lst.get(i).getBUYDATE());
			obj.put("NAME_BUYGUBUN", lst.get(i).getNAME_BUYGUBUN());
			obj.put("FULLADDRESS", lst.get(i).getNAME_CITYCODE() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYPY", lst.get(i).getBUYPY());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("BUYDANGA", lst.get(i).getBUYDANGA());
			obj.put("NAME_REGYN", lst.get(i).getNAME_REGYN());
			obj.put("REGDATE", lst.get(i).getREGDATE());
			obj.put("CONM2", lst.get(i).getCONM2());
			obj.put("REMM2", lst.get(i).getREMM2());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListBuyMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 매출현황 : 엑셀다운
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012002_e1.do")
	public ModelAndView exportToExcelBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012002VO vo = new MM012002VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");
		String S_BUYGUBUN = request.getParameter("S_BUYGUBUN");
		String S_REGYN = request.getParameter("S_REGYN");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BUYGUBUN(S_BUYGUBUN);
		vo.setS_REGYN(S_REGYN);
		
		List<MM012002VO> lst = MM012002Biz.selectListBuyMst(vo);
		
		File f = null;
		ExcelUtil ex = ExcelUtil.getExcelUtil();
		SXSSFWorkbook wb = new SXSSFWorkbook();
		
		String[] heads = new String[]{"매입구분", "원지주", "계약일자", "주소", "면적", "평수", "단가", "매매금액", "등기여부", "등기일자", "매출면적", "잔여면적"};
		int cellCnt = (heads.length - 1);
		
		try {
			// 엑셀 시트 생성
			ex.MakeExcelTitle(wb, "매입현황", cellCnt);
			ex.MakeExcelHeader(wb, heads);
			
			for(int i = 0; i < lst.size(); i++) {
				List<Object> data = new ArrayList<Object>();
				List<Object> dataType = new ArrayList<Object>();
				
				data.add(lst.get(i).getNAME_BUYGUBUN());
				dataType.add("string");
				data.add(lst.get(i).getOWNERNAME());
				dataType.add("string");
				data.add(lst.get(i).getBUYDATE());
				dataType.add("string");
				data.add(lst.get(i).getNAME_CITYCODE() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
				dataType.add("string");
				data.add(lst.get(i).getBUYM2());
				dataType.add("number");
				data.add(lst.get(i).getBUYPY());
				dataType.add("number");
				data.add(lst.get(i).getBUYDANGA());
				dataType.add("number");
				data.add(lst.get(i).getBUYAMT());
				dataType.add("number");
				data.add(lst.get(i).getNAME_REGYN());
				dataType.add("string");
				data.add(lst.get(i).getREGDATE());
				dataType.add("string");
				data.add(lst.get(i).getCONM2());
				dataType.add("number");
				data.add(lst.get(i).getREMM2());
				dataType.add("number");
				
				// 엑셀 데이터 생성 
				ex.MakeExcelBody(wb, data, dataType);
			}
			
			ServletContext context = request.getServletContext();
			String filePath = context.getRealPath("/") + "WEB-INF\\ExcelDownLoad\\";
			String fileName = "MM012002_exportToExcel";
			
			System.out.println(filePath);
			
			// 엑셀 파일 생성
			f = ex.MakeExcelFile(wb, filePath, fileName);
			
		} catch (Exception e) {
			throw e;
		}
		
		// 엑셀 다운로드
		return new ModelAndView("downloadView", "downloadFile", f);
	}	
}
