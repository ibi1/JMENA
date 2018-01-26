package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.File;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.common.util.ExcelUtil;
import kr.co.jmena.www.web.home.saleMng.Biz.SA012011Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012011VO;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SA012011Ctr {
	
	@Resource(name = "SA012011Biz")
	private SA012011Biz SA012011Biz;

	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012011Ctr() {}
	
	/**
	 * @name 매출현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012011.do")
	public ModelAndView SA012011(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/saleMng/SA012011");
	}
	
	/**
	 * @name 매출현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012011_s1.do")
	public ModelAndView selectListSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012011VO vo = new SA012011VO();
		
		String S_DEPOSITDATE_FR = request.getParameter("S_DEPOSITDATE_FR");
		String S_DEPOSITDATE_TO = request.getParameter("S_DEPOSITDATE_TO");		
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = URLDecoder.decode(request.getParameter("S_KNAME"), "UTF-8");
		String S_SALEGUBUN = request.getParameter("S_SALEGUBUN");
		
		vo.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
		vo.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_SALEGUBUN(S_SALEGUBUN);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<SA012011VO> lst = SA012011Biz.selectListSaleMst(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("DEPOSITDATE", lst.get(i).getDEPOSITDATE());
			obj.put("SALEDATE", lst.get(i).getSALEDATE());
			obj.put("NAME_SALEGUBUN", lst.get(i).getNAME_SALEGUBUN());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("SALEAMT", lst.get(i).getSALEAMT());
			obj.put("DCAMT", lst.get(i).getDCAMT());
			obj.put("SELLAMT", lst.get(i).getSELLAMT());
			obj.put("AGENCYAMT", lst.get(i).getAGENCYAMT());
			obj.put("FULLADDRESS", lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("KNAME", lst.get(i).getKNAME());
			obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			obj.put("MNGRNAME", lst.get(i).getMNGRNAME());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 매출현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012011_e1.do")
	public ModelAndView exportToExcelSaleMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012011VO vo = new SA012011VO();
		
		String S_DEPOSITDATE_FR = request.getParameter("S_DEPOSITDATE_FR");
		String S_DEPOSITDATE_TO = request.getParameter("S_DEPOSITDATE_TO");		
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = URLDecoder.decode(request.getParameter("S_KNAME"), "UTF-8");
		String S_SALEGUBUN = request.getParameter("S_SALEGUBUN");
		
		vo.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
		vo.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_SALEGUBUN(S_SALEGUBUN);
		
		List<SA012011VO> lst = SA012011Biz.selectListSaleMst(vo);
		
		File f = null;
		ExcelUtil ex = ExcelUtil.getExcelUtil();
		SXSSFWorkbook wb = new SXSSFWorkbook();
		
		String[] heads = new String[]{"매출구분", "지사", "계약날짜", "잔금입금일", "담당", "실장", "고객", "물건지", "평수", "매매가", "DC금액", "실판매가", "위탁수수료"};
		int cellCnt = (heads.length - 1);
		
		try {
			// 엑셀 시트 생성
			ex.MakeExcelTitle(wb, "매출현황", cellCnt);
			ex.MakeExcelHeader(wb, heads);
						
			for(int i = 0; i < lst.size(); i++) {
				List<Object> data = new ArrayList<Object>();
				List<Object> dataType = new ArrayList<Object>();
				
				data.add(lst.get(i).getNAME_SALEGUBUN());
				dataType.add("string");
				data.add(lst.get(i).getBRANCHNAME());
				dataType.add("string");
				data.add(lst.get(i).getSALEDATE());
				dataType.add("string");
				data.add(lst.get(i).getDEPOSITDATE());
				dataType.add("string");
				data.add(lst.get(i).getKNAME());
				dataType.add("string");
				data.add(lst.get(i).getMNGRNAME());
				dataType.add("string");
				data.add(lst.get(i).getCONNAME());
				dataType.add("string");
				data.add(lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
				dataType.add("string");
				data.add(lst.get(i).getCONPY());
				dataType.add("decimal");
				data.add(lst.get(i).getSALEAMT());
				dataType.add("number");
				data.add(lst.get(i).getDCAMT());
				dataType.add("number");
				data.add(lst.get(i).getSELLAMT());
				dataType.add("number");
				data.add(lst.get(i).getAGENCYAMT());
				dataType.add("number");
				
				// 엑셀 데이터 생성 
				ex.MakeExcelBody(wb, data, dataType);
			}
			
			ServletContext context = request.getServletContext();
			String filePath = context.getRealPath("/") +"WEB-INF"+ File.separator +"ExcelDownLoad"+ File.separator;
			String fileName = "SA012011_exportToExcel";
			
			// 엑셀 파일 생성
			f = ex.MakeExcelFile(wb, filePath, fileName);
			
		} catch (Exception e) {
			throw e;
		}
		
		// 엑셀 다운로드
		return new ModelAndView("downloadView", "downloadFile", f);
	}	
}
