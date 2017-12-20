package kr.co.jmena.www.web.home.personMng.Ctr;

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

import kr.co.jmena.www.web.home.personMng.Biz.HR012001Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012001VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR012001VO;

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
public class HR012001Ctr {
	
	@Resource(name = "HR012001Biz")
	private HR012001Biz HR012001Biz;
	
	public HR012001Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());

	/**
	 * @name 입사자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012001.do")
	public ModelAndView HR012001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012001");
	}
	

	/**
	 * @name 인사관리 화면 - 인사관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListHR012001.do")
	public ModelAndView selectListHR012001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR012001VO vo = new HR012001VO();
		HR012001VO vo1 = new HR012001VO();
		HR012001VO vo2 = new HR012001VO();

		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_JOINDATE_FR(request.getParameter("S_JOINDATE_FR"));
		vo.setS_JOINDATE_TO(request.getParameter("S_JOINDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(S_KNAME);
		vo.setS_JUMINID(request.getParameter("S_JUMINID"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		List<HR012001VO> lst = HR012001Biz.selectListHR012001(vo);
		
		
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			vo1.setINSACODE(lst.get(i).getINSACODE());
			
			List<HR012001VO> lst2 = HR012001Biz.selectListHR012001_2(vo1);
			if(lst2.size() > 0){
				for (int j = 0; j < lst.size(); j++) {
					if(j == 0){
						obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
						obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
						obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
						obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
						obj.put("GRADE",lst.get(i).getGRADE());
						obj.put("DUTY",lst.get(i).getDUTY());
						obj.put("EMPLOYGUBUN",lst.get(i).getEMPLOYGUBUN());
						obj.put("INSACODE",lst.get(i).getINSACODE());
						obj.put("KNAME",lst.get(i).getKNAME());
						obj.put("RECONAME",lst.get(i).getRECONAME());
						obj.put("JOINDATE",lst.get(i).getJOINDATE());
						obj.put("REMARK",lst.get(i).getREMARK());
					}else{
						obj.put("BRANCHCODE","");
						obj.put("BRANCHNAME","");
						obj.put("DEPTCODE","");
						obj.put("DEPTNAME","");
						obj.put("GRADE","");
						obj.put("DUTY","");
						obj.put("EMPLOYGUBUN","");
						obj.put("INSACODE","");
						obj.put("KNAME","");
						obj.put("RECONAME","");
						obj.put("JOINDATE","");
						obj.put("REMARK","");
						
					}
					obj.put("O_BRANCHNAME",lst2.get(j).getO_BRANCHNAME());
					obj.put("O_JOINDATE",lst2.get(j).getO_JOINDATE());
					obj.put("O_RETIREDATE",lst2.get(j).getO_RETIREDATE());
					obj.put("O_EMPLOYGUBUN",lst2.get(j).getO_EMPLOYGUBUN());
					
					vo2.setINSACODE(lst.get(i).getINSACODE());
					vo2.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
					vo2.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
					
					List<HR012001VO> lst3 = HR012001Biz.selectListHR012001_3(vo2);
					if(lst3.size() > 0){
						
						obj.put("O_SELLAMT",lst3.get(0).getO_SELLAMT());
						
					}else{
						obj.put("O_SELLAMT","");
					}
					
					jCell.add(obj);
				}
			}else{
				obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
				obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
				obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
				obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
				obj.put("GRADE",lst.get(i).getGRADE());
				obj.put("DUTY",lst.get(i).getDUTY());
				obj.put("EMPLOYGUBUN",lst.get(i).getEMPLOYGUBUN());
				obj.put("INSACODE",lst.get(i).getINSACODE());
				obj.put("KNAME",lst.get(i).getKNAME());
				obj.put("RECONAME",lst.get(i).getRECONAME());
				obj.put("JOINDATE",lst.get(i).getJOINDATE());
				obj.put("REMARK",lst.get(i).getREMARK());

				obj.put("O_BRANCHNAME","");
				obj.put("O_JOINDATE","");
				obj.put("O_RETIREDATE","");
				obj.put("O_EMPLOYGUBUN","");
				obj.put("O_SELLAMT","");
				
				jCell.add(obj);
			}
			
		}
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	/**
	 * @name 인원현황 엑셀 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012001_exportToExcel.do")
	public ModelAndView HR012001_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();
		
		HR012001VO vo = new HR012001VO();
		HR012001VO vo1 = new HR012001VO();
		HR012001VO vo2 = new HR012001VO();
		HR012001VO vo3 = new HR012001VO();
		
		
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_JOINDATE_FR(request.getParameter("S_JOINDATE_FR"));
		vo.setS_JOINDATE_TO(request.getParameter("S_JOINDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(S_KNAME);
		vo.setS_JUMINID(request.getParameter("S_JUMINID"));
		
		File down = null;
		final String _SEP = File.separator;
		
		try {
	           
            String fileName = "HR012001_exportToExcel.xlsx";
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
            
            List<HR012001VO> lstAll = new ArrayList<HR012001VO>();
			List<HR012001VO> lst = HR012001Biz.selectListHR012001(vo);
			for (int i = 0; i < lst.size(); i++) {
				vo3 = new HR012001VO();
				
				vo1.setINSACODE(lst.get(i).getINSACODE());
				
				List<HR012001VO> lst2 = HR012001Biz.selectListHR012001_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						vo3 = new HR012001VO();
						if(j == 0){
							
							vo3.setBRANCHNAME(lst.get(i).getBRANCHNAME());
							vo3.setDEPTNAME(lst.get(i).getDEPTNAME());
							vo3.setGRADE(lst.get(i).getGRADE());
							vo3.setDUTY(lst.get(i).getDUTY());
							vo3.setEMPLOYGUBUN(lst.get(i).getEMPLOYGUBUN());
							vo3.setINSACODE(lst.get(i).getINSACODE());
							vo3.setKNAME(lst.get(i).getKNAME());
							vo3.setRECONAME(lst.get(i).getRECONAME());
							vo3.setJOINDATE(lst.get(i).getJOINDATE());
							vo3.setREMARK(lst.get(i).getREMARK());
						}else{
							vo3.setBRANCHNAME("");
							vo3.setDEPTNAME("");
							vo3.setGRADE("");
							vo3.setDUTY("");
							vo3.setEMPLOYGUBUN("");
							vo3.setINSACODE("");
							vo3.setKNAME("");
							vo3.setRECONAME("");
							vo3.setJOINDATE("");
							vo3.setREMARK("");
						}
					
						vo3.setO_BRANCHNAME(lst2.get(j).getO_BRANCHNAME());
						vo3.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo3.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						vo3.setO_EMPLOYGUBUN(lst2.get(j).getO_EMPLOYGUBUN());
						
						vo2.setINSACODE(lst.get(i).getINSACODE());
						vo2.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo2.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						
						List<HR012001VO> lst3 = HR012001Biz.selectListHR012001_3(vo2);
						if(lst3.size() > 0){
							
							vo3.setO_SELLAMT(lst3.get(0).getO_SELLAMT());
							
						}else{
							vo3.setO_SELLAMT("");
						}
						
						lstAll.add(vo3);
					}
				}else{
					vo3 = new HR012001VO();
					vo3.setBRANCHNAME(lst.get(i).getBRANCHNAME());
					vo3.setDEPTNAME(lst.get(i).getDEPTNAME());
					vo3.setGRADE(lst.get(i).getGRADE());
					vo3.setDUTY(lst.get(i).getDUTY());
					vo3.setEMPLOYGUBUN(lst.get(i).getEMPLOYGUBUN());
					vo3.setINSACODE(lst.get(i).getINSACODE());
					vo3.setKNAME(lst.get(i).getKNAME());
					vo3.setRECONAME(lst.get(i).getRECONAME());
					vo3.setJOINDATE(lst.get(i).getJOINDATE());
					vo3.setREMARK(lst.get(i).getREMARK());

					vo3.setO_BRANCHNAME("");
					vo3.setO_JOINDATE("");
					vo3.setO_RETIREDATE("");
					vo3.setO_EMPLOYGUBUN("");
					vo3.setO_SELLAMT("");
					
					lstAll.add(vo3);
				}
				
			}            
            
            if(lstAll != null) {
            	for (HR012001VO HR012001vo : lstAll) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, HR012001vo);
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
        header.createCell(1).setCellValue("부서");
        header.createCell(2).setCellValue("직위");
        header.createCell(3).setCellValue("직급");
        header.createCell(4).setCellValue("고용구분");
        header.createCell(5).setCellValue("사번");
        header.createCell(6).setCellValue("성명");
        header.createCell(7).setCellValue("추천인");
        header.createCell(8).setCellValue("입사일");
        header.createCell(9).setCellValue("지사");
        header.createCell(10).setCellValue("입사");
        header.createCell(11).setCellValue("퇴사");
        header.createCell(12).setCellValue("실적");
        header.createCell(13).setCellValue("고용구분");
        header.createCell(14).setCellValue("비고");
        
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
    }
    

    private void setEachRow(SXSSFRow aRow, HR012001VO HR012001vo) {
    	
        aRow.createCell(0).setCellValue(HR012001vo.getBRANCHNAME());
        aRow.createCell(1).setCellValue(HR012001vo.getDEPTNAME());
        aRow.createCell(2).setCellValue(HR012001vo.getDUTY());
        aRow.createCell(3).setCellValue(HR012001vo.getGRADE());
        aRow.createCell(4).setCellValue(HR012001vo.getEMPLOYGUBUN());
        aRow.createCell(5).setCellValue(HR012001vo.getINSACODE());
        aRow.createCell(6).setCellValue(HR012001vo.getKNAME());
        aRow.createCell(7).setCellValue(HR012001vo.getRECONAME());
        aRow.createCell(8).setCellValue(HR012001vo.getJOINDATE());
        aRow.createCell(9).setCellValue(HR012001vo.getO_BRANCHNAME());
        aRow.createCell(10).setCellValue(HR012001vo.getO_JOINDATE());
        aRow.createCell(11).setCellValue(HR012001vo.getO_RETIREDATE());
        aRow.createCell(12).setCellValue(HR012001vo.getO_SELLAMT());
        aRow.createCell(13).setCellValue(HR012001vo.getO_EMPLOYGUBUN());
        aRow.createCell(14).setCellValue(HR012001vo.getREMARK());

    }
	
	
}
