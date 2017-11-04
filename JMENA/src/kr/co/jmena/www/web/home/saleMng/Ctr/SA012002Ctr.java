package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.FileOutputStream;
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
		
		vo.setS_SALEDATE_FR(request.getParameter("S_SALEDATE_FR"));
		vo.setS_SALEDATE_TO(request.getParameter("S_SALEDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_DCODE(request.getParameter("S_DCODE"));
		vo.setS_KNAME(request.getParameter("S_KNAME"));
		
		List<SA012002VO> lst = SA012002Biz.selectListSA012002(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
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
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012002_exportToExcel.do")
	public ModelAndView SA012002_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012002VO vo = new SA012002VO();
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();

		try {
	           
            String fileName = "SA012002_exportToExcel.xlsx";
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
            List<SA012002VO> lst = SA012002Biz.selectListSA012002(vo);
            
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
            	for (SA012002VO SA012002vo : lst) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, SA012002vo);
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
        header.createCell(3).setCellValue("매출구분");
        header.createCell(4).setCellValue("계약번호");
        header.createCell(5).setCellValue("담당자");
        header.createCell(6).setCellValue("고객명");
        header.createCell(7).setCellValue("주소");
        header.createCell(8).setCellValue("계약면적");
        header.createCell(9).setCellValue("계약평수");
        header.createCell(10).setCellValue("원 판매가");
        header.createCell(11).setCellValue("할인율(%)");
        header.createCell(12).setCellValue("실판매가");
        header.createCell(13).setCellValue("평단가");
        header.createCell(14).setCellValue("위탁수수료");
        header.createCell(15).setCellValue("계약금");
        header.createCell(16).setCellValue("중도금");
        header.createCell(17).setCellValue("잔금");
        header.createCell(18).setCellValue("계약입금액");
        header.createCell(19).setCellValue("중도입금액");
        header.createCell(20).setCellValue("잔금입금액");
        header.createCell(21).setCellValue("입금총액");
        header.createCell(22).setCellValue("입금잔액");
        header.createCell(23).setCellValue("입금율(%)");
        header.createCell(24).setCellValue("비고");
        
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
        header.getCell(24).setCellStyle(style);
    }


    private void setEachRow(SXSSFRow aRow, SA012002VO SA012002vo) {
    	aRow.createCell(0).setCellValue(SA012002vo.getBRANCHNAME());
    	aRow.createCell(1).setCellValue(SA012002vo.getDEPTNAME());
    	aRow.createCell(2).setCellValue(SA012002vo.getSALEDATE());
    	aRow.createCell(3).setCellValue(SA012002vo.getDCODENAME());
    	aRow.createCell(4).setCellValue(SA012002vo.getSALEID());
    	aRow.createCell(5).setCellValue(SA012002vo.getKNAME());
    	aRow.createCell(6).setCellValue(SA012002vo.getCONNAME());
    	aRow.createCell(7).setCellValue(SA012002vo.getADDRESS());
    	aRow.createCell(8).setCellValue(SA012002vo.getCONM2());
    	aRow.createCell(9).setCellValue(SA012002vo.getCONPY());
    	aRow.createCell(10).setCellValue(SA012002vo.getSALEAMT());
    	aRow.createCell(11).setCellValue(SA012002vo.getDCRATE());
    	aRow.createCell(12).setCellValue(SA012002vo.getSELLAMT());
    	aRow.createCell(13).setCellValue(SA012002vo.getSALEDANGA());
    	aRow.createCell(14).setCellValue(SA012002vo.getAGENCYAMT());
    	aRow.createCell(15).setCellValue(SA012002vo.getDEPOSITAMT1());
    	aRow.createCell(16).setCellValue(SA012002vo.getDEPOSITAMT2());
    	aRow.createCell(17).setCellValue(SA012002vo.getDEPOSITAMT3());
    	aRow.createCell(18).setCellValue(SA012002vo.getSUGUMAMT1());
    	aRow.createCell(19).setCellValue(SA012002vo.getSUGUMAMT2());
    	aRow.createCell(20).setCellValue(SA012002vo.getSUGUMAMT3());
    	aRow.createCell(21).setCellValue(SA012002vo.getSUGUMAMT());
    	aRow.createCell(22).setCellValue(SA012002vo.getREMNAMT());
    	aRow.createCell(23).setCellValue(SA012002vo.getIPGUMRATE());
    	aRow.createCell(24).setCellValue(SA012002vo.getREMARK());

    }
	
}
