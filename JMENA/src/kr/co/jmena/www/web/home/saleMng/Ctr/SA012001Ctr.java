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
	@RequestMapping("/home/selectListSA012001.do")
	public ModelAndView selectListSA012001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SA012001VO vo1 = new SA012001VO();
		SA012001VO vo2 = new SA012001VO();
		SA012001VO vo3 = new SA012001VO();
		SA012001VO vo4 = new SA012001VO();
		
		String S_SALEDATE = request.getParameter("S_SALEDATE");
		String S_SALEDATE_FR = "";
		String S_SALEDATE_TO = "";
		if(!(S_SALEDATE.equals(null) || S_SALEDATE == "" )){
			S_SALEDATE = (S_SALEDATE.replaceAll("/", "")).substring(0, 6);
			
			S_SALEDATE_FR = S_SALEDATE+"01";
			S_SALEDATE_TO = S_SALEDATE+"31";
		}

		
		vo1.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo1.setS_KNAME(request.getParameter("S_KNAME"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_SALEDATE").equals("") && 
				request.getParameter("S_BRANCHCODE").equals("") && 
				request.getParameter("S_KNAME").equals(""))){
		
			List<SA012001VO> lst1 = SA012001Biz.selectListSA012001_1(vo1);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst1.size());
			
			
			for (int i = 0; i < lst1.size(); i++) {
				JSONObject obj = new JSONObject();
	
				
				vo2.setINSACODE(request.getParameter("INSACODE"));
				
				
				vo3.setS_SALEDATE_FR(S_SALEDATE_FR);
				vo3.setS_SALEDATE_TO(S_SALEDATE_TO);
				
				vo3.setINSACODE(request.getParameter("INSACODE"));
				
				List<SA012001VO> lst2 = SA012001Biz.selectListSA012001_2(vo2);
				
	
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
	
						if(j == 0){
							obj.put("BRANCHCODE", lst1.get(i).getBRANCHCODE());
							obj.put("BRANCHNAME", lst1.get(i).getBRANCHNAME());
							obj.put("DEPTCODE", lst1.get(i).getDEPTCODE());
							obj.put("DEPTNAME", lst1.get(i).getDEPTNAME());
							obj.put("DUTY", lst1.get(i).getDUTY());
							obj.put("JOINDATE", lst1.get(i).getJOINDATE());
							obj.put("RETIREDATE", lst1.get(i).getRETIREDATE());
							
							if(!(S_SALEDATE.equals(null) || S_SALEDATE == "" )){
								List<SA012001VO> lst3 = SA012001Biz.selectListSA012001_3(vo3);
								if(lst3.size() > 0){
	
									vo4.setS_SALEDATE_FR(S_SALEDATE_FR);
									vo4.setS_SALEDATE_TO(S_SALEDATE_TO);
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
	
									List<SA012001VO> lst4 = SA012001Biz.selectListSA012001_4(vo3);
									obj.put("AMT1", lst4.get(i).getAMT1());
									obj.put("AMT2", lst4.get(i).getAMT2());
									obj.put("AMT3", lst4.get(i).getAMT3());
									obj.put("AMT4", lst4.get(i).getAMT4());
									obj.put("AMT5", lst4.get(i).getAMT5());
									obj.put("AMT6", lst4.get(i).getAMT6());
									obj.put("TOTAMT", lst4.get(i).getTOTAMT());
									
								}else{
									obj.put("AMT1", "");
									obj.put("AMT2", "");
									obj.put("AMT3", "");
									obj.put("AMT4", "");
									obj.put("AMT5", "");
									obj.put("AMT6", "");
									obj.put("TOTAMT", "");
									
								}
								
							}else{
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
							obj.put("JOINDATE", "");
							obj.put("RETIREDATE", "");
						}
						
						obj.put("O_BRANCHCODE", lst2.get(j).getO_BRANCHCODE());
						obj.put("O_BRANCHNAME", lst2.get(j).getO_BRANCHNAME());
						obj.put("O_JOINDATE", lst2.get(j).getO_JOINDATE());
						obj.put("O_RETIREDATE", lst2.get(j).getO_RETIREDATE());
						obj.put("O_EMPLOYGUBUN", lst2.get(j).getO_EMPLOYGUBUN());
						
					}
					
				}else{
					obj.put("BRANCHCODE", "");
					obj.put("BRANCHNAME", "");
					obj.put("DEPTCODE", "");
					obj.put("DEPTNAME", "");
					obj.put("DUTY", "");
					obj.put("JOINDATE", "");
					obj.put("RETIREDATE", "");
					
				}
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

		
}
