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

import kr.co.jmena.www.web.home.personMng.Biz.HR012002Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;

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
public class HR012002Ctr {
	
	@Resource(name = "HR012002Biz")
	private HR012002Biz HR012002Biz;
	
	public HR012002Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	/**
	 * @name 퇴사자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012002.do")
	public ModelAndView HR012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012002");
	}

	/**
	 * @name 인사관리 화면 - 인사관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListHR012002.do")
	public ModelAndView selectListHR012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR012002VO vo = new HR012002VO();
		HR012002VO vo1 = new HR012002VO();
		HR012002VO vo2 = new HR012002VO();
		HR012002VO vo3 = new HR012002VO();
		
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_RETIREDATE_FR(request.getParameter("S_RETIREDATE_FR"));
		vo.setS_RETIREDATE_TO(request.getParameter("S_RETIREDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(S_KNAME);
		vo.setS_JUMINID(request.getParameter("S_JUMINID"));

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(!(request.getParameter("S_RETIREDATE_FR").equals("") && 
				request.getParameter("S_RETIREDATE_TO").equals("") && 
				request.getParameter("S_BRANCHCODE").equals("") && 
				request.getParameter("S_DEPTCODE").equals("") && 
				request.getParameter("S_KNAME").equals("") && 
				request.getParameter("S_JUMINID").equals(""))){
		
		
			List<HR012002VO> lst = HR012002Biz.selectListHR012002(vo);
			
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				vo1.setINSACODE(lst.get(i).getINSACODE());
				
				List<HR012002VO> lst2 = HR012002Biz.selectListHR012002_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
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
							obj.put("RETIREDATE",lst.get(i).getRETIREDATE());
							obj.put("REMARK",lst.get(i).getREMARK());
							
							vo2.setINSACODE(lst.get(i).getINSACODE());
							vo2.setO_JOINDATE(lst.get(i).getJOINDATE());
							vo2.setO_RETIREDATE(lst.get(i).getRETIREDATE());
							
							List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
							if(lst3.size() > 0){
								
								obj.put("SELLAMT",lst3.get(0).getO_SELLAMT());
								
							}else{
								obj.put("SELLAMT","");
							}
							
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
							obj.put("RETIREDATE","");
							obj.put("REMARK","");
							obj.put("SELLAMT","");
							
						}
						obj.put("O_BRANCHNAME",lst2.get(j).getO_BRANCHNAME());
						obj.put("O_JOINDATE",lst2.get(j).getO_JOINDATE());
						obj.put("O_RETIREDATE",lst2.get(j).getO_RETIREDATE());
						obj.put("O_REMARK",lst2.get(j).getO_REMARK());
	
						vo3.setINSACODE(lst.get(i).getINSACODE());
						vo3.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo3.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						
						List<HR012002VO> lst4 = HR012002Biz.selectListHR012002_3(vo3);
						if(lst4.size() > 0){
							
							obj.put("O_SELLAMT",lst4.get(0).getO_SELLAMT());
							
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
					obj.put("RETIREDATE",lst.get(i).getRETIREDATE());
					obj.put("REMARK",lst.get(i).getREMARK());
					
					vo2.setINSACODE(lst.get(i).getINSACODE());
					vo2.setO_JOINDATE(lst.get(i).getJOINDATE());
					vo2.setO_RETIREDATE(lst.get(i).getRETIREDATE());
					
					List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
					if(lst3.size() > 0){
						
						obj.put("SELLAMT",lst3.get(0).getO_SELLAMT());
						
					}else{
						obj.put("SELLAMT","");
					}
					
					obj.put("O_BRANCHNAME","");
					obj.put("O_JOINDATE","");
					obj.put("O_RETIREDATE","");
					obj.put("O_SELLAMT","");
					obj.put("O_REMARK","");
					
					jCell.add(obj);
				}
				
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
	@RequestMapping("/home/HR012002_exportToExcel.do")
	public ModelAndView HR012002_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();
		
		HR012002VO vo = new HR012002VO();
		HR012002VO vo1 = new HR012002VO();
		HR012002VO vo2 = new HR012002VO();
		HR012002VO vo3 = new HR012002VO();
		HR012002VO vo4 = new HR012002VO();
		
		
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_RETIREDATE_FR(request.getParameter("S_RETIREDATE_FR"));
		vo.setS_RETIREDATE_TO(request.getParameter("S_RETIREDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(S_KNAME);
		vo.setS_JUMINID(request.getParameter("S_JUMINID"));
		
		File down = null;
		final String _SEP = File.separator;
		
		try {
	           
            String fileName = "HR012002_exportToExcel.xlsx";
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
            
            List<HR012002VO> lstAll = new ArrayList<HR012002VO>();
			List<HR012002VO> lst = HR012002Biz.selectListHR012002(vo);
			for (int i = 0; i < lst.size(); i++) {
				vo4 = new HR012002VO();
				
				vo1.setINSACODE(lst.get(i).getINSACODE());
				
				List<HR012002VO> lst2 = HR012002Biz.selectListHR012002_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						vo4 = new HR012002VO();
						if(j == 0){
							
							vo4.setBRANCHNAME(lst.get(i).getBRANCHNAME());
							vo4.setDEPTNAME(lst.get(i).getDEPTNAME());
							vo4.setGRADE(lst.get(i).getGRADE());
							vo4.setDUTY(lst.get(i).getDUTY());
							vo4.setEMPLOYGUBUN(lst.get(i).getEMPLOYGUBUN());
							vo4.setINSACODE(lst.get(i).getINSACODE());
							vo4.setKNAME(lst.get(i).getKNAME());
							vo4.setRECONAME(lst.get(i).getRECONAME());
							vo4.setJOINDATE(lst.get(i).getJOINDATE());
							vo4.setRETIREDATE(lst.get(i).getRETIREDATE());
							vo4.setREMARK(lst.get(i).getREMARK());
							
							vo2.setINSACODE(lst.get(i).getINSACODE());
							vo2.setO_JOINDATE(lst.get(i).getJOINDATE());
							vo2.setO_RETIREDATE(lst.get(i).getRETIREDATE());
							
							List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
							if(lst3.size() > 0){
								
								vo4.setSELLAMT(lst3.get(0).getO_SELLAMT());
								
							}else{
								vo4.setSELLAMT("");
							}
							
						}else{
							vo4.setBRANCHNAME("");
							vo4.setDEPTNAME("");
							vo4.setGRADE("");
							vo4.setDUTY("");
							vo4.setEMPLOYGUBUN("");
							vo4.setINSACODE("");
							vo4.setKNAME("");
							vo4.setRECONAME("");
							vo4.setJOINDATE("");
							vo4.setRETIREDATE("");
							vo4.setREMARK("");
							vo4.setSELLAMT("");

						}
					
						vo3.setO_BRANCHNAME(lst2.get(j).getO_BRANCHNAME());
						vo3.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo3.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						vo3.setO_EMPLOYGUBUN(lst2.get(j).getO_EMPLOYGUBUN());
						
						vo2.setINSACODE(lst.get(i).getINSACODE());
						vo2.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo2.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						
						List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
						if(lst3.size() > 0){
							
							vo4.setO_SELLAMT(lst3.get(0).getO_SELLAMT());
							
						}else{
							vo4.setO_SELLAMT("");
						}
						
						lstAll.add(vo4);
					}
				}else{
					vo4 = new HR012002VO();
					vo4.setBRANCHNAME(lst.get(i).getBRANCHNAME());
					vo4.setDEPTNAME(lst.get(i).getDEPTNAME());
					vo4.setGRADE(lst.get(i).getGRADE());
					vo4.setDUTY(lst.get(i).getDUTY());
					vo4.setEMPLOYGUBUN(lst.get(i).getEMPLOYGUBUN());
					vo4.setINSACODE(lst.get(i).getINSACODE());
					vo4.setKNAME(lst.get(i).getKNAME());
					vo4.setRECONAME(lst.get(i).getRECONAME());
					vo4.setJOINDATE(lst.get(i).getJOINDATE());
					vo4.setRETIREDATE(lst.get(i).getRETIREDATE());
					vo4.setREMARK(lst.get(i).getREMARK());
					
					vo2.setINSACODE(lst.get(i).getINSACODE());
					vo2.setO_JOINDATE(lst.get(i).getJOINDATE());
					vo2.setO_RETIREDATE(lst.get(i).getRETIREDATE());
					
					List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
					if(lst3.size() > 0){
						
						vo4.setSELLAMT(lst3.get(0).getO_SELLAMT());
						
					}else{
						vo4.setSELLAMT("");
					}
					
					vo4.setO_BRANCHNAME("");
					vo4.setO_JOINDATE("");
					vo4.setO_RETIREDATE("");
					vo4.setO_SELLAMT("");
					vo4.setO_REMARK("");
					
					lstAll.add(vo4);
				}
				
			}            
            
            if(lstAll != null) {
            	for (HR012002VO HR012002vo : lstAll) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, HR012002vo);
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
        header.createCell(9).setCellValue("퇴사일");
        header.createCell(10).setCellValue("직전지사실적");
        header.createCell(11).setCellValue("지사");
        header.createCell(12).setCellValue("입사");
        header.createCell(13).setCellValue("퇴사");
        header.createCell(14).setCellValue("실적");
        header.createCell(15).setCellValue("비고");
        header.createCell(16).setCellValue("비고");
        
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
    }


    private void setEachRow(SXSSFRow aRow, HR012002VO HR012002vo) {
    	
        aRow.createCell(0).setCellValue(HR012002vo.getBRANCHNAME());
        aRow.createCell(1).setCellValue(HR012002vo.getDEPTNAME());
        aRow.createCell(2).setCellValue(HR012002vo.getDUTY());
        aRow.createCell(3).setCellValue(HR012002vo.getGRADE());
        aRow.createCell(4).setCellValue(HR012002vo.getEMPLOYGUBUN());
        aRow.createCell(5).setCellValue(HR012002vo.getINSACODE());
        aRow.createCell(6).setCellValue(HR012002vo.getKNAME());
        aRow.createCell(7).setCellValue(HR012002vo.getRECONAME());
        aRow.createCell(8).setCellValue(HR012002vo.getJOINDATE());
        aRow.createCell(9).setCellValue(HR012002vo.getRETIREDATE());
        aRow.createCell(10).setCellValue(HR012002vo.getSELLAMT());
        aRow.createCell(11).setCellValue(HR012002vo.getO_BRANCHNAME());
        aRow.createCell(12).setCellValue(HR012002vo.getO_JOINDATE());
        aRow.createCell(13).setCellValue(HR012002vo.getO_RETIREDATE());
        aRow.createCell(14).setCellValue(HR012002vo.getO_SELLAMT());
        aRow.createCell(15).setCellValue(HR012002vo.getO_REMARK());
        aRow.createCell(16).setCellValue(HR012002vo.getREMARK());
        
    }
	
}
