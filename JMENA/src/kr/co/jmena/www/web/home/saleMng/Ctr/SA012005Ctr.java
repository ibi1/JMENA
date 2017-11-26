package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012005Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012005VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA012005Ctr {
	
	@Resource(name = "SA012005Biz")
	private SA012005Biz SA012005Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012005Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012005.do")
	public ModelAndView SA012005(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012005");
	}
	
	/**
	 * @name 매출관리 화면 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012005.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012005VO vo = new SA012005VO();
		SA012005VO vo1 = new SA012005VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_SALERCD = ("ALL".equals(request.getParameter("S_SALERCD"))) ? "" : request.getParameter("S_SALERCD");

		String S_IPGUMPERSON = (URLDecoder.decode(request.getParameter("S_IPGUMPERSON"),"UTF-8"));
		
		vo.setS_IPGUMDATE_FR(request.getParameter("S_IPGUMDATE_FR"));
		vo.setS_IPGUMDATE_TO(request.getParameter("S_IPGUMDATE_TO"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_SALERCD(S_SALERCD);
		vo.setS_IPGUMGUBUN(request.getParameter("S_IPGUMGUBUN"));
		vo.setS_IPGUMPERSON(S_IPGUMPERSON);
		vo.setS_IPGUMAMT(request.getParameter("S_IPGUMAMT"));
		
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(
				request.getParameter("S_IPGUMGUBUN").equals("") && 
				request.getParameter("S_IPGUMPERSON").equals("") && 
				request.getParameter("S_IPGUMAMT").equals(""))){
			
			List<SA012005VO> lst = SA012005Biz.selectListSA012005(vo);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				vo1.setIPGUMID(lst.get(i).getIPGUMID());
				
				List<SA012005VO> lst2 = SA012005Biz.selectListSA012005_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						obj = new JSONObject();
						if(j == 0){
							obj.put("IPGUMDATE",lst.get(i).getIPGUMDATE());
							obj.put("IPGUMID",lst.get(i).getIPGUMID());
							obj.put("IPGUMGUBUN",lst.get(i).getIPGUMGUBUN());
							obj.put("IPGUMPERSON",lst.get(i).getIPGUMPERSON());
							obj.put("IPGUMAMT",lst.get(i).getIPGUMAMT());
							obj.put("SUMSUGUMAMT",lst.get(i).getSUMSUGUMAMT());
							obj.put("JANGUMAMT",lst.get(i).getJANGUMAMT());
							
						}else{
							obj.put("IPGUMDATE","");
							obj.put("IPGUMID","");
							obj.put("IPGUMGUBUN","");
							obj.put("IPGUMPERSON","");
							obj.put("IPGUMAMT","");
							obj.put("SUMSUGUMAMT","");
							obj.put("JANGUMAMT","");
							
						}
						obj.put("SEQ",lst2.get(j).getSEQ());
						obj.put("SALEDATE",lst2.get(j).getSALEDATE());
						obj.put("SALEID",lst2.get(j).getSALEID());
						obj.put("CONNAME",lst2.get(j).getCONNAME());
						obj.put("CONM2",lst2.get(j).getCONM2());
						obj.put("CONPY",lst2.get(j).getCONPY());
						obj.put("DEPOSITGUBUN",lst2.get(j).getDEPOSITGUBUN());
						obj.put("SUGUMAMT",lst2.get(j).getSUGUMAMT());
						obj.put("KNAME",lst2.get(j).getKNAME());
						obj.put("ADDRESS",lst2.get(j).getADDRESS());

						jCell.add(obj);
					}
				}else{
					obj = new JSONObject();
					obj.put("IPGUMDATE",lst.get(i).getIPGUMDATE());
					obj.put("IPGUMID",lst.get(i).getIPGUMID());
					obj.put("IPGUMGUBUN",lst.get(i).getIPGUMGUBUN());
					obj.put("IPGUMPERSON",lst.get(i).getIPGUMPERSON());
					obj.put("IPGUMAMT",lst.get(i).getIPGUMAMT());
					obj.put("SUMSUGUMAMT",lst.get(i).getSUMSUGUMAMT());
					obj.put("JANGUMAMT",lst.get(i).getJANGUMAMT());
					obj.put("SEQ","");
					obj.put("SALEDATE","");
					obj.put("SALEID","");
					obj.put("CONNAME","");
					obj.put("CONM2","");
					obj.put("CONPY","");
					obj.put("DEPOSITGUBUN","");
					obj.put("SUGUMAMT","");
					obj.put("KNAME","");
					obj.put("ADDRESS","");

					jCell.add(obj);
					
				}
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
}
