package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.personMng.Biz.HR011001Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR011001Ctr {
	
	@Resource(name = "HR011001Biz")
	private HR011001Biz HR011001Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public HR011001Ctr() {}
	
	/**
	 * @name 인사관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR011001.do")
	public ModelAndView HR011001(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR011001");
	}
	
	
	/**
	 * @name 사원검색 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR011001_1.do")
	public ModelAndView HR011001_1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR011001_1");
	}
		
	
	/**
	 * @name 인사관리 화면 - 인사관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectListEnaInsaMst.do")
	public ModelAndView selectListEnaInsaMst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HR011001VO vo = new HR011001VO();			
		
		String s_branchcode = request.getParameter("S_BRANCHCODE") != null ? request.getParameter("S_BRANCHCODE") : ""; 
		String s_deptcode = request.getParameter("S_DEPTCODE") != null ? request.getParameter("S_DEPTCODE") : ""; 
		String s_kname = request.getParameter("S_KNAME") != null ? request.getParameter("S_KNAME") : ""; 
		String s_juminid = request.getParameter("S_JUMINID") != null ? request.getParameter("S_JUMINID") : ""; 
		String s_insacode = request.getParameter("S_INSACODE") != null ? request.getParameter("S_INSACODE") : ""; 
		
		vo.setS_BRANCHCODE(s_branchcode);
		vo.setS_DEPTCODE(s_deptcode);
		vo.setS_KNAME(s_kname);
		vo.setS_JUMINID(s_juminid);
		vo.setS_INSACODE(s_insacode);
		
		List<HR011001VO> lst = HR011001Biz.selectListEnaInsaMst(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		if(lst.size() > 0){
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				obj.put("INSACODE", lst.get(i).getINSACODE());
				obj.put("KNAME", lst.get(i).getKNAME());
				obj.put("JUMINID", lst.get(i).getJUMINID());
				obj.put("BIRTHDAYGUBUN", lst.get(i).getBIRTHDAYGUBUN());
				obj.put("SAUPID", lst.get(i).getSAUPID());
				obj.put("SAUPOWNER", lst.get(i).getSAUPOWNER());
				obj.put("ADDRESS", lst.get(i).getADDRESS());
				obj.put("MOBILENO", lst.get(i).getMOBILENO());
				obj.put("TELNO", lst.get(i).getTELNO());
				obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
				obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
				obj.put("DEPTCODE", lst.get(i).getDEPTCODE());
				obj.put("DEPTNAME", lst.get(i).getDEPTNAME());
				obj.put("BASICPAY", lst.get(i).getBASICPAY());
				obj.put("EMPLOYGUBUN", lst.get(i).getEMPLOYGUBUN());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				obj.put("JOINDATE", lst.get(i).getJOINDATE());
				obj.put("REJOINYN", lst.get(i).getREJOINYN());
				obj.put("RETIREDATE", lst.get(i).getRETIREDATE());
				obj.put("RECOID", lst.get(i).getRECOID());
				obj.put("REMARK", lst.get(i).getREMARK());
				
				
				jCell.add(obj);
			}
		}else{
			JSONObject obj = new JSONObject();
			
			obj.put("INSACODE", "");
			obj.put("KNAME", "");
			obj.put("JUMINID", "");
			obj.put("BIRTHDAYGUBUN", "");
			obj.put("SAUPID", "");
			obj.put("SAUPOWNER", "");
			obj.put("ADDRESS", "");
			obj.put("MOBILENO", "");
			obj.put("TELNO", "");
			obj.put("BRANCHCODE", "");
			obj.put("DEPTCODE", "");
			obj.put("BASICPAY", "");
			obj.put("EMPLOYGUBUN", "");
			obj.put("GRADE", "");
			obj.put("DUTY", "");
			obj.put("JOINDATE", "");
			obj.put("REJOINYN", "");
			obj.put("RETIREDATE", "");
			obj.put("RECOLID", "");
			obj.put("REMARK", "");
			
			jCell.add(obj);
			
		}
		json.put("rows", jCell);
		
		System.out.println("json==>"+json.get("rows"));
		logger.debug("[selectListSY021001]" + json);
		
		return new ModelAndView("jsonView", json);
	
	}

	
	
	
	/**
	 * @name 인사 기본 정보 관리 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaInsaMst.do")
	public ModelAndView updateEnaInsaMst(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HR011001VO vo = new HR011001VO();		
		
		int updateCnt = 0;
		int insertCnt = 0;
		
		String insacode = request.getParameter("INSACODE");		
		String juminId = request.getParameter("JUMINID1") + request.getParameter("JUMINID2");
		String saupId = request.getParameter("SAUPID1") + request.getParameter("SAUPID2") + request.getParameter("SAUPID3");
		
		vo.setINSACODE(insacode);
		vo.setKNAME(request.getParameter("KNAME"));
		vo.setJUMINID(juminId);
		vo.setBIRTHDAYGUBUN(request.getParameter("BIRTHDAYGUBUN"));
		vo.setSAUPID(saupId);
		vo.setSAUPOWNER(request.getParameter("SAUPOWNER"));
		vo.setADDRESS(request.getParameter("ADDRESS"));
		vo.setMOBILENO(request.getParameter("MOBILENO"));
		vo.setTELNO(request.getParameter("TELNO"));
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));
		vo.setDEPTCODE(request.getParameter("DEPTCODE"));
		vo.setBASICPAY(request.getParameter("BASICPAY"));
		vo.setEMPLOYGUBUN(request.getParameter("EMPLOYGUBUN"));
		vo.setGRADE(request.getParameter("GRADE"));
		vo.setDUTY(request.getParameter("DUTY"));
		vo.setJOINDATE(request.getParameter("JOINDATE"));
		vo.setREJOINYN(request.getParameter("REJOINYN"));
		vo.setRECOID(request.getParameter("RECOID"));
		vo.setREMARK(request.getParameter("REMARK"));

		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		

		JSONObject obj = new JSONObject();
		
		
		if(insacode == null || insacode == ""){
			insertCnt = HR011001Biz.insertEnaInsaMst(vo);
			if(insertCnt > 0){
				obj.put("MSG", "SUCCESS");
			}else{
				obj.put("MSG", "ERROR");
			}			
		}else{
			updateCnt = HR011001Biz.updateEnaInsaMst(vo);
			if(updateCnt > 0){
				obj.put("MSG", "SUCCESS");
			}else{
				obj.put("MSG", "ERROR");
			}
		}

		jCell.add(obj);
		json.put("rows", jCell);
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	
	}
	
	
	
	/**
	 * @name 인사관리 화면 - 발령사항 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectListEnaAppointItem.do")
	public ModelAndView selectListEnaAppointItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR011001VO vo = new HR011001VO();
		
		vo.setINSACODE(request.getParameter("INSACODE"));
		
		List<HR011001VO> lst = HR011001Biz.selectListEnaAppointItem(vo);	
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			//System.out.println(lst.get(i).getSYSID());
			JSONObject jData = new JSONObject();			
			
			jData.put("INSACODE", lst.get(i).getINSACODE());
			jData.put("APPOINTSEQ", lst.get(i).getAPPOINTSEQ());
			jData.put("APPOINTGUBUN", lst.get(i).getAPPOINTGUBUN());
			jData.put("APPOINTDATE", lst.get(i).getAPPOINTDATE());
			jData.put("APPOINTBRANCHCODE", lst.get(i).getAPPOINTBRANCH()); //코드값으로 가져오기
			jData.put("APPOINTBRANCH", lst.get(i).getBRANCHNAME());
			jData.put("APPOINTDEPT", lst.get(i).getDEPTNAME());			
//			jData.put("APPOINTDEPT", lst.get(i).getAPPOINTDEPT());			
			jData.put("GRADE", lst.get(i).getGRADE());
			jData.put("DUTY", lst.get(i).getDUTY());
			jData.put("EMPLOYGUBUN", lst.get(i).getEMPLOYGUBUN());
			jData.put("PREBASICPAY", lst.get(i).getPREBASICPAY());
			jData.put("DEPTGUBUN", "");
			jData.put("REMARK", lst.get(i).getREMARK());
			
			
			jCell.add(i, jData);
		}
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
	

	
	/**
	 * @name 발령사항 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaAppointItem.do")
	public ModelAndView updateEnaAppointItem(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HR011001VO vo = new HR011001VO();		
		
		int updateCnt = 0;
		int insertCnt = 0;
		System.out.println("APPOINTSEQ      =              "   + request.getParameter("APPOINTSEQ"));
		vo.setINSACODE(request.getParameter("INSACODE"));		
		vo.setAPPOINTSEQ(request.getParameter("APPOINTSEQ"));
		vo.setAPPOINTGUBUN(request.getParameter("APPOINTGUBUN"));
		vo.setAPPOINTDATE(request.getParameter("APPOINTDATE"));
		vo.setAPPOINTBRANCH(request.getParameter("APPOINTBRANCH"));
		vo.setAPPOINTDEPT(request.getParameter("APPOINTDEPT"));
		vo.setGRADE(request.getParameter("GRADE"));
		vo.setDUTY(request.getParameter("DUTY"));
		vo.setEMPLOYGUBUN(request.getParameter("EMPLOYGUBUN"));
		vo.setPREBASICPAY(request.getParameter("PREBASICPAY"));
		vo.setREMARK(request.getParameter("REMARK"));

		
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));		
		
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		
		
		JSONObject obj = new JSONObject();
		
		String IU_Flag = request.getParameter("S_FLAG_B1");
		
		if ("I".equals(IU_Flag)) {
			insertCnt = HR011001Biz.insertEnaAppointItem(vo);
			if(insertCnt > 0){
				obj.put("MSG", "SUCCESS");
			}else{
				obj.put("MSG", "ERROR");
			}	
		} else if ("U".equals(IU_Flag)) {
			updateCnt = HR011001Biz.updateEnaAppointItem(vo);
			if(updateCnt > 0){
				obj.put("MSG", "SUCCESS");
			}else{
				obj.put("MSG", "ERROR");
			}
		}
		

		jCell.add(obj);
		json.put("rows", jCell);
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	
	}	
		
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/deleteEnaAppointItem.do")
	public ModelAndView deleteEnaAppointItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HR011001VO vo = new HR011001VO();
		
		vo.setINSACODE(request.getParameter("INSACODE"));
		vo.setAPPOINTSEQ(request.getParameter("APPOINTSEQ"));

		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		
		
		JSONObject obj = new JSONObject();
		
		
		if (HR011001Biz.deleteEnaAppointItem(vo) == true) {
			obj.put("MSG", "SUCCESS");
		} else {
			obj.put("MSG", "ERROR");
		}
		
		jCell.add(obj);
		json.put("rows", jCell);

		logger.debug("[deleteEnaAppointItem]" + json);
		
		return new ModelAndView("jsonView", json);
	}		
	
	/**
	 * @name 인사관리 화면 - 신고인 관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectListEnaTexPayerItem.do")
	public ModelAndView selectListEnaTexPayerItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HR011001VO vo = new HR011001VO();
		
		vo.setINSACODE(request.getParameter("INSACODE"));
		List<HR011001VO> lst = HR011001Biz.selectListEnaTexPayerItem(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		for (int i = 0; i < lst.size(); i++) {
			//System.out.println(lst.get(i).getSYSID());
			JSONObject jData = new JSONObject();
			jData.put("INSACODE", lst.get(i).getINSACODE());
			jData.put("ITEMSEQ", lst.get(i).getITEMSEQ());
			jData.put("PAYERNAME", lst.get(i).getPAYERNAME());
			jData.put("PAYERID", lst.get(i).getPAYERID());
			jData.put("BANKID", lst.get(i).getBANKID());
			jData.put("ACCTNO", lst.get(i).getACCTNO());
			jData.put("ACCTOWNER", lst.get(i).getACCTOWNER());
			jData.put("BASICACCT", lst.get(i).getBASICACCT());
			jData.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(i, jData);
		}
		json.put("rows", jCell);
		
		return new ModelAndView("jsonView", json);
	}
	
	

	
	/**
	 * @name 신고인 관리 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/updateEnaTexPayerItem.do")
	public ModelAndView updateEnaTexPayerItem(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HR011001VO vo = new HR011001VO();		
		
		int updateCnt = 0;
		int insertCnt = 0;

		vo.setINSACODE(request.getParameter("INSACODE"));		
		vo.setITEMSEQ(request.getParameter("ITEMSEQ"));
		vo.setPAYERNAME(request.getParameter("PAYERNAME"));
		vo.setPAYERID(request.getParameter("PAYERID"));
		vo.setBANKID(request.getParameter("BANKID"));
		vo.setACCTNO(request.getParameter("ACCTNO"));
		vo.setACCTOWNER(request.getParameter("ACCTOWNER"));
		vo.setBASICACCT(request.getParameter("BASICACCT"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		String basicacct = request.getParameter("BASICACCT");
		if(basicacct.equals("Y") || basicacct == "Y" ){
			HR011001Biz.updateBasicAcct(vo);
		}
		
				
		HttpSession session = null;
		session = request.getSession(false);
		vo.setUSERID((String)session.getAttribute("userId"));		
		
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		
		
		JSONObject obj = new JSONObject();
		
		String IU_Flag = request.getParameter("S_FLAG_B2");
		
		if ("I".equals(IU_Flag)) {
			insertCnt = HR011001Biz.insertEnaTexPayerItem(vo);
			if(insertCnt > 0){
				obj.put("MSG", "SUCCESS");
			}else{
				obj.put("MSG", "ERROR");
			}	
		} else if ("U".equals(IU_Flag)) {
			updateCnt = HR011001Biz.updateEnaTexPayerItem(vo);
			if(updateCnt > 0){
				obj.put("MSG", "SUCCESS");
			}else{
				obj.put("MSG", "ERROR");
			}
		}
		

		jCell.add(obj);
		json.put("rows", jCell);
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	
	}	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/deleteEnaTexPayerItem.do")
	public ModelAndView deleteEnaTexPayerItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HR011001VO vo = new HR011001VO();
		
		vo.setINSACODE(request.getParameter("INSACODE"));
		vo.setITEMSEQ(request.getParameter("ITEMSEQ"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();		
		
		JSONObject obj = new JSONObject();
		
		
		if (HR011001Biz.deleteEnaTexPayerItem(vo) == true) {
			obj.put("MSG", "SUCCESS");
		} else {
			obj.put("MSG", "ERROR");
		}
		
		jCell.add(obj);
		json.put("rows", jCell);

		logger.debug("[deleteEnaTexPayerItem]" + json);
		
		return new ModelAndView("jsonView", json);
	}			
	
	/**
	 * @name 인사관리 화면 - 신고인 관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/home/selectDeptGubun.do")
	public ModelAndView selectDeptGubun(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HR011001VO vo = new HR011001VO();
		
		vo.setDEPTCODE(request.getParameter("APPOINTDEPT"));
		List<HR011001VO> lst = HR011001Biz.selectDeptGubun(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		for (int i = 0; i < lst.size(); i++) {
			//System.out.println(lst.get(i).getSYSID());
			JSONObject jData = new JSONObject();
			jData.put("DEPTGUBUN", lst.get(i).getDEPTGUBUN());
			
			jCell.add(i, jData);
		}
		json.put("DeptGubun", jCell);
		
		return new ModelAndView("jsonView", json);
	}	
}
