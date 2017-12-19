package kr.co.jmena.www.web.home.personMng.Ctr;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.codeCom.Vo.BankVO;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012001VO;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.personMng.Biz.HR012003Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012003VO;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR012003Ctr {
	
	@Resource(name = "HR012003Biz")
	private HR012003Biz HR012003Biz;
	
	public HR012003Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	

	/**
	 * @name 인원현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012003.do")
	public ModelAndView HR012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012003");
	}

	/**
	 * @name 인원현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListHR012003.do")
	public ModelAndView selectListHR012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR012003VO vo = new HR012003VO();
		HR012003VO vo1 = new HR012003VO();
		
		vo.setS_JOINDATE(request.getParameter("S_JOINDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_JOINDATE").equals("") && 
				request.getParameter("S_BRANCHCODE").equals("") && 
				request.getParameter("S_DEPTCODE").equals(""))){

			List<HR012003VO> lst = HR012003Biz.selectListHR012003(vo);
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				vo1.setINSACODE(lst.get(i).getINSACODE());
				
				List<HR012003VO> lst2 = HR012003Biz.selectListHR012003_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						obj = new JSONObject();
						if(j == 0){
							obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
							obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
							obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
							obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
							obj.put("DUTY",lst.get(i).getDUTY());
							obj.put("INSACODE",lst.get(i).getINSACODE());
							obj.put("KNAME",lst.get(i).getKNAME());
							obj.put("RECOID",lst.get(i).getRECOID());
							obj.put("RECONAME",lst.get(i).getRECONAME());
							obj.put("JOINDATE",lst.get(i).getJOINDATE());
							obj.put("MOBILENO",lst.get(i).getMOBILENO());
							obj.put("JUMINID",lst.get(i).getJUMINID());
							obj.put("BIRTHDAYGUBUN",lst.get(i).getBIRTHDAYGUBUN());
							obj.put("ACCTOWNER",lst.get(i).getACCTOWNER());
							obj.put("BANKID",lst.get(i).getBANKID());
							obj.put("BANKNAME",lst.get(i).getBANKNAME());
							obj.put("ACCTNO",lst.get(i).getACCTNO());
							obj.put("PAYERNAME",lst.get(i).getPAYERNAME());
							obj.put("PAYERID",lst.get(i).getPAYERID());
							obj.put("ADDRESS",lst.get(i).getADDRESS());						
							
							
						}else{
							obj.put("BRANCHCODE","");
							obj.put("BRANCHNAME","");
							obj.put("DEPTCODE","");
							obj.put("DEPTNAME","");
							obj.put("DUTY","");
							obj.put("INSACODE","");
							obj.put("KNAME","");
							obj.put("RECOID","");
							obj.put("RECONAME","");
							obj.put("JOINDATE","");
							obj.put("MOBILENO","");
							obj.put("JUMINID","");
							obj.put("BIRTHDAYGUBUN","");
							obj.put("ACCTOWNER","");
							obj.put("BANKID","");
							obj.put("BANKNAME","");
							obj.put("ACCTNO","");
							obj.put("PAYERNAME","");
							obj.put("PAYERID","");
							obj.put("ADDRESS","");						
							
						}
						
						obj.put("O_BRANCHNAME",lst2.get(j).getO_BRANCHNAME());
						obj.put("O_JOINDATE",lst2.get(j).getO_JOINDATE());
						obj.put("O_RETIREDATE",lst2.get(j).getO_RETIREDATE());
						obj.put("O_EMPLOYGUBUN",lst2.get(j).getO_EMPLOYGUBUN());
	
						jCell.add(obj);
					}
				}else{
					obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
					obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
					obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
					obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
					obj.put("DUTY",lst.get(i).getDUTY());
					obj.put("INSACODE",lst.get(i).getINSACODE());
					obj.put("KNAME",lst.get(i).getKNAME());
					obj.put("RECOID",lst.get(i).getRECOID());
					obj.put("RECONAME",lst.get(i).getRECONAME());
					obj.put("JOINDATE",lst.get(i).getJOINDATE());
					obj.put("MOBILENO",lst.get(i).getMOBILENO());
					obj.put("JUMINID",lst.get(i).getJUMINID());
					obj.put("BIRTHDAYGUBUN",lst.get(i).getBIRTHDAYGUBUN());
					obj.put("ACCTOWNER",lst.get(i).getACCTOWNER());
					obj.put("BANKID",lst.get(i).getBANKID());
					obj.put("BANKNAME",lst.get(i).getBANKNAME());
					obj.put("ACCTNO",lst.get(i).getACCTNO());
					obj.put("PAYERNAME",lst.get(i).getPAYERNAME());
					obj.put("PAYERID",lst.get(i).getPAYERID());
					obj.put("ADDRESS",lst.get(i).getADDRESS());						
					
					
					obj.put("O_BRANCHNAME","");
					obj.put("O_JOINDATE","");
					obj.put("O_RETIREDATE","");
					obj.put("O_EMPLOYGUBUN","");
					
					jCell.add(obj);
				}
				
			}
		}
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	/**
	 * sy_bankmst 테이블 리스트 가져오기 (은행 코드 관리)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/personCnt.do")
	public ModelAndView personCnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR012003VO vo = new HR012003VO();
		
		vo.setS_JOINDATE(request.getParameter("S_JOINDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		
		List<HR012003VO> lst = HR012003Biz.selectpersonCnt(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("SUMCNT1", lst.get(i).getSUMCNT1());
			jData.put("SUMCNT2", lst.get(i).getSUMCNT2());
			jData.put("SUMCNT3", lst.get(i).getSUMCNT3());
			jData.put("SUMCNT4", lst.get(i).getSUMCNT4());
			jData.put("SUMCNT5", lst.get(i).getSUMCNT5());
			
			jsonArr.add(i, jData);
		}
		
		json.put("personCnt", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 인원현황 엑셀 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012003_exportToExcel.do")
	public ModelAndView HR012003_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();
		
		HR012003VO vo = new HR012003VO();
		HR012003VO vo1 = new HR012003VO();
		HR012003VO vo2 = new HR012003VO();
		
		vo.setS_JOINDATE(request.getParameter("S_JOINDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));

		try {
	           
            String fileName = "HR012003_exportToExcel.xlsx";
            
            //Windwos (local)
            //File folder = new File("C:\\ExcelDownLoad");
            //Linux & Unix (Server
            File folder = new File("//ExcelDownLoad");
            
            if (!folder.exists()) {
            folder.mkdirs();
            }
            
            //Windwos (local)
            //String filePath = "C:\\ExcelDownLoad\\";
            //Linux & Unix (Server
            String filePath = "//ExcelDownLoad//";
            
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
            
            List<HR012003VO> lstAll = new ArrayList<HR012003VO>();
			List<HR012003VO> lst = HR012003Biz.selectListHR012003(vo);
			for (int i = 0; i < lst.size(); i++) {
				vo2 = new HR012003VO();
				
				vo1.setINSACODE(lst.get(i).getINSACODE());
				
				List<HR012003VO> lst2 = HR012003Biz.selectListHR012003_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						vo2 = new HR012003VO();
						if(j == 0){
							
							vo2.setBRANCHCODE(lst.get(i).getBRANCHCODE());
							vo2.setBRANCHNAME(lst.get(i).getBRANCHNAME());
							vo2.setDEPTCODE(lst.get(i).getDEPTCODE());
							vo2.setDEPTNAME(lst.get(i).getDEPTNAME());
							vo2.setDUTY(lst.get(i).getDUTY());
							vo2.setINSACODE(lst.get(i).getINSACODE());
							vo2.setKNAME(lst.get(i).getKNAME());
							vo2.setRECOID(lst.get(i).getRECOID());
							vo2.setRECONAME(lst.get(i).getRECONAME());
							vo2.setJOINDATE(lst.get(i).getJOINDATE());
							vo2.setMOBILENO(lst.get(i).getMOBILENO());
							vo2.setJUMINID(lst.get(i).getJUMINID());
							vo2.setBIRTHDAYGUBUN(lst.get(i).getBIRTHDAYGUBUN());
							vo2.setACCTOWNER(lst.get(i).getACCTOWNER());
							vo2.setBANKID(lst.get(i).getBANKID());
							vo2.setBANKNAME(lst.get(i).getBANKNAME());
							vo2.setACCTNO(lst.get(i).getACCTNO());
							vo2.setPAYERNAME(lst.get(i).getPAYERNAME());
							vo2.setPAYERID(lst.get(i).getPAYERID());
							vo2.setADDRESS(lst.get(i).getADDRESS());						
							
						}else{
							vo2.setBRANCHCODE("");
							vo2.setBRANCHNAME("");
							vo2.setDEPTCODE("");
							vo2.setDEPTNAME("");
							vo2.setDUTY("");
							vo2.setINSACODE("");
							vo2.setKNAME("");
							vo2.setRECOID("");
							vo2.setRECONAME("");
							vo2.setJOINDATE("");
							vo2.setMOBILENO("");
							vo2.setJUMINID("");
							vo2.setBIRTHDAYGUBUN("");
							vo2.setACCTOWNER("");
							vo2.setBANKID("");
							vo2.setBANKNAME("");
							vo2.setACCTNO("");
							vo2.setPAYERNAME("");
							vo2.setPAYERID("");
							vo2.setADDRESS("");						
							
						}
						
						vo2.setO_BRANCHNAME(lst2.get(j).getO_BRANCHNAME());
						vo2.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo2.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						vo2.setO_EMPLOYGUBUN(lst2.get(j).getO_EMPLOYGUBUN());
	
						lstAll.add(vo2);
					}
				}else{
					vo2 = new HR012003VO();
					vo2.setBRANCHCODE(lst.get(i).getBRANCHCODE());
					vo2.setBRANCHNAME(lst.get(i).getBRANCHNAME());
					vo2.setDEPTCODE(lst.get(i).getDEPTCODE());
					vo2.setDEPTNAME(lst.get(i).getDEPTNAME());
					vo2.setDUTY(lst.get(i).getDUTY());
					vo2.setINSACODE(lst.get(i).getINSACODE());
					vo2.setKNAME(lst.get(i).getKNAME());
					vo2.setRECOID(lst.get(i).getRECOID());
					vo2.setRECONAME(lst.get(i).getRECONAME());
					vo2.setJOINDATE(lst.get(i).getJOINDATE());
					vo2.setMOBILENO(lst.get(i).getMOBILENO());
					vo2.setJUMINID(lst.get(i).getJUMINID());
					vo2.setBIRTHDAYGUBUN(lst.get(i).getBIRTHDAYGUBUN());
					vo2.setACCTOWNER(lst.get(i).getACCTOWNER());
					vo2.setBANKID(lst.get(i).getBANKID());
					vo2.setBANKNAME(lst.get(i).getBANKNAME());
					vo2.setACCTNO(lst.get(i).getACCTNO());
					vo2.setPAYERNAME(lst.get(i).getPAYERNAME());
					vo2.setPAYERID(lst.get(i).getPAYERID());
					vo2.setADDRESS(lst.get(i).getADDRESS());						
					
					
					vo2.setO_BRANCHNAME("");
					vo2.setO_JOINDATE("");
					vo2.setO_RETIREDATE("");
					vo2.setO_EMPLOYGUBUN("");
					
					lstAll.add(vo2);
				}
				
			}            
            
            if(lstAll != null) {
            	for (HR012003VO hr012003vo : lstAll) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, hr012003vo);
            	}
            }
            
            FileOutputStream fileoutputstream=new FileOutputStream(filePath+fileName);

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
        header.createCell(2).setCellValue("직급");
        header.createCell(3).setCellValue("사번");
        header.createCell(4).setCellValue("성명");
        header.createCell(5).setCellValue("추천인");
        header.createCell(6).setCellValue("입사일");
        header.createCell(7).setCellValue("전근무지");
        header.createCell(8).setCellValue("입사");
        header.createCell(9).setCellValue("퇴사");
        header.createCell(10).setCellValue("고용구분");
        header.createCell(11).setCellValue("연락처");
        header.createCell(12).setCellValue("주민번호");
        header.createCell(13).setCellValue("생일구분");
        header.createCell(14).setCellValue("입금자명");
        header.createCell(15).setCellValue("은행명");
        header.createCell(16).setCellValue("계좌번호");
        header.createCell(17).setCellValue("성명");
        header.createCell(18).setCellValue("주민번호");
        header.createCell(19).setCellValue("주소");
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


    private void setEachRow(SXSSFRow aRow, HR012003VO hr012003vo) {
        aRow.createCell(0).setCellValue(hr012003vo.getBRANCHNAME());
        aRow.createCell(1).setCellValue(hr012003vo.getDEPTNAME());
        aRow.createCell(2).setCellValue(hr012003vo.getDUTY());
        aRow.createCell(3).setCellValue(hr012003vo.getINSACODE());
        aRow.createCell(4).setCellValue(hr012003vo.getKNAME());
        aRow.createCell(5).setCellValue(hr012003vo.getRECONAME());
        aRow.createCell(6).setCellValue(hr012003vo.getJOINDATE());
        aRow.createCell(7).setCellValue(hr012003vo.getO_BRANCHNAME());
        aRow.createCell(8).setCellValue(hr012003vo.getO_JOINDATE());
        aRow.createCell(9).setCellValue(hr012003vo.getO_RETIREDATE());
        aRow.createCell(10).setCellValue(hr012003vo.getO_EMPLOYGUBUN());
        aRow.createCell(11).setCellValue(hr012003vo.getMOBILENO());
        aRow.createCell(12).setCellValue(hr012003vo.getJUMINID());
        aRow.createCell(13).setCellValue(hr012003vo.getBIRTHDAYGUBUN());
        aRow.createCell(14).setCellValue(hr012003vo.getACCTOWNER());
        aRow.createCell(15).setCellValue(hr012003vo.getBANKNAME());
        aRow.createCell(16).setCellValue(hr012003vo.getACCTNO());
        aRow.createCell(17).setCellValue(hr012003vo.getPAYERNAME());
        aRow.createCell(18).setCellValue(hr012003vo.getPAYERID());
        aRow.createCell(19).setCellValue(hr012003vo.getADDRESS());

    }

}
