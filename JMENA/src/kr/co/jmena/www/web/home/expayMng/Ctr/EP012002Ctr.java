package kr.co.jmena.www.web.home.expayMng.Ctr;

import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.expayMng.Biz.EP012002Biz;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EP012002Ctr {
	
	@Resource(name = "EP012002Biz")
	private EP012002Biz EP012002Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public EP012002Ctr() {}
	
	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/EP012002.do")
	public ModelAndView EP012002(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/expayMng/EP012002");
	}

	/**
	 * @name 수당관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListEP012002.do")
	public ModelAndView selectListEP012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EP012002VO vo = new EP012002VO();
		
		String S_BRANCHCODE = ("ALL".equals(request.getParameter("S_BRANCHCODE"))) ? "" : request.getParameter("S_BRANCHCODE");
		String S_DEPTCODE = ("ALL".equals(request.getParameter("S_DEPTCODE"))) ? "" : request.getParameter("S_DEPTCODE");
		String S_KNAME = (URLDecoder.decode(request.getParameter("S_KNAME"),"UTF-8"));
		
		vo.setS_PAYDATE(request.getParameter("S_PAYDATE"));
		vo.setS_BRANCHCODE(S_BRANCHCODE);
		vo.setS_KNAME(S_KNAME);

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		List<EP012002VO> lst = EP012002Biz.selectListSudangMst(vo);
		
		for (int i = 0; i < lst.size(); i++) {
			
			String P_SALEID = lst.get(i).getSALEID();
			String P_PAYSEQ = lst.get(i).getPAYSEQ();
			
			vo.setP_SALEID(P_SALEID);
			vo.setP_PAYSEQ(P_PAYSEQ);
			
			List<EP012002VO> s_lst = EP012002Biz.selectListSudangPayerTb(vo);
			
			if(s_lst.size() > 0) {
				
				for(int j = 0; j < s_lst.size(); j++) {
					JSONObject obj = new JSONObject();
					
					if(j == 0) {
						obj.put("SALEID", lst.get(i).getSALEID());
						obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
						obj.put("PAYDATE", lst.get(i).getPAYDATE());
						obj.put("PAYAMT", lst.get(i).getPAYAMT());
						obj.put("TAX", lst.get(i).getTAX());
						obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
						obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
						obj.put("CONNAME", lst.get(i).getCONNAME());
						obj.put("CONPY", lst.get(i).getCONPY());
						obj.put("ADDRESS", lst.get(i).getADDRESS());
						obj.put("KNAME", lst.get(i).getKNAME());
						obj.put("JUMINID", lst.get(i).getJUMINID());
						obj.put("NAME_BRANCHCODE", lst.get(i).getNAME_BRANCHCODE());
						obj.put("NAME_DEPTCODE", lst.get(i).getNAME_DEPTCODE());
					} else {
						obj.put("SALEID", null);
						obj.put("PAYSEQ", null);
						obj.put("PAYDATE", null);
						obj.put("PAYAMT", null);
						obj.put("TAX", null);
						obj.put("TAXLOCAL", null);
						obj.put("DEDUCTAMT", null);
						obj.put("CONNAME", null);
						obj.put("CONPY", null);
						obj.put("ADDRESS", null);
						obj.put("KNAME", null);
						obj.put("JUMINID", null);
						obj.put("NAME_BRANCHCODE", null);
						obj.put("NAME_DEPTCODE", null);
					}
					
					obj.put("PAYERNAME", s_lst.get(j).getPAYERNAME());
					obj.put("PAYERID", s_lst.get(j).getPAYERID());
					
					jCell.add(obj);
				}
			} else {
				JSONObject obj = new JSONObject();
				
				obj.put("SALEID", lst.get(i).getSALEID());
				obj.put("PAYSEQ", lst.get(i).getPAYSEQ());
				obj.put("PAYDATE", lst.get(i).getPAYDATE());
				obj.put("PAYAMT", lst.get(i).getPAYAMT());
				obj.put("TAX", lst.get(i).getTAX());
				obj.put("TAXLOCAL", lst.get(i).getTAXLOCAL());
				obj.put("DEDUCTAMT", lst.get(i).getDEDUCTAMT());
				obj.put("CONNAME", lst.get(i).getCONNAME());
				obj.put("CONPY", lst.get(i).getCONPY());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("JUMINID", lst.get(i).getJUMINID());
				obj.put("NAME_BRANCHCODE", lst.get(i).getNAME_BRANCHCODE());
				obj.put("NAME_DEPTCODE", lst.get(i).getNAME_DEPTCODE());
				
				obj.put("PAYERNAME", null);
				obj.put("PAYERID", null);
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListEP012002]" + json);
		
		return new ModelAndView("jsonView", json);
	}
}
