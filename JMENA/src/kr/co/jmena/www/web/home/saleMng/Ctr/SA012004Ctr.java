package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012004Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012004VO;

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
public class SA012004Ctr {
	
	@Resource(name = "SA012004Biz")
	private SA012004Biz SA012004Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012004Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012004.do")
	public ModelAndView SA012004(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012004");
	}

	/**
	 * @name 매출관리 화면 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012004.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012004VO vo = new SA012004VO();
		
		vo.setS_IPGUMDATE_FR(request.getParameter("S_IPGUMDATE_FR"));
		vo.setS_IPGUMDATE_TO(request.getParameter("S_IPGUMDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_SALERCD(request.getParameter("S_SALERCD"));
		vo.setS_IPGUMGUBUN(request.getParameter("S_IPGUMGUBUN"));
		vo.setS_IPGUMPERSON(request.getParameter("S_IPGUMPERSON"));
		vo.setS_IPGUMAMT(request.getParameter("S_IPGUMAMT"));

		List<SA012004VO> lst = SA012004Biz.selectListSA012004(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());

			jCell.add(obj);
		}
		
		json.put("records", lst.size());
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

	
	
}
