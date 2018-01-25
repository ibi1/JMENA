package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.io.File;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.common.util.ExcelUtil;
import kr.co.jmena.www.web.home.expayMng.Biz.EP012004Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012004VO;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EP012004Ctr {

	@Resource(name = "EP012004Biz")
	private EP012004Biz EP012004Biz;

	protected final Logger logger = Logger.getLogger(getClass());
	
	public EP012004Ctr() {}
	
	/**
	 * @name 소득세 및 부가세신고 현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012004.do")
	public ModelAndView EP012004(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/expayMng/EP012004");
	}
	
	/**
	 * @name 소득세 및 부가세신고 현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012004_s1.do")
	public ModelAndView selectListSudangMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012004VO vo = new EP012004VO();
		
		String S_PAYDATE_FR = request.getParameter("S_PAYDATE_FR");
		String S_PAYDATE_TO = request.getParameter("S_PAYDATE_TO");		
		String S_TAXGUBUN = request.getParameter("S_TAXGUBUN");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = URLDecoder.decode(request.getParameter("S_KNAME"), "UTF-8");
		
		vo.setS_PAYDATE_FR(S_PAYDATE_FR);
		vo.setS_PAYDATE_TO(S_PAYDATE_TO);
		vo.setS_TAXGUBUN(S_TAXGUBUN);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<EP012004VO> lst = EP012004Biz.selectListSudangMst(vo);
		
		for(int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("SALEID", lst.get(i).getSALEID());
			obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
			obj.put("PAYDATE", lst.get(i).getPAYDATE());
			obj.put("REGISTERSEQ", lst.get(i).getREGISTERSEQ());
			obj.put("PAYERNAME", lst.get(i).getPAYERNAME());
			obj.put("PAYERID", lst.get(i).getPAYERID());
			obj.put("PAYAMT", lst.get(i).getPAYAMT());
			obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
			obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
			obj.put("SUPPLYTAX", lst.get(i).getSUPPLYTAX());
			obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
			obj.put("CONNAME", lst.get(i).getCONNAME());
			obj.put("CONPY", lst.get(i).getCONPY());
			obj.put("FULLADDRESS", lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
			obj.put("KNAME", lst.get(i).getKNAME());
			
			jCell.add(obj);
		}
		
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 소득세 및 부가세신고 현황 : 엑셀다운
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012004_e1.do")
	public ModelAndView exportToExcelSudangMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012004VO vo = new EP012004VO();
		
		String S_PAYDATE_FR = request.getParameter("S_PAYDATE_FR");
		String S_PAYDATE_TO = request.getParameter("S_PAYDATE_TO");		
		String S_TAXGUBUN = request.getParameter("S_TAXGUBUN");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = request.getParameter("S_DEPTCODE");
		String S_KNAME = URLDecoder.decode(request.getParameter("S_KNAME"), "UTF-8");
		
		vo.setS_PAYDATE_FR(S_PAYDATE_FR);
		vo.setS_PAYDATE_TO(S_PAYDATE_TO);
		vo.setS_TAXGUBUN(S_TAXGUBUN);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_KNAME(S_KNAME);
		
		List<EP012004VO> lst = EP012004Biz.selectListSudangMst(vo);
		
		File f = null;
		ExcelUtil ex = ExcelUtil.getExcelUtil();
		SXSSFWorkbook wb = new SXSSFWorkbook();
		
		String[] heads = new String[]{"담당", "소득신고인", "주민번호", "지급일", "물건지", "고객", "평수", "지급액", "부가세", "소득세", "주민세", "실지급액"};
		int cellCnt = (heads.length - 1);
		
		try {
			// 엑셀 시트 생성
			ex.MakeExcelTitle(wb, "소득세 및 부가세신고 현황", cellCnt);
			ex.MakeExcelHeader(wb, heads);
						
			for(int i = 0; i < lst.size(); i++) {
				List<Object> data = new ArrayList<Object>();
				List<Object> dataType = new ArrayList<Object>();
				
				data.add(lst.get(i).getKNAME());
				dataType.add("string");
				data.add(lst.get(i).getPAYERNAME());
				dataType.add("string");
				data.add(lst.get(i).getPAYERID());
				dataType.add("string");
				data.add(lst.get(i).getPAYDATE());
				dataType.add("string");
				data.add(lst.get(i).getCITYNAME() +" "+ lst.get(i).getBOROUGHNAME() +" "+ lst.get(i).getADDRESS());
				dataType.add("string");
				data.add(lst.get(i).getCONNAME());
				dataType.add("string");
				data.add(lst.get(i).getCONPY());
				dataType.add("decimal");
				data.add(lst.get(i).getPAYAMT());
				dataType.add("number");
				data.add(lst.get(i).getSUPPLYTAX());
				dataType.add("number");
				data.add(lst.get(i).getTAXINCOME());
				dataType.add("number");
				data.add(lst.get(i).getTAXLOCAL());
				dataType.add("number");
				data.add(lst.get(i).getDEDUCTAMT());
				dataType.add("number");
				
				// 엑셀 데이터 생성 
				ex.MakeExcelBody(wb, data, dataType);
			}
			
			ServletContext context = request.getServletContext();
			String filePath = context.getRealPath("/") +"WEB-INF"+ File.separator +"ExcelDownLoad"+ File.separator;
			String fileName = "EP012004_exportToExcel";
			
			// 엑셀 파일 생성
			f = ex.MakeExcelFile(wb, filePath, fileName);
			
		} catch (Exception e) {
			throw e;
		}
		
		// 엑셀 다운로드
		return new ModelAndView("downloadView", "downloadFile", f);
	}		
}
