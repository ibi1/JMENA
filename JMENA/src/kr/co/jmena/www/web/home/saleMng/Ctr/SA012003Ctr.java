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
		
			List<SA012003VO> lst = SA012003Biz.selectListSA012003(vo);
			
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
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();
		
		SA012003VO vo = new SA012003VO();
		SA012003VO vo1 = new SA012003VO();
		
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
		
		File down = null;
		final String _SEP = File.separator;
		
		try {
	           
            String fileName = "SA012003_exportToExcel.xlsx";
            String webPath = _SEP + "WEB-INF" + _SEP + "ExcelDownLoad";
            
            ServletContext context = request.getServletContext();
            String appPath = context.getRealPath("/");
            
            File folder = new File(appPath + webPath);
            
            if (!folder.exists()) {
            folder.mkdirs();
            }
            
            String filePath = appPath + webPath + _SEP;
            
            fileName = URLEncoder.encode(fileName,"UTF-8"); // UTF-8로 인코딩
           
            // SXSSFWorkbook 생성
            SXSSFWorkbook workbook = new SXSSFWorkbook();
            workbook.setCompressTempFiles(true);
 
            // SXSSFSheet 생성
            SXSSFSheet sheet = (SXSSFSheet) workbook.createSheet();
            //sheet.setRandomAccessWindowSize(100); // 메모리 행 100개로 제한, 초과 시 Disk로 flush
           
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
            style.setFillBackgroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            
            
            // header 생성
            SXSSFRow header = (SXSSFRow) sheet.createRow(0);
            setHeaderCellValue(header);
            setHeaderStyle(header, style);

            // 행 데이터 생성
            int rowCount = 1;
            
            List<SA012003VO> lstAll = new ArrayList<SA012003VO>();
			List<SA012003VO> lst = SA012003Biz.selectListSA012003(vo);
			
			for (int i = 0; i < lst.size(); i++) {
				vo1 = new SA012003VO();
				
				vo1.setBRANCHNAME(lst.get(i).getBRANCHNAME());
				vo1.setDEPTNAME(lst.get(i).getDEPTNAME());
				vo1.setSALEDATE(lst.get(i).getSALEDATE());
				vo1.setSALEID(lst.get(i).getSALEID());
				vo1.setKNAME(lst.get(i).getKNAME());
				vo1.setCONNAME(lst.get(i).getCONNAME());
				vo1.setCONJUMINID(lst.get(i).getCONJUMINID());
				vo1.setBRROWTYPE(lst.get(i).getBRROWTYPE());
				vo1.setBRROWTERM(lst.get(i).getBRROWTERM());
				vo1.setBRROWAMT(lst.get(i).getBRROWAMT());
				vo1.setPAYRATE(lst.get(i).getPAYRATE());
				vo1.setPAYAMT(lst.get(i).getPAYAMT());
				vo1.setTAXAMT(lst.get(i).getTAXAMT());
				vo1.setJIGUEBAMT(lst.get(i).getJIGUEBAMT());
				vo1.setEXPIREDATE(lst.get(i).getEXPIREDATE());
				vo1.setEXTENDYN(lst.get(i).getEXTENDYN());
				vo1.setEXTENDDATE(lst.get(i).getEXTENDDATE());
				vo1.setCANCELYN(lst.get(i).getCANCELYN());
				vo1.setCANCELDATE(lst.get(i).getCANCELDATE());
				vo1.setADDRESS(lst.get(i).getADDRESS());
				vo1.setBANKNAME(lst.get(i).getBANKNAME());
				vo1.setPAYACCOUNT(lst.get(i).getPAYACCOUNT());
				vo1.setPAYOWNER(lst.get(i).getPAYOWNER());
				vo1.setREMARK(lst.get(i).getREMARK());
	
				lstAll.add(vo1);
			}
            
            if(lstAll != null) {
            	for (SA012003VO SA012003vo : lstAll) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, SA012003vo);
            	}
            }
            
            FileOutputStream fileoutputstream=new FileOutputStream(filePath+fileName);

            workbook.write(fileoutputstream);
            if (fileoutputstream != null) fileoutputstream.close();

            //이전에 엑셀 파일을 만든 후 서버에 저장하고 아래 파일에 서버에 저장한 놈을 가져온다.
           down = new File(filePath+fileName);
        } catch (Exception e) {
            throw e;
        }
		
		//downloadView로 해당 파일을 다운로드
		return new ModelAndView("downloadView","downloadFile",down);
	}

	
    private void setHeaderCellValue(SXSSFRow header) {
        
        header.createCell(0).setCellValue("지사");
        header.createCell(1).setCellValue("실장명");
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


    private void setEachRow(SXSSFRow aRow, SA012003VO sa012003vo) {

        aRow.createCell(0).setCellValue(sa012003vo.getBRANCHNAME());
        aRow.createCell(1).setCellValue(sa012003vo.getDEPTNAME());
        aRow.createCell(2).setCellValue(sa012003vo.getSALEDATE());
        aRow.createCell(3).setCellValue(sa012003vo.getSALEID());
        aRow.createCell(4).setCellValue(sa012003vo.getKNAME());
        aRow.createCell(5).setCellValue(sa012003vo.getCONNAME());
        aRow.createCell(6).setCellValue(sa012003vo.getCONJUMINID());
        aRow.createCell(7).setCellValue(sa012003vo.getBRROWTYPE());
        aRow.createCell(8).setCellValue(sa012003vo.getBRROWTERM());
        aRow.createCell(9).setCellValue(sa012003vo.getBRROWAMT());
        aRow.createCell(10).setCellValue(sa012003vo.getPAYRATE());
        aRow.createCell(11).setCellValue(sa012003vo.getPAYAMT());
        aRow.createCell(12).setCellValue(sa012003vo.getTAXAMT());
        aRow.createCell(13).setCellValue(sa012003vo.getJIGUEBAMT());
        aRow.createCell(14).setCellValue(sa012003vo.getEXPIREDATE());
        aRow.createCell(15).setCellValue(sa012003vo.getEXTENDYN());
        aRow.createCell(16).setCellValue(sa012003vo.getEXTENDDATE());
        aRow.createCell(17).setCellValue(sa012003vo.getCANCELYN());
        aRow.createCell(18).setCellValue(sa012003vo.getCANCELDATE());
        aRow.createCell(19).setCellValue(sa012003vo.getADDRESS());
        aRow.createCell(20).setCellValue(sa012003vo.getBANKNAME());
        aRow.createCell(21).setCellValue(sa012003vo.getPAYACCOUNT());
        aRow.createCell(22).setCellValue(sa012003vo.getPAYOWNER());
        aRow.createCell(23).setCellValue(sa012003vo.getREMARK());
        
    }
	
	
}
