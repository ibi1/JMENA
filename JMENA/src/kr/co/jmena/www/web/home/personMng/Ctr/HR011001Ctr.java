package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.personMng.Biz.HR011001Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;

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
				obj.put("DEPTCODE", lst.get(i).getDEPTCODE());
				obj.put("BASICPAY", lst.get(i).getBASICPAY());
				obj.put("EMPLOYGUBUN", lst.get(i).getEMPLOYGUBUN());
				obj.put("GRADE", lst.get(i).getGRADE());
				obj.put("DUTY", lst.get(i).getDUTY());
				obj.put("JOINDATE", lst.get(i).getJOINDATE());
				obj.put("REJOINYN", lst.get(i).getREJOINYN());
				obj.put("RETIREDATE", lst.get(i).getRETIREDATE());
				obj.put("RECOLID", lst.get(i).getRECOID());
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
		
		System.out.println("selectListEnaAppointItem     INSACODE==>"+ request.getParameter("INSACODE"));
		List<HR011001VO> lst = HR011001Biz.selectListEnaAppointItem(vo);
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			//System.out.println(lst.get(i).getSYSID());
			JSONObject jData = new JSONObject();
			jData.put("APPOINTGUBUN", lst.get(i).getAPPOINTGUBUN());
			jData.put("APPOINTDATE", lst.get(i).getAPPOINTDATE());
			jData.put("APPOINTBRANCH", lst.get(i).getAPPOINTBRANCH());
			jData.put("APPOINTDEPT", lst.get(i).getAPPOINTDEPT());
			jData.put("GRADE", lst.get(i).getGRADE());
			jData.put("DUTY", lst.get(i).getDUTY());
			jData.put("EMPLOYGUBUN", lst.get(i).getEMPLOYGUBUN());
			jData.put("PREBASICPAY", lst.get(i).getBASICPAY());
			jData.put("REMARK", lst.get(i).getREMARK());
			
			
			jCell.add(i, jData);
		}
		json.put("rows", jCell);
		
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
		System.out.println("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		System.out.println("selectListEnaTexPayerItem     INSACODE==>"+ request.getParameter("INSACODE"));
		HR011001VO vo = new HR011001VO();
		
		vo.setINSACODE(request.getParameter("INSACODE"));
		System.out.println(request.getParameter("INSACODE"));
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
			jData.put("REMARK", lst.get(i).getREMARK());
			
			jCell.add(i, jData);
		}
		json.put("rows", jCell);
		
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
	@RequestMapping("/home/updateHR011001.do")
	public ModelAndView updateHR011001(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HR011001VO vo = new HR011001VO();
		
		List<HR011001VO> list = HR011001Biz.selectListEnaInsaMst(vo);

		int updateCnt = 0;
		int insertCnt = 0;

		vo.setINSACODE(request.getParameter("INSACODE"));
		vo.setKNAME(request.getParameter("KNAME"));
		vo.setJUMINID(request.getParameter("JUMINID"));
		vo.setBIRTHDAYGUBUN(request.getParameter("BIRTHDAYGUBUN"));
		vo.setSAUPID(request.getParameter("SAUPID"));
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
		vo.setRETIREDATE(request.getParameter("RETIREDATE"));
		vo.setRECOID(request.getParameter("RECOID"));
		vo.setREMARK(request.getParameter("REMARK"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		
		
		if(list.size() > 0){
			updateCnt = HR011001Biz.updateEnaInsaMst(vo);
			
			
			JSONObject obj = new JSONObject();
			if(updateCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
			jCell.add(obj);
			json.put("rows", jCell);
			
		}else{
			insertCnt = HR011001Biz.insertEnaInsaMst(vo);
			
			JSONObject obj = new JSONObject();
			obj.put("insertCnt", insertCnt);
			json.put("rows", jCell);
			if(insertCnt > 0){
				obj.put("MSG", "success");
			}else{
				obj.put("MSG", "error");
			}
			jCell.add(obj);
			json.put("rows", jCell);
		}
		
		System.out.println("updateCnt==>"+updateCnt);
		System.out.println("insertCnt==>"+insertCnt);
		
		System.out.println("json==>"+json);
		
		return new ModelAndView("jsonView", json);	
	}

}
