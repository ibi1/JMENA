package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM012001VO;
import kr.co.jmena.www.web.home.buyingMng.Biz.MM012001Biz;

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
public class MM012001Ctr {
	
	@Resource(name = "MM012001Biz")
	private MM012001Biz MM012001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	public MM012001Ctr() {}
	
	/**
	 * @name 원지주 잔금현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012001.do")
	public ModelAndView MM012001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/buyingMng/MM012001");
	}

	/**
	 * @name 원지주 잔금현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEnaBuyMstP.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012001VO vo = new MM012001VO();
		
		vo.setS_CITYCODE(request.getParameter("S_CITYCODE"));
		vo.setS_BOROUGHCODE(request.getParameter("S_BOROUGHCODE"));
		vo.setS_ADDRESS(request.getParameter("S_ADDRESS"));
		
		
		List<MM012001VO> lst = MM012001Biz.selectListEnaBuyMstP(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("CITYCODE", lst.get(i).getCITYCODE());
			obj.put("CITYNAME", lst.get(i).getCITYNAME());
			obj.put("BOROUGHCODE", lst.get(i).getBOROUGHCODE());
			obj.put("BOROUGHNAME", lst.get(i).getBOROUGHNAME());
			obj.put("ADDRESS", lst.get(i).getADDRESS());
			obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
			obj.put("BUYM2", lst.get(i).getBUYM2());
			obj.put("BUYPY", lst.get(i).getBUYPY());
			obj.put("BUNBUYPY", lst.get(i).getBUNBUYPY());
			obj.put("JANBUYPY", lst.get(i).getJANBUYPY());
			obj.put("BUYAMT", lst.get(i).getBUYAMT());
			obj.put("PAYAMT1", lst.get(i).getPAYAMT1());
			obj.put("PAYDATE1", lst.get(i).getPAYDATE1());
			obj.put("PAYAMT2", lst.get(i).getPAYAMT2());
			obj.put("PAYDATE2", lst.get(i).getPAYDATE2());
			obj.put("PAYAMT3", lst.get(i).getPAYAMT3());
			obj.put("PAYDATE3", lst.get(i).getPAYDATE3());
			obj.put("PAYAMT4", lst.get(i).getPAYAMT4());
			obj.put("PAYDATE4", lst.get(i).getPAYDATE4());
			obj.put("JANPAYAMT", lst.get(i).getJANPAYAMT());
			obj.put("OPENYN", lst.get(i).getOPENYN());
			obj.put("REMARK", lst.get(i).getREMARK());

			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	/**
	 * @name 원지주 잔금현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012001_exportToExcel.do")
	public ModelAndView MM012001_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012001VO vo = new MM012001VO();
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();

		try {
	           
            String fileName = "MM012001_exportToExcel.xlsx";
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
            List<MM012001VO> lst = MM012001Biz.selectListEnaBuyMstP(vo);
            
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
            	for (MM012001VO mm012001vo : lst) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, mm012001vo);
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
        header.createCell(0).setCellValue("지역코드");
        header.createCell(1).setCellValue("지역");
		header.createCell(2).setCellValue("시/도코드");
		header.createCell(3).setCellValue("시/도");
		header.createCell(4).setCellValue("주소/지번");
		header.createCell(5).setCellValue("원지주");
		header.createCell(6).setCellValue("면적(m2)"); 
		header.createCell(7).setCellValue("평수");
		header.createCell(8).setCellValue("분양평수");
		header.createCell(9).setCellValue("잔여평수");
		header.createCell(10).setCellValue("매매대금");
		header.createCell(11).setCellValue("계약금");
		header.createCell(12).setCellValue("계약일");
		header.createCell(13).setCellValue("중도금1");
		header.createCell(14).setCellValue("중도일1");
		header.createCell(15).setCellValue("중도금2");
		header.createCell(16).setCellValue("중도일2");
		header.createCell(17).setCellValue("잔금액");
		header.createCell(18).setCellValue("잔금일");
		header.createCell(19).setCellValue("잔금누계");
		header.createCell(20).setCellValue("오픈여부");
		header.createCell(21).setCellValue("비고");        
        
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
    }


    private void setEachRow(SXSSFRow aRow, MM012001VO mm012001vo) {
        aRow.createCell(0).setCellValue(mm012001vo.getCITYCODE());
        aRow.createCell(1).setCellValue(mm012001vo.getCITYNAME());
        aRow.createCell(2).setCellValue(mm012001vo.getBOROUGHCODE());
        aRow.createCell(3).setCellValue(mm012001vo.getBOROUGHNAME());
        aRow.createCell(4).setCellValue(mm012001vo.getADDRESS());
        aRow.createCell(5).setCellValue(mm012001vo.getOWNERNAME());
        aRow.createCell(6).setCellValue(mm012001vo.getBUYM2());
        aRow.createCell(7).setCellValue(mm012001vo.getBUYPY());
        aRow.createCell(8).setCellValue(mm012001vo.getBUNBUYPY());
        aRow.createCell(9).setCellValue(mm012001vo.getJANBUYPY());
        aRow.createCell(10).setCellValue(mm012001vo.getBUYAMT());
        aRow.createCell(11).setCellValue(mm012001vo.getPAYAMT1());
        aRow.createCell(12).setCellValue(mm012001vo.getPAYDATE1());
        aRow.createCell(13).setCellValue(mm012001vo.getPAYAMT2());
        aRow.createCell(14).setCellValue(mm012001vo.getPAYDATE2());
        aRow.createCell(15).setCellValue(mm012001vo.getPAYAMT3());
        aRow.createCell(16).setCellValue(mm012001vo.getPAYDATE3());
        aRow.createCell(17).setCellValue(mm012001vo.getPAYAMT4());
        aRow.createCell(18).setCellValue(mm012001vo.getPAYDATE4());
        aRow.createCell(19).setCellValue(mm012001vo.getJANPAYAMT());
        aRow.createCell(20).setCellValue(mm012001vo.getOPENYN());
        aRow.createCell(21).setCellValue(mm012001vo.getREMARK());

    }

}
