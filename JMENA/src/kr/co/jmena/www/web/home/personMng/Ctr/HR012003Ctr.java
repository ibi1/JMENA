package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.personMng.Biz.HR012003Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012003VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR012003Ctr {
	
	@Resource(name = "HR012003Biz")
	private HR012003Biz HR012003Biz;
	
	public HR012003Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	

	/**
	 * @name 인원현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012003.do")
	public ModelAndView HR012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012003");
	}

	/**
	 * @name 인원현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListHR012003.do")
	public ModelAndView selectListHR012003(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR012003VO vo = new HR012003VO();
		HR012003VO vo1 = new HR012003VO();
		
		vo.setS_JOINDATE(request.getParameter("S_JOINDATE"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_JOINDATE").equals("") && 
				request.getParameter("S_BRANCHCODE").equals("") && 
				request.getParameter("S_DEPTCODE").equals(""))){

			List<HR012003VO> lst = HR012003Biz.selectListHR012003(vo);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				vo1.setINSACODE(lst.get(i).getINSACODE());
				
				List<HR012003VO> lst2 = HR012003Biz.selectListHR012003_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst2.size(); j++) {
						if(j == 0){
							obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
							obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
							obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
							obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
							obj.put("DUTY",lst.get(i).getDUTY());
							obj.put("INSACODE",lst.get(i).getINSACODE());
							obj.put("KNAME",lst.get(i).getKNAME());
							obj.put("RECOID",lst.get(i).getRECOID());
							obj.put("RECONAME",lst.get(i).getRECONAME());
							obj.put("JOINDATE",lst.get(i).getJOINDATE());
							obj.put("MOBILENO",lst.get(i).getMOBILENO());
							obj.put("JUMINID",lst.get(i).getJUMINID());
							obj.put("BIRTHDAYGUBUN",lst.get(i).getBIRTHDAYGUBUN());
							obj.put("ACCTOWNER",lst.get(i).getACCTOWNER());
							obj.put("BANKID",lst.get(i).getBANKID());
							obj.put("BANKNAME",lst.get(i).getBANKNAME());
							obj.put("ACCTNO",lst.get(i).getACCTNO());
							obj.put("PAYERNAME",lst.get(i).getPAYERNAME());
							obj.put("PAYERID",lst.get(i).getPAYERID());
							obj.put("ADDRESS",lst.get(i).getADDRESS());						
							
							
						}else{
							obj.put("BRANCHCODE","");
							obj.put("BRANCHNAME","");
							obj.put("DEPTCODE","");
							obj.put("DEPTNAME","");
							obj.put("DUTY","");
							obj.put("INSACODE","");
							obj.put("KNAME","");
							obj.put("RECOID","");
							obj.put("RECONAME","");
							obj.put("JOINDATE","");
							obj.put("MOBILENO","");
							obj.put("JUMINID","");
							obj.put("BIRTHDAYGUBUN","");
							obj.put("ACCTOWNER","");
							obj.put("BANKID","");
							obj.put("BANKNAME","");
							obj.put("ACCTNO","");
							obj.put("PAYERNAME","");
							obj.put("PAYERID","");
							obj.put("ADDRESS","");						
							
						}
						
						obj.put("O_BRANCHNAME",lst2.get(j).getO_BRANCHNAME());
						obj.put("O_JOINDATE",lst2.get(j).getO_JOINDATE());
						obj.put("O_RETIREDATE",lst2.get(j).getO_RETIREDATE());
						obj.put("O_EMPLOYGUBUN",lst2.get(j).getO_EMPLOYGUBUN());
	
						jCell.add(obj);
					}
				}else{
					obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
					obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
					obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
					obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
					obj.put("DUTY",lst.get(i).getDUTY());
					obj.put("INSACODE",lst.get(i).getINSACODE());
					obj.put("KNAME",lst.get(i).getKNAME());
					obj.put("RECOID",lst.get(i).getRECOID());
					obj.put("RECONAME",lst.get(i).getRECONAME());
					obj.put("JOINDATE",lst.get(i).getJOINDATE());
					obj.put("MOBILENO",lst.get(i).getMOBILENO());
					obj.put("JUMINID",lst.get(i).getJUMINID());
					obj.put("BIRTHDAYGUBUN",lst.get(i).getBIRTHDAYGUBUN());
					obj.put("ACCTOWNER",lst.get(i).getACCTOWNER());
					obj.put("BANKID",lst.get(i).getBANKID());
					obj.put("BANKNAME",lst.get(i).getBANKNAME());
					obj.put("ACCTNO",lst.get(i).getACCTNO());
					obj.put("PAYERNAME",lst.get(i).getPAYERNAME());
					obj.put("PAYERID",lst.get(i).getPAYERID());
					obj.put("ADDRESS",lst.get(i).getADDRESS());						
					
					
					obj.put("O_BRANCHNAME","");
					obj.put("O_JOINDATE","");
					obj.put("O_RETIREDATE","");
					obj.put("O_EMPLOYGUBUN","");
					
					jCell.add(obj);
				}
				
			}
		}
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

}
