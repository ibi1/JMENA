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
		
		vo.setS_SALEDATE_FR(request.getParameter("S_SALEDATE_FR"));
		vo.setS_SALEDATE_TO(request.getParameter("S_SALEDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(request.getParameter("S_KNAME"));
		
		List<SA012003VO> lst = SA012003Biz.selectListSA012003(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
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
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	/**
	 * @name 매출관리 화면 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012003_exportToExcel.do")
	public ModelAndView SA012003_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012003VO vo = new SA012003VO();
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();

		try {
	           
            String fileName = "SA012003_exportToExcel.xlsx";
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
            List<SA012003VO> lst = SA012003Biz.selectListSA012003(vo);
            
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
            	for (SA012003VO SA012003vo : lst) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, SA012003vo);
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
    	header.createCell(0).setCellValue("지사");
    	header.createCell(1).setCellValue("부서");
    	header.createCell(2).setCellValue("계약일");
    	header.createCell(3).setCellValue("계약번호");
    	header.createCell(4).setCellValue("담당자");
    	header.createCell(5).setCellValue("고객명");
    	header.createCell(6).setCellValue("주민번호");
    	header.createCell(7).setCellValue("지급구분");
    	header.createCell(8).setCellValue("차용기간");
    	header.createCell(9).setCellValue("차입금액");
    	header.createCell(10).setCellValue("지급이율(%)");
    	header.createCell(11).setCellValue("지급이자");
    	header.createCell(12).setCellValue("이자소득세");
    	header.createCell(13).setCellValue("실 수령액");
    	header.createCell(14).setCellValue("만기일");
    	header.createCell(15).setCellValue("연장여부");
    	header.createCell(16).setCellValue("연장일");
    	header.createCell(17).setCellValue("중도해지");
    	header.createCell(18).setCellValue("중도해지일");
    	header.createCell(19).setCellValue("담보소재지");
    	header.createCell(20).setCellValue("입금은행");
    	header.createCell(21).setCellValue("입금계좌");
    	header.createCell(22).setCellValue("예금주");
    	header.createCell(23).setCellValue("비고");
        
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
        header.getCell(20).setCellStyle(style);
        header.getCell(21).setCellStyle(style);
        header.getCell(22).setCellStyle(style);
        header.getCell(23).setCellStyle(style);
    }


    private void setEachRow(SXSSFRow aRow, SA012003VO SA012003vo) {
    	aRow.createCell(0).setCellValue(SA012003vo.getBRANCHNAME());
    	aRow.createCell(1).setCellValue(SA012003vo.getDEPTNAME());
    	aRow.createCell(2).setCellValue(SA012003vo.getSALEDATE());
    	aRow.createCell(3).setCellValue(SA012003vo.getSALEID());
    	aRow.createCell(4).setCellValue(SA012003vo.getKNAME());
    	aRow.createCell(5).setCellValue(SA012003vo.getCONNAME());
    	aRow.createCell(6).setCellValue(SA012003vo.getCONJUMINID());
    	aRow.createCell(7).setCellValue(SA012003vo.getBRROWTYPE());
    	aRow.createCell(8).setCellValue(SA012003vo.getBRROWTERM());
    	aRow.createCell(9).setCellValue(SA012003vo.getBRROWAMT());
    	aRow.createCell(10).setCellValue(SA012003vo.getPAYRATE());
    	aRow.createCell(11).setCellValue(SA012003vo.getPAYAMT());
    	aRow.createCell(12).setCellValue(SA012003vo.getTAXAMT());
    	aRow.createCell(13).setCellValue(SA012003vo.getJIGUEBAMT());
    	aRow.createCell(14).setCellValue(SA012003vo.getEXPIREDATE());
    	aRow.createCell(15).setCellValue(SA012003vo.getEXTENDYN());
    	aRow.createCell(16).setCellValue(SA012003vo.getEXTENDDATE());
    	aRow.createCell(17).setCellValue(SA012003vo.getCANCELYN());
    	aRow.createCell(18).setCellValue(SA012003vo.getCANCELDATE());
    	aRow.createCell(19).setCellValue(SA012003vo.getADDRESS());
    	aRow.createCell(20).setCellValue(SA012003vo.getBANKNAME());
    	aRow.createCell(21).setCellValue(SA012003vo.getPAYACCOUNT());
    	aRow.createCell(22).setCellValue(SA012003vo.getPAYOWNER());
    	aRow.createCell(23).setCellValue(SA012003vo.getREMARK());

    }
}
