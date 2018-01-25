package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.common.util.ExcelUtil;
import kr.co.jmena.www.web.home.personMng.Vo.HR012003VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA012003Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012003VO;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
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
		
			List<SA012003VO> lst = SA012003Biz.selectListSaleMst(vo);
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("SALEDATE", lst.get(i).getSALEDATE());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONJUMINID", lst.get(i).getCONJUMINID());				
				obj.put("CONM2", lst.get(i).getCONM2());
				obj.put("REMARK", lst.get(i).getREMARK());
				obj.put("NAME_BRROWTYPE", lst.get(i).getNAME_BRROWTYPE());
				obj.put("BRROWAMT", lst.get(i).getBRROWAMT());
				obj.put("BRROWPERIOD", lst.get(i).getBRROWPERIOD());
				obj.put("BRROWDATE", lst.get(i).getBRROWDATE());
				obj.put("EXPIREDATE", lst.get(i).getEXPIREDATE());
				obj.put("PAYRATE", lst.get(i).getPAYRATE());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("TAXINCOME", lst.get(i).getTAXINCOME());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("ACTPAYAMT", lst.get(i).getACTPAYAMT());
				obj.put("PAYACCOUNT", lst.get(i).getPAYACCOUNT());
				obj.put("NAME_PAYBANK", lst.get(i).getNAME_PAYBANK());
				obj.put("EXTENDYN", lst.get(i).getEXTENDYN());
				obj.put("EXTENDDATE", lst.get(i).getEXTENDDATE());
				obj.put("CANCELYN", lst.get(i).getCANCELYN());
				obj.put("CANCELDATE", lst.get(i).getCANCELDATE());
				obj.put("PAYOWNER", lst.get(i).getPAYOWNER());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("MNGRNAME", lst.get(i).getMNGRNAME());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
	
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 엑셀 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012003_exportToExcel.do")
	public ModelAndView SA012003_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012003VO vo = new SA012003VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = ("ALL".equals(request.getParameter("S_DEPTCODE"))) ? "" : request.getParameter("S_DEPTCODE");
		String S_DCODE = ("ALL".equals(request.getParameter("S_DCODE"))) ? "" : request.getParameter("S_DCODE");		
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		File f = null;
		
		vo.setS_SALEDATE_FR(request.getParameter("S_SALEDATE_FR"));
		vo.setS_SALEDATE_TO(request.getParameter("S_SALEDATE_TO"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_DEPTCODE(S_DEPTCODE);
		vo.setS_DCODE(S_DCODE);
		vo.setS_KNAME(S_KNAME);
		
		if(!(request.getParameter("S_SALEDATE_FR").equals("") && 
				request.getParameter("S_SALEDATE_TO").equals(""))){
		
			List<SA012003VO> lst = SA012003Biz.selectListSaleMst(vo);
			
			ExcelUtil ex = ExcelUtil.getExcelUtil();
			SXSSFWorkbook wb = new SXSSFWorkbook();
			
			String[] heads = new String[]{"지사", "실장명", "계약일", "만기일", "담당자", "고객명", "주민번호", "구분", "기간", "금액", "이율", "이자", "갑근세", "주민세", "실수령액", "연장여부", "연장일", "중도해지", "중도해지일", "담보소재지", "계약면적", "입금은행", "입금계좌", "예금주", "비고"};
			int cellCnt = (heads.length - 1);
			
			try {
				// 엑셀 시트 생성
				ex.MakeExcelTitle(wb, "매출현황 - 소비대차", cellCnt);
				ex.MakeExcelHeader(wb, heads);
				
				for (int i = 0; i < lst.size(); i++) {
					List<Object> data = new ArrayList<Object>();
					List<Object> dataType = new ArrayList<Object>();
					
					data.add(lst.get(i).getBRANCHNAME());
					dataType.add("string");
					data.add(lst.get(i).getMNGRNAME());
					dataType.add("string");
					data.add(lst.get(i).getSALEDATE());
					dataType.add("string");
					data.add(lst.get(i).getEXPIREDATE());
					dataType.add("string");
					data.add(lst.get(i).getKNAME());
					dataType.add("string");
					data.add(lst.get(i).getCONNAME());
					dataType.add("string");
					data.add(lst.get(i).getCONJUMINID());
					dataType.add("string");
					data.add(lst.get(i).getNAME_BRROWTYPE());
					dataType.add("string");
					data.add(lst.get(i).getBRROWPERIOD());
					dataType.add("string");
					data.add(lst.get(i).getBRROWAMT());
					dataType.add("number");
					data.add(lst.get(i).getPAYRATE());
					dataType.add("number");
					data.add(lst.get(i).getPAYAMT());
					dataType.add("number");
					data.add(lst.get(i).getTAXINCOME());
					dataType.add("number");
					data.add(lst.get(i).getTAXLOCAL());
					dataType.add("number");
					data.add(lst.get(i).getACTPAYAMT());
					dataType.add("number");
					data.add(lst.get(i).getEXTENDYN());
					dataType.add("string");
					data.add(lst.get(i).getEXTENDDATE());
					dataType.add("string");
					data.add(lst.get(i).getCANCELYN());
					dataType.add("string");
					data.add(lst.get(i).getCANCELDATE());
					dataType.add("string");
					data.add(lst.get(i).getADDRESS());
					dataType.add("string");
					data.add(lst.get(i).getCONM2());
					dataType.add("decimal");
					data.add(lst.get(i).getNAME_PAYBANK());
					dataType.add("string");
					data.add(lst.get(i).getPAYACCOUNT());
					dataType.add("string");
					data.add(lst.get(i).getPAYOWNER());
					dataType.add("string");
					data.add(lst.get(i).getREMARK());
					dataType.add("string");
					
					// 엑셀 데이터 생성 
					ex.MakeExcelBody(wb, data, dataType);
				}
				
				ServletContext context = request.getServletContext();
				String filePath = context.getRealPath("/") +"WEB-INF"+ File.separator +"ExcelDownLoad"+ File.separator;
				String fileName = "SA012003_exportToExcel";
				
				// 엑셀 파일 생성
				f = ex.MakeExcelFile(wb, filePath, fileName);
				
			} catch (Exception e) {
				throw e;
			}
		}
		
		// 엑셀 다운로드
		return new ModelAndView("downloadView", "downloadFile", f);
	}	
}
