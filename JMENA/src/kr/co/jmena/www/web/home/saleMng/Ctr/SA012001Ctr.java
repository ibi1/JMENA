package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM012001VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA012001Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012001VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@Controller
public class SA012001Ctr {
	
	@Resource(name = "SA012001Biz")
	private SA012001Biz SA012001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012001Ctr() {}
	
	/**
	 * @name 매출현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012001.do")
	public ModelAndView SA012001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012001");
	}

	/**
	 * @name 매출현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaSaleMstP.do")
	public ModelAndView selectListEnaSaleMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SA012001VO vo = new SA012001VO();
		
		vo.setS_SALEDATE(request.getParameter("S_SALEDATE"));
		vo.setS_BOROUGHCODE(request.getParameter("S_BOROUGHCODE"));
		vo.setS_KNAME(request.getParameter("S_KNAME"));
		
		
		List<SA012001VO> lst = SA012001Biz.selectListEnaSaleMstP(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			obj.put("DEPTCODE", lst.get(i).getDEPTCODE());
			obj.put("DEPTNAME", lst.get(i).getDEPTNAME());
			obj.put("GRADE", lst.get(i).getGRADE());
			obj.put("GRADE", lst.get(i).getGRADE());
			obj.put("JOINDATE", lst.get(i).getJOINDATE());
			obj.put("RETIREDATE", lst.get(i).getRETIREDATE());
			obj.put("O_BRANCHCODE", lst.get(i).getO_BRANCHCODE());
			obj.put("O_BRANCHNAME", lst.get(i).getO_BRANCHNAME());
			obj.put("O_JOINDATE", lst.get(i).getO_JOINDATE());
			obj.put("O_RETIREDATE", lst.get(i).getO_RETIREDATE());
			obj.put("EMPLOYGUBUN", lst.get(i).getEMPLOYGUBUN());
			obj.put("AMT1", lst.get(i).getAMT1());
			obj.put("AMT2", lst.get(i).getAMT2());
			obj.put("AMT3", lst.get(i).getAMT3());
			obj.put("AMT4", lst.get(i).getAMT4());
			obj.put("AMT5", lst.get(i).getAMT5());
			obj.put("AMT6", lst.get(i).getAMT6());
			obj.put("TOTAMT", lst.get(i).getTOTAMT());

			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	/**
	 * @name 매출현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012001_exportToExcel.do")
	public ModelAndView SA012001_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012001VO vo = new SA012001VO();
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();

		try {
	           
            String fileName = "SA012001_exportToExcel.xlsx";
            String filePath = "\\";
            fileName = URLEncoder.encode(fileName,"UTF-8"); // UTF-8로 인코딩
           
            // 다운로드 되는 파일명 설정
            //response.setHeader("Set-Cookie", "fileDownload=true; path=/\\");
            //response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
           
            // SXSSFWorkbook 생성
            SXSSFWorkbook workbook = new SXSSFWorkbook();
            workbook.setCompressTempFiles(true);
 
            // SXSSFSheet 생성
            SXSSFSheet sheet = (SXSSFSheet) workbook.createSheet();
            //sheet.setRandomAccessWindowSize(100); // 메모리 행 100개로 제한, 초과 시 Disk로 flush
           
            // 엑셀에 출력할 List
    		List<SA012001VO> lst = SA012001Biz.selectListEnaSaleMstP(vo);
            
         // Cell 스타일 값
            sheet.setDefaultColumnWidth(30);
            
            CellStyle style = workbook.createCellStyle();
            
            Font font = workbook.createFont();
            font.setFontName("Arial");
            style.setFont(font);
            style.setBorderBottom(BorderStyle.THIN); 
            style.setBorderLeft(BorderStyle.THIN);  
            style.setBorderRight(BorderStyle.THIN);  
            style.setBorderTop(BorderStyle.THIN); 
            


            // header 생성
            SXSSFRow header = (SXSSFRow) sheet.createRow(0);
            setHeaderCellValue(header);
            setHeaderStyle(header, style);

            // 행 데이터 생성
            int rowCount = 1;
            if(lst != null) {
            	for (SA012001VO sa012001vo : lst) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, sa012001vo);
            	}
            }
            
            FileOutputStream fileoutputstream=new FileOutputStream(filePath+fileName);

            //ServletOutputStream out = response.getOutputStream();
            
            workbook.write(fileoutputstream);
            if (fileoutputstream != null) fileoutputstream.close();
           
			obj.put("MSG", "success");
            
        } catch (Exception e) {
			obj.put("MSG", "error");
            throw e;
        }
		
		jCell.add(obj);
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}

	
    private void setHeaderCellValue(SXSSFRow header) {
    	header.createCell(0).setCellValue("지사코드");
    	header.createCell(1).setCellValue("지사");
    	header.createCell(2).setCellValue("부서코드");
    	header.createCell(3).setCellValue("부서");
    	header.createCell(4).setCellValue("직급");
    	header.createCell(5).setCellValue("성명");
    	header.createCell(6).setCellValue("입사일");
    	header.createCell(7).setCellValue("퇴사일");
    	header.createCell(8).setCellValue("전근무지코드");
    	header.createCell(9).setCellValue("전근무지");
    	header.createCell(10).setCellValue("입사");
    	header.createCell(11).setCellValue("퇴사");
    	header.createCell(12).setCellValue("고용구분");
    	header.createCell(13).setCellValue("DATE1");
    	header.createCell(14).setCellValue("DATE2");
    	header.createCell(15).setCellValue("DATE3");
    	header.createCell(16).setCellValue("DATE4");
    	header.createCell(17).setCellValue("DATE5");
    	header.createCell(18).setCellValue("DATE6");
    	header.createCell(19).setCellValue("합계");        
        
        
    }

    private void setHeaderStyle(SXSSFRow header, CellStyle style) {
        header.getCell(0).setCellStyle(style);
        header.getCell(1).setCellStyle(style);
        header.getCell(2).setCellStyle(style);
        header.getCell(3).setCellStyle(style);
        header.getCell(4).setCellStyle(style);
        header.getCell(5).setCellStyle(style);
        header.getCell(6).setCellStyle(style);
        header.getCell(7).setCellStyle(style);
        header.getCell(8).setCellStyle(style);
        header.getCell(9).setCellStyle(style);
        header.getCell(10).setCellStyle(style);
        header.getCell(11).setCellStyle(style);
        header.getCell(12).setCellStyle(style);
        header.getCell(13).setCellStyle(style);
        header.getCell(14).setCellStyle(style);
        header.getCell(15).setCellStyle(style);
        header.getCell(16).setCellStyle(style);
        header.getCell(17).setCellStyle(style);
        header.getCell(18).setCellStyle(style);
        header.getCell(19).setCellStyle(style);
        
    }


    private void setEachRow(SXSSFRow aRow, SA012001VO sa012001vo) {
    	aRow.createCell(0).setCellValue(sa012001vo.getBRANCHCODE());
    	aRow.createCell(1).setCellValue(sa012001vo.getBRANCHNAME());
    	aRow.createCell(2).setCellValue(sa012001vo.getDEPTCODE());
    	aRow.createCell(3).setCellValue(sa012001vo.getDEPTNAME());
    	aRow.createCell(4).setCellValue(sa012001vo.getGRADE());
    	aRow.createCell(5).setCellValue(sa012001vo.getGRADE());
    	aRow.createCell(6).setCellValue(sa012001vo.getJOINDATE());
    	aRow.createCell(7).setCellValue(sa012001vo.getRETIREDATE());
    	aRow.createCell(8).setCellValue(sa012001vo.getO_BRANCHCODE());
    	aRow.createCell(9).setCellValue(sa012001vo.getO_BRANCHNAME());
    	aRow.createCell(10).setCellValue(sa012001vo.getO_JOINDATE());
    	aRow.createCell(11).setCellValue(sa012001vo.getO_RETIREDATE());
    	aRow.createCell(12).setCellValue(sa012001vo.getEMPLOYGUBUN());
    	aRow.createCell(13).setCellValue(sa012001vo.getAMT1());
    	aRow.createCell(14).setCellValue(sa012001vo.getAMT2());
    	aRow.createCell(15).setCellValue(sa012001vo.getAMT3());
    	aRow.createCell(16).setCellValue(sa012001vo.getAMT4());
    	aRow.createCell(17).setCellValue(sa012001vo.getAMT5());
    	aRow.createCell(18).setCellValue(sa012001vo.getAMT6());
    	aRow.createCell(19).setCellValue(sa012001vo.getTOTAMT());
    }
	
}
