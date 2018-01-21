package kr.co.jmena.www.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Repository;

@Repository("ExcelUtil")
public class ExcelUtil {
	
	private static ExcelUtil excelUtil = null;
	private FileOutputStream fst = null;	
	private File f = null;
	
	private ExcelUtil() {}
	
	public static ExcelUtil getExcelUtil() {
		if(excelUtil == null) excelUtil = new ExcelUtil();
		return excelUtil;
	}

	public void SetHeader(SXSSFRow row, int cellIdx, String name) {
		row.createCell(cellIdx).setCellValue(name);
	}
	
    /**
     * 헤더 Style
     * @param workbook
     * @return headStyle
     */
	public CellStyle HeadStyle(SXSSFWorkbook workbook) {
		
		CellStyle headStyle = workbook.createCellStyle();
		Font font = workbook.createFont();
		
		font.setBold(true);
		font.setFontName("맑은 고딕");
		font.setFontHeightInPoints((short)10);
		
		headStyle.setFont(font);
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		headStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);

		return headStyle;
	}
	
	/**
	 * 타이틀 Style
	 * @param workbook
	 * @return titleStyle
	 */
	public CellStyle TitleStyle(SXSSFWorkbook workbook) {

		CellStyle titleStyle = workbook.createCellStyle();		
		Font font = workbook.createFont();
		
		font.setBold(true);
		font.setFontName("맑은 고딕");
		font.setFontHeightInPoints((short)14);
		
		titleStyle.setFont(font);
		titleStyle.setAlignment(HorizontalAlignment.CENTER);
		titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		return titleStyle;
	}
	
	/**
	 * 데이터(텍스트) Style
	 * @param workbook
	 * @param cell
	 */
	public void setString(SXSSFWorkbook workbook, SXSSFCell cell) {
		
		CellStyle bodyStyle = workbook.createCellStyle();		
		Font font = workbook.createFont();
		
		font.setFontName("맑은 고딕");
		font.setFontHeightInPoints((short)10);
		
		bodyStyle.setFont(font);
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		
		cell.setCellType(CellType.STRING);
		cell.setCellStyle(bodyStyle);
	}
	
	/**
	 * 데이터(숫자) Style
	 * @param workbook
	 * @param cell
	 */
	public void setNumber(SXSSFWorkbook workbook, SXSSFCell cell) {
		
		CellStyle bodyStyle = workbook.createCellStyle();
		Font font = workbook.createFont();
		//DataFormat format = workbook.createDataFormat();
		
		font.setFontName("맑은 고딕");
		font.setFontHeightInPoints((short)10);
		
		bodyStyle.setFont(font);
		bodyStyle.setAlignment(HorizontalAlignment.RIGHT);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);		
		bodyStyle.setBorderRight(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		//bodyStyle.setDataFormat(format.getFormat("#,##0"));

		cell.setCellType(CellType.NUMERIC);
		cell.setCellStyle(bodyStyle);
	}
	
	/**
	 * 엑셀 타이틀 생성
	 * @param workbook
	 * @param title
	 * @param cellCnt
	 */
	public void MakeExcelTitle(SXSSFWorkbook workbook, String title, int cellCnt) {
	
		SXSSFSheet sheet = null;
		SXSSFRow row = null;
		CellStyle titleStyle = TitleStyle(workbook);
		
		sheet = workbook.createSheet(title);
		sheet.createRow(0);
		//sheet.createRow(1);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, cellCnt));
		
		row = sheet.getRow(0);
		row.createCell(0).setCellValue(title);
		row.getCell(0).setCellStyle(titleStyle);
	}
	
	/**
	 * 엑셀 헤더 생성
	 * @param workbook
	 * @return
	 */
	public void MakeExcelHeader(SXSSFWorkbook workbook, String[] heads) {
		
		SXSSFSheet sheet = null;
		SXSSFRow row = null;
		CellStyle headStyle = HeadStyle(workbook);
		
		// 헤더 로우 생성
		sheet = workbook.getSheetAt(0);
		row = sheet.createRow(1);
		
		for(int i = 0; i < heads.length; i++) {
			SetHeader(row, i, heads[i]);
			row.getCell(i).setCellStyle(headStyle);
		}
	}
	
	/**
	 * 엑셀 데이터 생성
	 * @param workbook
	 * @param data
	 * @param dataType
	 */
	public void MakeExcelBody(SXSSFWorkbook workbook, List<Object> data, List<Object> dataType) {
		
		SXSSFSheet sheet = workbook.getSheetAt(0);
		SXSSFRow row = null;

		row = sheet.createRow(sheet.getLastRowNum() + 1);
		
		for(int i = 0; i < data.size(); i++) {
			
			if(data.get(i) == null) data.set(i, "");
			
			if(dataType.get(i).equals("number")) {
				row.createCell(i).setCellValue(Double.parseDouble((String) data.get(i)));
				setNumber(workbook, row.getCell(i));
			} else {
				row.createCell(i).setCellValue(data.get(i).toString());
				setString(workbook, row.getCell(i));
			}
		}
	}	
	
    /**
     * 엑셀 파일 생성
     * @param workbook
     * @param filePath
     * @param fileName
     * @return f
     */
	public File MakeExcelFile(SXSSFWorkbook workbook, String filePath, String fileName) {
		
		try {
			// 파일 디렉토리 생성
			String dirPath = filePath.substring(0, filePath.length() - 1);	//마지막 문자열 "/" 제거
			File dir = new File(dirPath);    
			if (!dir.exists()) {
				dir.mkdirs();
			}
			
			// 파일 객체 생성
			File realFile = new File(filePath, fileName + ".xlsx");
			// 경로에 파일이 없을 경우 파일 생성
			if (!realFile.exists()) {
				realFile.createNewFile();
			}
								
			// 파일에 엑셀 데이터 담기
			fst = new FileOutputStream(filePath + fileName + ".xlsx");
			workbook.write(fst);
			fst.close();
			
			f = new File(filePath + fileName + ".xlsx");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
}
