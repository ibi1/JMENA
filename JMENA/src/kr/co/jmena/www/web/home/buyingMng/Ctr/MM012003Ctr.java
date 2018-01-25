package kr.co.jmena.www.web.home.buyingMng.Ctr;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.common.util.ExcelUtil;
import kr.co.jmena.www.web.home.buyingMng.Biz.MM012003Biz;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012003VO;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MM012003Ctr {

	@Resource(name = "MM012003Biz")
	private MM012003Biz MM012003Biz;
	
	/**
	 * @name 계약현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012003.do")
	public ModelAndView MM012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("home/buyingMng/MM012003");
	}
	
	/**
	 * @name 계약현황 : 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012003_s1.do")
	public ModelAndView selectListBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012003VO vo = new MM012003VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");
		String S_BUYGUBUN = request.getParameter("S_BUYGUBUN");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_KNAME = request.getParameter("S_KNAME");
		String S_ADDRESS = request.getParameter("S_ADDRESS");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BUYGUBUN(S_BUYGUBUN);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_ADDRESS(S_ADDRESS);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<MM012003VO> lst = MM012003Biz.selectListBuyMst(vo);		
		
		for(int i = 0; i < lst.size(); i++) {
			
			String S_BUYID = lst.get(i).getBUYID();
			float BUYM2 = Float.parseFloat(lst.get(i).getBUYM2());
			
			vo.setS_BUYID(S_BUYID);
			List<MM012003VO> s_lst = MM012003Biz.selectListSaleMst(vo);
			
			if(s_lst.size() > 0) {
				
				float REMM2 = BUYM2;
				
				for(int j = 0; j < s_lst.size(); j++) {
					JSONObject obj = new JSONObject();
					
					if(j == 0) {
						obj.put("BUYID", lst.get(i).getBUYID());
						obj.put("BUYDATE", lst.get(i).getBUYDATE());
						obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
						obj.put("ADDRESS", lst.get(i).getADDRESS());
						obj.put("BUYM2", lst.get(i).getBUYM2());
						obj.put("BUYAMT", lst.get(i).getBUYAMT());
					} else {
						obj.put("BUYID", null);
						obj.put("BUYDATE", null);
						obj.put("OWNERNAME", null);
						obj.put("ADDRESS", null);
						obj.put("BUYM2", null);
						obj.put("BUYAMT", null);
					}
					
					REMM2 = REMM2 - Float.parseFloat(s_lst.get(j).getCONM2());
					
					obj.put("SALEID", s_lst.get(j).getSALEID());
					obj.put("SALEDATE", s_lst.get(j).getSALEDATE());
					obj.put("CONNAME", s_lst.get(j).getCONNAME());
					obj.put("CONM2", s_lst.get(j).getCONM2());
					obj.put("REMM2", REMM2);
					obj.put("DCRATE", s_lst.get(j).getDCRATE());
					obj.put("SELLAMT", s_lst.get(j).getSELLAMT());
					obj.put("DEPOSITDATE", s_lst.get(j).getDEPOSITDATE());
					obj.put("KNAME", s_lst.get(j).getKNAME());
					obj.put("NAME_BRANCHCODE", s_lst.get(j).getNAME_BRANCHCODE());
					
					jCell.add(obj);
				}
			} else {
				JSONObject obj = new JSONObject();
				
				obj.put("BUYID", lst.get(i).getBUYID());
				obj.put("BUYDATE", lst.get(i).getBUYDATE());
				obj.put("OWNERNAME", lst.get(i).getOWNERNAME());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("BUYM2", lst.get(i).getBUYM2());
				obj.put("BUYAMT", lst.get(i).getBUYAMT());
				obj.put("SALEID", null);
				obj.put("SALEDATE", null);
				obj.put("CONNAME", null);
				obj.put("CONM2", null);
				obj.put("REMM2", null);
				obj.put("DCRATE", null);
				obj.put("SELLAMT", null);
				obj.put("DEPOSITDATE", null);
				obj.put("KNAME", null);
				obj.put("NAME_BRANCHCODE", null);
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * @name 계약현황 : 엑셀다운
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/MM012003_e1.do")
	public ModelAndView exportToExcelBuyMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MM012003VO vo = new MM012003VO();
		
		String S_BUYDATE_FR = request.getParameter("S_BUYDATE_FR");
		String S_BUYDATE_TO = request.getParameter("S_BUYDATE_TO");
		String S_BUYGUBUN = request.getParameter("S_BUYGUBUN");
		String S_BRANCHCODE = request.getParameter("S_BRANCHCODE");
		String S_KNAME = request.getParameter("S_KNAME");
		String S_ADDRESS = request.getParameter("S_ADDRESS");
		
		vo.setS_BUYDATE_FR(S_BUYDATE_FR);
		vo.setS_BUYDATE_TO(S_BUYDATE_TO);
		vo.setS_BUYGUBUN(S_BUYGUBUN);
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_KNAME(S_KNAME);
		vo.setS_ADDRESS(S_ADDRESS);
		
		List<MM012003VO> lst = MM012003Biz.selectListBuyMst(vo);
		
		File f = null;
		ExcelUtil ex = ExcelUtil.getExcelUtil();
		SXSSFWorkbook wb = new SXSSFWorkbook();
		
		String[] heads = new String[]{"매입일", "매도자", "지번", "면적", "금액", "계약일", "지사", "담당", "계약자", "면적", "잔여면적", "DC율", "실판매가", "잔금여부"};
		int cellCnt = (heads.length - 1);
		
		try {
			// 엑셀 시트 생성
			ex.MakeExcelTitle(wb, "계약현황", cellCnt);
			ex.MakeExcelHeader(wb, heads);
			
			for(int i = 0; i < lst.size(); i++) {
				
				String S_BUYID = lst.get(i).getBUYID();
				float BUYM2 = Float.parseFloat(lst.get(i).getBUYM2());
				
				vo.setS_BUYID(S_BUYID);
				List<MM012003VO> s_lst = MM012003Biz.selectListSaleMst(vo);
				
				if(s_lst.size() > 0) {
					
					float REMM2 = BUYM2;
					
					for(int j = 0; j < s_lst.size(); j++) {
						List<Object> data = new ArrayList<Object>();
						List<Object> dataType = new ArrayList<Object>();
						
						if(j == 0) {
							data.add(lst.get(i).getBUYDATE());
							dataType.add("string");
							data.add(lst.get(i).getOWNERNAME());
							dataType.add("string");
							data.add(lst.get(i).getADDRESS());
							dataType.add("string");
							data.add(lst.get(i).getBUYM2());
							dataType.add("decimal");
							data.add(lst.get(i).getBUYAMT());
							dataType.add("number");
						} else {
							data.add(null);
							dataType.add("string");
							data.add(null);
							dataType.add("string");
							data.add(null);
							dataType.add("string");
							data.add(null);
							dataType.add("string");
							data.add(null);
							dataType.add("string");
						}
						
						REMM2 = REMM2 - Float.parseFloat(s_lst.get(j).getCONM2());
						
						data.add(s_lst.get(j).getSALEDATE());
						dataType.add("string");
						data.add(s_lst.get(j).getNAME_BRANCHCODE());
						dataType.add("string");
						data.add(s_lst.get(j).getKNAME());
						dataType.add("string");
						data.add(s_lst.get(j).getCONNAME());
						dataType.add("string");
						data.add(s_lst.get(j).getCONM2());
						dataType.add("decimal");
						data.add(REMM2);
						dataType.add("decimal");
						data.add(s_lst.get(j).getDCRATE());
						dataType.add("number");
						data.add(s_lst.get(j).getSELLAMT());
						dataType.add("number");
						data.add(s_lst.get(j).getDEPOSITDATE());
						dataType.add("string");
						
						// 엑셀 데이터 생성 
						ex.MakeExcelBody(wb, data, dataType);
					}
				} else {
					List<Object> data = new ArrayList<Object>();
					List<Object> dataType = new ArrayList<Object>();
					
					data.add(lst.get(i).getBUYDATE());
					dataType.add("string");
					data.add(lst.get(i).getOWNERNAME());
					dataType.add("string");
					data.add(lst.get(i).getADDRESS());
					dataType.add("string");
					data.add(lst.get(i).getBUYM2());
					dataType.add("decimal");
					data.add(lst.get(i).getBUYAMT());
					dataType.add("number");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					data.add(null);
					dataType.add("string");
					
					// 엑셀 데이터 생성 
					ex.MakeExcelBody(wb, data, dataType);
				}
			}
			
			ServletContext context = request.getServletContext();
			String filePath = context.getRealPath("/") +"WEB-INF"+ File.separator +"ExcelDownLoad"+ File.separator;
			String fileName = "MM012003_exportToExcel";
			
			// 엑셀 파일 생성
			f = ex.MakeExcelFile(wb, filePath, fileName);
			
		} catch (Exception e) {
			throw e;
		}
		
		// 엑셀 다운로드
		return new ModelAndView("downloadView", "downloadFile", f);
	}	
}
