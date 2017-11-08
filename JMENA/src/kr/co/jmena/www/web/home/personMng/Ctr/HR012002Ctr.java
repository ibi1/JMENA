package kr.co.jmena.www.web.home.personMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.personMng.Biz.HR012002Biz;
import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HR012002Ctr {
	
	@Resource(name = "HR012002Biz")
	private HR012002Biz HR012002Biz;
	
	public HR012002Ctr() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	/**
	 * @name 퇴사자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/HR012002.do")
	public ModelAndView HR012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("home/personMng/HR012002");
	}

	/**
	 * @name 인사관리 화면 - 인사관리 그리드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListHR012002.do")
	public ModelAndView selectListHR012002(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HR012002VO vo = new HR012002VO();
		HR012002VO vo1 = new HR012002VO();
		HR012002VO vo2 = new HR012002VO();
		HR012002VO vo3 = new HR012002VO();
		
		vo.setS_RETIREDATE_FR(request.getParameter("S_RETIREDATE_FR"));
		vo.setS_RETIREDATE_TO(request.getParameter("S_RETIREDATE_TO"));
		vo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));
		vo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));
		vo.setS_KNAME(request.getParameter("S_KNAME"));
		vo.setS_JUMINID(request.getParameter("S_JUMINID"));
		
		
		List<HR012002VO> lst = HR012002Biz.selectListHR012002(vo);
		
		System.out.println("******************************************");
		System.out.println("size()"+lst.size());
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject obj = new JSONObject();
			
			vo1.setINSACODE(request.getParameter(lst.get(i).getINSACODE()));
			
			List<HR012002VO> lst2 = HR012002Biz.selectListHR012002_2(vo1);
			if(lst2.size() > 0){
				for (int j = 0; j < lst2.size(); j++) {
					if(j == 0){
						obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
						obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
						obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
						obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
						obj.put("GRADE",lst.get(i).getGRADE());
						obj.put("DUTY",lst.get(i).getDUTY());
						obj.put("EMPLOYGUBUN",lst.get(i).getEMPLOYGUBUN());
						obj.put("INSACODE",lst.get(i).getINSACODE());
						obj.put("KNAME",lst.get(i).getKNAME());
						obj.put("RECONAME",lst.get(i).getRECONAME());
						obj.put("JOINDATE",lst.get(i).getJOINDATE());
						obj.put("RETIREDATE",lst.get(i).getRETIREDATE());
						obj.put("REMARK",lst.get(i).getREMARK());
						
						vo2.setINSACODE(request.getParameter(lst.get(i).getINSACODE()));
						vo2.setO_JOINDATE(request.getParameter(lst.get(i).getJOINDATE()));
						vo2.setO_RETIREDATE(request.getParameter(lst.get(i).getRETIREDATE()));
						
						List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
						if(lst3.size() > 0){
							
							obj.put("SELLAMT",lst3.get(0).getO_SELLAMT());
							
						}else{
							obj.put("SELLAMT","");
						}
						
					}else{
						obj.put("BRANCHCODE","");
						obj.put("BRANCHNAME","");
						obj.put("DEPTCODE","");
						obj.put("DEPTNAME","");
						obj.put("GRADE","");
						obj.put("DUTY","");
						obj.put("EMPLOYGUBUN","");
						obj.put("INSACODE","");
						obj.put("KNAME","");
						obj.put("RECONAME","");
						obj.put("JOINDATE","");
						obj.put("RETIREDATE","");
						obj.put("REMARK","");
						obj.put("SELLAMT","");
						
					}
					obj.put("O_BRANCHNAME",lst2.get(j).getO_BRANCHNAME());
					obj.put("O_JOINDATE",lst2.get(j).getO_JOINDATE());
					obj.put("O_RETIREDATE",lst2.get(j).getO_RETIREDATE());
					obj.put("O_REMARK",lst2.get(j).getO_REMARK());

					vo3.setINSACODE(request.getParameter(lst.get(i).getINSACODE()));
					vo3.setO_JOINDATE(request.getParameter(lst2.get(j).getO_JOINDATE()));
					vo3.setO_RETIREDATE(request.getParameter(lst2.get(j).getO_RETIREDATE()));
					
					List<HR012002VO> lst4 = HR012002Biz.selectListHR012002_3(vo3);
					if(lst4.size() > 0){
						
						obj.put("O_SELLAMT",lst4.get(0).getO_SELLAMT());
						
					}else{
						obj.put("O_SELLAMT","");
					}
					
					jCell.add(obj);
				}
			}else{
				obj.put("BRANCHCODE",lst.get(i).getBRANCHCODE());
				obj.put("BRANCHNAME",lst.get(i).getBRANCHNAME());
				obj.put("DEPTCODE",lst.get(i).getDEPTCODE());
				obj.put("DEPTNAME",lst.get(i).getDEPTNAME());
				obj.put("GRADE",lst.get(i).getGRADE());
				obj.put("DUTY",lst.get(i).getDUTY());
				obj.put("EMPLOYGUBUN",lst.get(i).getEMPLOYGUBUN());
				obj.put("INSACODE",lst.get(i).getINSACODE());
				obj.put("KNAME",lst.get(i).getKNAME());
				obj.put("RECONAME",lst.get(i).getRECONAME());
				obj.put("JOINDATE",lst.get(i).getJOINDATE());
				obj.put("RETIREDATE",lst.get(i).getRETIREDATE());
				obj.put("REMARK",lst.get(i).getREMARK());
				
				vo2.setINSACODE(request.getParameter(lst.get(i).getINSACODE()));
				vo2.setO_JOINDATE(request.getParameter(lst.get(i).getJOINDATE()));
				vo2.setO_RETIREDATE(request.getParameter(lst.get(i).getRETIREDATE()));
				
				List<HR012002VO> lst3 = HR012002Biz.selectListHR012002_3(vo2);
				if(lst3.size() > 0){
					
					obj.put("SELLAMT",lst3.get(0).getO_SELLAMT());
					
				}else{
					obj.put("SELLAMT","");
				}
				
				obj.put("O_BRANCHNAME","");
				obj.put("O_JOINDATE","");
				obj.put("O_RETIREDATE","");
				obj.put("O_SELLAMT","");
				obj.put("O_REMARK","");
				
				jCell.add(obj);
			}
			
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
	
}
