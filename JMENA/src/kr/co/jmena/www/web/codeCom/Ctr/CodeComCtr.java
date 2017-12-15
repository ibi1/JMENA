package kr.co.jmena.www.web.codeCom.Ctr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.common.util.LoginCheckInterceptor;
import kr.co.jmena.www.web.codeCom.Biz.CodeComBiz;
import kr.co.jmena.www.web.codeCom.Vo.BankVO;
import kr.co.jmena.www.web.codeCom.Vo.CityVO;
import kr.co.jmena.www.web.codeCom.Vo.DcodeVO;
import kr.co.jmena.www.web.codeCom.Vo.UserVO;
import kr.co.jmena.www.web.codeCom.Vo.BranchVO;
import kr.co.jmena.www.web.codeCom.Vo.DeptVO;
import kr.co.jmena.www.web.codeCom.Vo.InsaVO;

import kr.co.jmena.www.web.home.main.Biz.MainBiz;
import kr.co.jmena.www.web.home.main.Vo.MainVO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class CodeComCtr {
	
	@Resource(name = "codeComBiz")
	private CodeComBiz codeComBiz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public CodeComCtr() {}
	
	/**
	 * sy_bankmst 테이블 리스트 가져오기 (은행 코드 관리)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/bankList.do")
	public ModelAndView bankList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<BankVO> lst = codeComBiz.selectBankList();
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("bankCode", lst.get(i).getBANKCODE());
			jData.put("bankName", lst.get(i).getBANKNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("bankList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * sy_ccodedtl 테이블 특정 리스트 가져오기 (공통 코드 관리)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/dcodeList.do")
	public ModelAndView dcodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		DcodeVO vo = new DcodeVO();
		logger.debug("[test]" + request.getParameter("CCODE"));
		
		vo.setCCODE(request.getParameter("CCODE"));
		
		List<DcodeVO> lst = codeComBiz.selectDcodeList(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("DCODE", lst.get(i).getDCODE());
			jData.put("DCODENAME", lst.get(i).getDCODENAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("dcodeList", jsonArr);
		logger.debug("[test]" + json);
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * sy_usermst 테이블 특정 리스트 가져오기 (유저 리스트)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/userList.do")
	public ModelAndView userList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<UserVO> lst = codeComBiz.selectUserList();
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("USERID", lst.get(i).getUSERID());
			jData.put("USERNAME", lst.get(i).getUSERNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("userList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * ba_citymst 테이블 리스트 가져오기 (시/도 리스트)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/cityMstList.do")
	public ModelAndView cityMstList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<CityVO> lst = codeComBiz.selectCityMstList();
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("CITYCODE", lst.get(i).getCITYCODE());
			jData.put("CITYNAME", lst.get(i).getCITYNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("cityMstList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
	/**
	 * ba_citydtl 테이블 특정 리스트 가져오기 (구/군 리스트)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/cityDtlList.do")
	public ModelAndView cityDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CityVO vo = new CityVO();
		
		vo.setCITYCODE(request.getParameter("CITYCODE"));
		
		List<CityVO> lst = codeComBiz.selectCityDtlList(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("BOROUGHCODE", lst.get(i).getBOROUGHCODE());
			jData.put("BOROUGHNAME", lst.get(i).getBOROUGHNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("cityDtlList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * ba_branchMst 테이블 특정 리스트 가져오기 (지사 리스트)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/branchMstList.do")
	public ModelAndView branchMstList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BranchVO vo = new BranchVO();
		
		vo.setUSEYN("Y".equals(request.getParameter("USEYN")) ? "Y" : "N");

		List<BranchVO> lst = codeComBiz.selectBranchMstList(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
			jData.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("branchMstList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * ba_branchMst 테이블 특정 리스트 가져오기 (부서 리스트)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/deptMstList.do")
	public ModelAndView deptMstList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		DeptVO vo = new DeptVO();
		
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));

		List<DeptVO> lst = codeComBiz.selectDeptMstList(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("DEPTCODE", lst.get(i).getDEPTCODE());
			jData.put("DEPTNAME", lst.get(i).getDEPTNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("deptMstList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}

	/**
	 * ba_branchMst 테이블 특정 리스트 가져오기 (인사 리스트)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/codeCom/insaMstList.do")
	public ModelAndView insaMstList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InsaVO vo = new InsaVO();
		
		vo.setBRANCHCODE(request.getParameter("BRANCHCODE"));

		List<InsaVO> lst = codeComBiz.selectInsaMstList(vo);
		
		JSONArray jsonArr = new JSONArray();
		JSONObject json = new JSONObject();
		
		for (int i = 0; i < lst.size(); i++) {
			JSONObject jData = new JSONObject();
			jData.put("INSACODE", lst.get(i).getINSACODE());
			jData.put("KNAME", lst.get(i).getKNAME());
			
			jsonArr.add(i, jData);
		}
		
		json.put("insaMstList", jsonArr);
		
		return new ModelAndView("jsonView", json);
	}
	
}
