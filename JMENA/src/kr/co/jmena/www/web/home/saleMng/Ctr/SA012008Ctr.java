package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012008Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012008VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA012008Ctr {
	
	@Resource(name = "SA012008Biz")
	private SA012008Biz SA012008Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012008Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012008.do")
	public ModelAndView SA012008(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012008");
	}

	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012008.do")
	public ModelAndView selectListSA012008(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012008VO vo = new SA012008VO();
		SA012008VO vo1 = new SA012008VO();
		
		//String S_CITYCODE = ("ALL".equals(request.getParameter("S_CITYCODE"))) ? "" : request.getParameter("S_CITYCODE");
		//String S_BOROUGHCODE = ("ALL".equals(request.getParameter("S_BOROUGHCODE"))) ? "" : request.getParameter("S_BOROUGHCODE");
		String S_ADDRESS = (URLDecoder.decode(request.getParameter("S_ADDRESS"),"UTF-8"));
		
		vo.setS_CITYCODE(request.getParameter("S_CITYCODE"));
		vo.setS_BOROUGHCODE(request.getParameter("S_BOROUGHCODE"));
		String S_BUYYEAR = request.getParameter("S_BUYYEAR") + request.getParameter("S_BUYMONTH");  
		
		vo.setS_BUYYEAR(S_BUYYEAR);
		
		vo.setS_ADDRESS(S_ADDRESS);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		List<SA012008VO> lst = SA012008Biz.selectListSA012008(vo);
		
		
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			vo1.setBUYID(lst.get(i).getBUYID());
	
			List<SA012008VO> lst2 = SA012008Biz.selectListSA012008_2(vo1);
			if(lst2.size() > 0){
				for (int j = 0; j < lst2.size(); j++) {
					if(j == 0){
						obj.put("BUYGUBUN",lst.get(i).getBUYGUBUN());
						obj.put("OWNERNAME",lst.get(i).getOWNERNAME());
						obj.put("OWNERJUMINID",lst.get(i).getOWNERJUMINID());
						obj.put("ADDRESS",lst.get(i).getADDRESS());
						obj.put("BUYM2",lst.get(i).getBUYM2());
						obj.put("REGDATE1",lst.get(i).getREGDATE1());
						obj.put("BUYAMT",lst.get(i).getBUYAMT());
						
					}else{
						obj.put("BUYGUBUN","");
						obj.put("OWNERNAME","");
						obj.put("OWNERJUMINID","");
						obj.put("ADDRESS","");
						obj.put("BUYM2","");
						obj.put("REGDATE1","");
						obj.put("BUYAMT","");
						
					}
					obj.put("SELLSEQ",lst2.get(j).getSELLSEQ());
					obj.put("CONNAME",lst2.get(j).getCONNAME());
					obj.put("CONJUMINID",lst2.get(j).getCONJUMINID());
					obj.put("CONM2",lst2.get(j).getCONM2());
					obj.put("REGDATE2",lst2.get(j).getREGDATE2());
					obj.put("SALEAMT",lst2.get(j).getSALEAMT());
					obj.put("REMNM2",lst2.get(j).getREMNM2());
					obj.put("REMNAMT",lst2.get(j).getREMNAMT());
					
					jCell.add(obj);
				}
			}else{
				obj.put("BUYGUBUN",lst.get(i).getBUYGUBUN());
				obj.put("OWNERNAME",lst.get(i).getOWNERNAME());
				obj.put("OWNERJUMINID",lst.get(i).getOWNERJUMINID());
				obj.put("ADDRESS",lst.get(i).getADDRESS());
				obj.put("BUYM2",lst.get(i).getBUYM2());
				obj.put("REGDATE1",lst.get(i).getREGDATE1());
				obj.put("BUYAMT",lst.get(i).getBUYAMT());
				obj.put("SELLSEQ","");
				obj.put("CONNAME","");
				obj.put("CONJUMINID","");
				obj.put("CONM2","");
				obj.put("REGDATE2","");
				obj.put("SALEAMT","");
				obj.put("REMNM2","");
				obj.put("REMNAMT","");
				
				jCell.add(obj);
			}
				
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

}
