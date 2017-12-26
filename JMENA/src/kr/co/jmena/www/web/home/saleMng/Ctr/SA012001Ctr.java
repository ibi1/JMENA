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

import kr.co.jmena.www.web.home.buyingMng.Vo.MM012001VO;
import kr.co.jmena.www.web.home.saleMng.Biz.SA012001Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012002VO;

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
import org.apache.poi.ss.usermodel.IndexedColors;
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
	@RequestMapping("/home/selectListSA012001.do")
	public ModelAndView selectListSA012001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SA012001VO vo1 = new SA012001VO();
		SA012001VO vo2 = new SA012001VO();
		SA012001VO vo3 = new SA012001VO();
		SA012001VO vo4 = new SA012001VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPOSITDATE = request.getParameter("S_DEPOSITDATE");
		String S_DEPOSITDATE_FR = "";
		String S_DEPOSITDATE_TO = "";

		if(!(S_DEPOSITDATE.equals(null) || S_DEPOSITDATE == "" )) {
			S_DEPOSITDATE_FR = S_DEPOSITDATE + "-01";
			S_DEPOSITDATE_TO = S_DEPOSITDATE + "-31";
		}

		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo1.setS_BRANCHCODE(S_BRANCHCODE);		
		vo1.setS_KNAME(S_KNAME);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_DEPOSITDATE").equals(""))){
		
			List<SA012001VO> lst1 = SA012001Biz.selectListSA012001_1(vo1);
			
			for (int i = 0; i < lst1.size(); i++) {
				JSONObject obj = new JSONObject();	
				
				vo2.setINSACODE(lst1.get(i).getINSACODE());
				
				vo3.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
				vo3.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);				
				vo3.setINSACODE(lst1.get(i).getINSACODE());
				
				vo4.setINSACODE(lst1.get(i).getINSACODE());
				
				List<SA012001VO> lst2 = SA012001Biz.selectListSA012001_2(vo2);
	
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
	
						if(j == 0){
							obj.put("BRANCHCODE", lst1.get(i).getBRANCHCODE());
							obj.put("BRANCHNAME", lst1.get(i).getBRANCHNAME());
							obj.put("DEPTCODE", lst1.get(i).getDEPTCODE());
							obj.put("DEPTNAME", lst1.get(i).getDEPTNAME());
							obj.put("DUTY", lst1.get(i).getDUTY());
							obj.put("KNAME", lst1.get(i).getKNAME());
							obj.put("JOINDATE", lst1.get(i).getJOINDATE());
							obj.put("RETIREDATE", lst1.get(i).getRETIREDATE());
							
							if(!(S_DEPOSITDATE.equals(null) || S_DEPOSITDATE == "" )){
								List<SA012001VO> lst3 = SA012001Biz.selectListSA012001_3(vo3);
								if(lst3.size() > 0){
	
									vo4.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
									vo4.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
									vo4.setM1_FR(lst3.get(0).getM1_FR());
									vo4.setM1_TO(lst3.get(0).getM1_TO());
									vo4.setM2_FR(lst3.get(0).getM2_FR());
									vo4.setM2_TO(lst3.get(0).getM2_TO());
									vo4.setM3_FR(lst3.get(0).getM3_FR());
									vo4.setM3_TO(lst3.get(0).getM3_TO());
									vo4.setM4_FR(lst3.get(0).getM4_FR());
									vo4.setM4_TO(lst3.get(0).getM4_TO());
									vo4.setM5_FR(lst3.get(0).getM5_FR());
									vo4.setM5_TO(lst3.get(0).getM5_TO());
									vo4.setM6_FR(lst3.get(0).getM6_FR());
									vo4.setM6_TO(lst3.get(0).getM6_TO());
	
									List<SA012001VO> lst4 = SA012001Biz.selectListSA012001_4(vo4);
									if(lst4.size() > 0){
										obj.put("AMT0", lst4.get(0).getAMT0());
										obj.put("AMT1", lst4.get(0).getAMT1());
										obj.put("AMT2", lst4.get(0).getAMT2());
										obj.put("AMT3", lst4.get(0).getAMT3());
										obj.put("AMT4", lst4.get(0).getAMT4());
										obj.put("AMT5", lst4.get(0).getAMT5());
										obj.put("AMT6", lst4.get(0).getAMT6());
										obj.put("TOTAMT", lst4.get(0).getTOTAMT());
									}else{
										obj.put("AMT0", "");
										obj.put("AMT1", "");
										obj.put("AMT2", "");
										obj.put("AMT3", "");
										obj.put("AMT4", "");
										obj.put("AMT5", "");
										obj.put("AMT6", "");
										obj.put("TOTAMT", "");
									}
									
								}else{
									obj.put("AMT0", "");
									obj.put("AMT1", "");
									obj.put("AMT2", "");
									obj.put("AMT3", "");
									obj.put("AMT4", "");
									obj.put("AMT5", "");
									obj.put("AMT6", "");
									obj.put("TOTAMT", "");									
								}
								
							}else{
								obj.put("AMT0", "");
								obj.put("AMT1", "");
								obj.put("AMT2", "");
								obj.put("AMT3", "");
								obj.put("AMT4", "");
								obj.put("AMT5", "");
								obj.put("AMT6", "");
								obj.put("TOTAMT", "");
							}
							
						}else{
							obj.put("BRANCHCODE", "");
							obj.put("BRANCHNAME", "");
							obj.put("DEPTCODE", "");
							obj.put("DEPTNAME", "");
							obj.put("DUTY", "");
							obj.put("KNAME", "");
							obj.put("JOINDATE", "");
							obj.put("RETIREDATE", "");
						}

						obj.put("O_BRANCHCODE", lst2.get(j).getO_BRANCHCODE());
						obj.put("O_BRANCHNAME", lst2.get(j).getO_BRANCHNAME());
						obj.put("O_JOINDATE", lst2.get(j).getO_JOINDATE());
						obj.put("O_RETIREDATE", lst2.get(j).getO_RETIREDATE());
						obj.put("O_EMPLOYGUBUN", lst2.get(j).getO_EMPLOYGUBUN());
						jCell.add(obj);						
					}
					
				}else{

					obj.put("BRANCHCODE", lst1.get(i).getBRANCHCODE());
					obj.put("BRANCHNAME", lst1.get(i).getBRANCHNAME());
					obj.put("DEPTCODE", lst1.get(i).getDEPTCODE());
					obj.put("DEPTNAME", lst1.get(i).getDEPTNAME());
					obj.put("DUTY", lst1.get(i).getDUTY());
					obj.put("KNAME", lst1.get(i).getKNAME());
					obj.put("JOINDATE", lst1.get(i).getJOINDATE());
					obj.put("RETIREDATE", lst1.get(i).getRETIREDATE());
					obj.put("O_BRANCHCODE", "");
					obj.put("O_BRANCHNAME", "");
					obj.put("O_JOINDATE", "");
					obj.put("O_RETIREDATE", "");
					obj.put("O_EMPLOYGUBUN", "");

					if(!(S_DEPOSITDATE.equals(null) || S_DEPOSITDATE == "" )){
						List<SA012001VO> lst3 = SA012001Biz.selectListSA012001_3(vo3);
						if(lst3.size() > 0){

							vo4.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
							vo4.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
							vo4.setM1_FR(lst3.get(0).getM1_FR());
							vo4.setM1_TO(lst3.get(0).getM1_TO());
							vo4.setM2_FR(lst3.get(0).getM2_FR());
							vo4.setM2_TO(lst3.get(0).getM2_TO());
							vo4.setM3_FR(lst3.get(0).getM3_FR());
							vo4.setM3_TO(lst3.get(0).getM3_TO());
							vo4.setM4_FR(lst3.get(0).getM4_FR());
							vo4.setM4_TO(lst3.get(0).getM4_TO());
							vo4.setM5_FR(lst3.get(0).getM5_FR());
							vo4.setM5_TO(lst3.get(0).getM5_TO());
							vo4.setM6_FR(lst3.get(0).getM6_FR());
							vo4.setM6_TO(lst3.get(0).getM6_TO());

							List<SA012001VO> lst4 = SA012001Biz.selectListSA012001_4(vo4);
							if(lst4.size() > 0){
								obj.put("AMT0", lst4.get(0).getAMT0());
								obj.put("AMT1", lst4.get(0).getAMT1());
								obj.put("AMT2", lst4.get(0).getAMT2());
								obj.put("AMT3", lst4.get(0).getAMT3());
								obj.put("AMT4", lst4.get(0).getAMT4());
								obj.put("AMT5", lst4.get(0).getAMT5());
								obj.put("AMT6", lst4.get(0).getAMT6());
								obj.put("TOTAMT", lst4.get(0).getTOTAMT());
							}else{
								obj.put("AMT0", "");
								obj.put("AMT1", "");
								obj.put("AMT2", "");
								obj.put("AMT3", "");
								obj.put("AMT4", "");
								obj.put("AMT5", "");
								obj.put("AMT6", "");
								obj.put("TOTAMT", "");
							}
							
						}else{
							obj.put("AMT0", "");
							obj.put("AMT1", "");
							obj.put("AMT2", "");
							obj.put("AMT3", "");
							obj.put("AMT4", "");
							obj.put("AMT5", "");
							obj.put("AMT6", "");
							obj.put("TOTAMT", "");
							
						}
						
					}else{
						obj.put("AMT0", "");
						obj.put("AMT1", "");
						obj.put("AMT2", "");
						obj.put("AMT3", "");
						obj.put("AMT4", "");
						obj.put("AMT5", "");
						obj.put("AMT6", "");
						obj.put("TOTAMT", "");
					}					
				}
				
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
	@RequestMapping("/home/SA012001_exportToExcel.do")
	public ModelAndView SA012001_exportToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
        JSONObject obj = new JSONObject();
		
		SA012001VO vo1 = new SA012001VO();
		SA012001VO vo2 = new SA012001VO();
		SA012001VO vo3 = new SA012001VO();
		SA012001VO vo4 = new SA012001VO();
		SA012001VO vo5 = new SA012001VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		
		String S_DEPOSITDATE = request.getParameter("S_DEPOSITDATE");
		String S_DEPOSITDATE_FR = "";
		String S_DEPOSITDATE_TO = "";
		
		if(!(S_DEPOSITDATE.equals(null) || S_DEPOSITDATE == "" )) {
			S_DEPOSITDATE_FR = S_DEPOSITDATE + "-01";
			S_DEPOSITDATE_TO = S_DEPOSITDATE + "-31";
		}

		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		vo1.setS_BRANCHCODE(S_BRANCHCODE);
		vo1.setS_KNAME(S_KNAME);
		
		File down = null;
		final String _SEP = File.separator;
		
		try {
	           
            String fileName = "SA012001_exportToExcel.xlsx";
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
            
            List<SA012001VO> lstAll = new ArrayList<SA012001VO>();
			List<SA012001VO> lst1 = SA012001Biz.selectListSA012001_1(vo1);
			
			for (int i = 0; i < lst1.size(); i++) {
				vo5 = new SA012001VO();
				
				vo2.setINSACODE(lst1.get(i).getINSACODE());
				
				vo3.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
				vo3.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
				
				vo3.setINSACODE(lst1.get(i).getINSACODE());
				vo4.setINSACODE(lst1.get(i).getINSACODE());
				
				List<SA012001VO> lst2 = SA012001Biz.selectListSA012001_2(vo2);
	
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						vo5 = new SA012001VO();
						if(j == 0){
							vo5.setBRANCHCODE(lst1.get(i).getBRANCHCODE());
							vo5.setBRANCHNAME(lst1.get(i).getBRANCHNAME());
							vo5.setDEPTCODE(lst1.get(i).getDEPTCODE());
							vo5.setDEPTNAME(lst1.get(i).getDEPTNAME());
							vo5.setDUTY(lst1.get(i).getDUTY());
							vo5.setKNAME(lst1.get(i).getKNAME());
							vo5.setJOINDATE(lst1.get(i).getJOINDATE());
							vo5.setRETIREDATE(lst1.get(i).getRETIREDATE());
							
							if(!(S_DEPOSITDATE.equals(null) || S_DEPOSITDATE == "" )){
								List<SA012001VO> lst3 = SA012001Biz.selectListSA012001_3(vo3);
								if(lst3.size() > 0){
	
									vo4.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
									vo4.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
									vo4.setM1_FR(lst3.get(0).getM1_FR());
									vo4.setM1_TO(lst3.get(0).getM1_TO());
									vo4.setM2_FR(lst3.get(0).getM2_FR());
									vo4.setM2_TO(lst3.get(0).getM2_TO());
									vo4.setM3_FR(lst3.get(0).getM3_FR());
									vo4.setM3_TO(lst3.get(0).getM3_TO());
									vo4.setM4_FR(lst3.get(0).getM4_FR());
									vo4.setM4_TO(lst3.get(0).getM4_TO());
									vo4.setM5_FR(lst3.get(0).getM5_FR());
									vo4.setM5_TO(lst3.get(0).getM5_TO());
									vo4.setM6_FR(lst3.get(0).getM6_FR());
									vo4.setM6_TO(lst3.get(0).getM6_TO());
	
									List<SA012001VO> lst4 = SA012001Biz.selectListSA012001_4(vo4);
									if(lst4.size() > 0){
										vo5.setAMT0(lst4.get(0).getAMT0());
										vo5.setAMT1(lst4.get(0).getAMT1());
										vo5.setAMT2(lst4.get(0).getAMT2());
										vo5.setAMT3(lst4.get(0).getAMT3());
										vo5.setAMT4(lst4.get(0).getAMT4());
										vo5.setAMT5(lst4.get(0).getAMT5());
										vo5.setAMT6(lst4.get(0).getAMT6());
										vo5.setTOTAMT(lst4.get(0).getTOTAMT());
									}else{
										vo5.setAMT0("");
										vo5.setAMT1("");
										vo5.setAMT2("");
										vo5.setAMT3("");
										vo5.setAMT4("");
										vo5.setAMT5("");
										vo5.setAMT6("");
										vo5.setTOTAMT("");
									}
									
								}else{
									vo5.setAMT0("");
									vo5.setAMT1("");
									vo5.setAMT2("");
									vo5.setAMT3("");
									vo5.setAMT4("");
									vo5.setAMT5("");
									vo5.setAMT6("");
									vo5.setTOTAMT("");
									
								}
								
							}else{
								vo5.setAMT0("");
								vo5.setAMT1("");
								vo5.setAMT2("");
								vo5.setAMT3("");
								vo5.setAMT4("");
								vo5.setAMT5("");
								vo5.setAMT6("");
								vo5.setTOTAMT("");
							}
							
						}else{
							vo5.setBRANCHCODE("");
							vo5.setBRANCHNAME("");
							vo5.setDEPTCODE("");
							vo5.setDEPTNAME("");
							vo5.setDUTY("");
							vo5.setKNAME("");
							vo5.setJOINDATE("");
							vo5.setRETIREDATE("");
						}

						vo5.setO_BRANCHCODE(lst2.get(j).getO_BRANCHCODE());
						vo5.setO_BRANCHNAME(lst2.get(j).getO_BRANCHNAME());
						vo5.setO_JOINDATE(lst2.get(j).getO_JOINDATE());
						vo5.setO_RETIREDATE(lst2.get(j).getO_RETIREDATE());
						vo5.setO_EMPLOYGUBUN(lst2.get(j).getO_EMPLOYGUBUN());
						lstAll.add(vo5);
						
					}
					
				}else{

					vo5.setBRANCHCODE(lst1.get(i).getBRANCHCODE());
					vo5.setBRANCHNAME(lst1.get(i).getBRANCHNAME());
					vo5.setDEPTCODE(lst1.get(i).getDEPTCODE());
					vo5.setDEPTNAME(lst1.get(i).getDEPTNAME());
					vo5.setDUTY(lst1.get(i).getDUTY());
					vo5.setKNAME(lst1.get(i).getKNAME());
					vo5.setJOINDATE(lst1.get(i).getJOINDATE());
					vo5.setRETIREDATE(lst1.get(i).getRETIREDATE());
					vo5.setO_BRANCHCODE("");
					vo5.setO_BRANCHNAME("");
					vo5.setO_JOINDATE("");
					vo5.setO_RETIREDATE("");
					vo5.setO_EMPLOYGUBUN("");

					if(!(S_DEPOSITDATE.equals(null) || S_DEPOSITDATE == "" )){
						List<SA012001VO> lst3 = SA012001Biz.selectListSA012001_3(vo3);
						if(lst3.size() > 0){

							vo4.setS_DEPOSITDATE_FR(S_DEPOSITDATE_FR);
							vo4.setS_DEPOSITDATE_TO(S_DEPOSITDATE_TO);
							vo4.setM1_FR(lst3.get(0).getM1_FR());
							vo4.setM1_TO(lst3.get(0).getM1_TO());
							vo4.setM2_FR(lst3.get(0).getM2_FR());
							vo4.setM2_TO(lst3.get(0).getM2_TO());
							vo4.setM3_FR(lst3.get(0).getM3_FR());
							vo4.setM3_TO(lst3.get(0).getM3_TO());
							vo4.setM4_FR(lst3.get(0).getM4_FR());
							vo4.setM4_TO(lst3.get(0).getM4_TO());
							vo4.setM5_FR(lst3.get(0).getM5_FR());
							vo4.setM5_TO(lst3.get(0).getM5_TO());
							vo4.setM6_FR(lst3.get(0).getM6_FR());
							vo4.setM6_TO(lst3.get(0).getM6_TO());

							List<SA012001VO> lst4 = SA012001Biz.selectListSA012001_4(vo4);
							if(lst4.size() > 0){
								vo5.setAMT0(lst4.get(0).getAMT0());
								vo5.setAMT1(lst4.get(0).getAMT1());
								vo5.setAMT2(lst4.get(0).getAMT2());
								vo5.setAMT3(lst4.get(0).getAMT3());
								vo5.setAMT4(lst4.get(0).getAMT4());
								vo5.setAMT5(lst4.get(0).getAMT5());
								vo5.setAMT6(lst4.get(0).getAMT6());
								vo5.setTOTAMT(lst4.get(0).getTOTAMT());
							}else{
								vo5.setAMT0("");
								vo5.setAMT1("");
								vo5.setAMT2("");
								vo5.setAMT3("");
								vo5.setAMT4("");
								vo5.setAMT5("");
								vo5.setAMT6("");
								vo5.setTOTAMT("");
							}
							
						}else{
							vo5.setAMT0("");
							vo5.setAMT1("");
							vo5.setAMT2("");
							vo5.setAMT3("");
							vo5.setAMT4("");
							vo5.setAMT5("");
							vo5.setAMT6("");
							vo5.setTOTAMT("");
							
						}
						
					}else{
						vo5.setAMT0("");
						vo5.setAMT1("");
						vo5.setAMT2("");
						vo5.setAMT3("");
						vo5.setAMT4("");
						vo5.setAMT5("");
						vo5.setAMT6("");
						vo5.setTOTAMT("");
					}					
				}
				
				lstAll.add(vo5);
				
			}
			
            if(lstAll != null) {
            	for (SA012001VO SA012001vo : lstAll) {
            		SXSSFRow aRow = (SXSSFRow) sheet.createRow(rowCount++);
            		setEachRow(aRow, SA012001vo);
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
        header.createCell(2).setCellValue("직급");
        header.createCell(3).setCellValue("성명");
        header.createCell(4).setCellValue("입사일");
        header.createCell(5).setCellValue("퇴사일");
        header.createCell(6).setCellValue("전근무지");
        header.createCell(7).setCellValue("입사");
        header.createCell(8).setCellValue("퇴사");
        header.createCell(9).setCellValue("고용구분");
        header.createCell(10).setCellValue("6개월 전 실적");
        header.createCell(11).setCellValue("5개월 전 실적");
        header.createCell(12).setCellValue("4개월 전 실적");
        header.createCell(13).setCellValue("3개월 전 실적");
        header.createCell(14).setCellValue("2개월 전 실적");
        header.createCell(15).setCellValue("1개월 전 실적");
        header.createCell(16).setCellValue("당월 실적");
        header.createCell(17).setCellValue("합계");
        
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
        
    }


    private void setEachRow(SXSSFRow aRow, SA012001VO sa012001vo) {

        aRow.createCell(0).setCellValue(sa012001vo.getBRANCHNAME());
        aRow.createCell(1).setCellValue(sa012001vo.getDEPTNAME());
        aRow.createCell(2).setCellValue(sa012001vo.getDUTY());
        aRow.createCell(3).setCellValue(sa012001vo.getKNAME());
        aRow.createCell(4).setCellValue(sa012001vo.getJOINDATE());
        aRow.createCell(5).setCellValue(sa012001vo.getRETIREDATE());
        aRow.createCell(6).setCellValue(sa012001vo.getO_BRANCHNAME());
        aRow.createCell(7).setCellValue(sa012001vo.getO_JOINDATE());
        aRow.createCell(8).setCellValue(sa012001vo.getO_RETIREDATE());
        aRow.createCell(9).setCellValue(sa012001vo.getO_EMPLOYGUBUN());
        aRow.createCell(10).setCellValue(sa012001vo.getAMT6());
        aRow.createCell(11).setCellValue(sa012001vo.getAMT5());
        aRow.createCell(12).setCellValue(sa012001vo.getAMT4());
        aRow.createCell(13).setCellValue(sa012001vo.getAMT3());
        aRow.createCell(14).setCellValue(sa012001vo.getAMT2());
        aRow.createCell(15).setCellValue(sa012001vo.getAMT1());
        aRow.createCell(16).setCellValue(sa012001vo.getAMT0());
        aRow.createCell(17).setCellValue(sa012001vo.getTOTAMT());
        
    }
	
	
	
	
}
