package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.expayMng.Dao.EP011002Dao;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011002VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011004VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP011002Biz {
	
	@Resource(name = "EP011002Dao")
	private EP011002Dao EP011002Dao;

	public EP011002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP011002VO> selectListEnaMonthPayMst(EP011002VO vo) throws Exception {
		List<EP011002VO> lst = null;

		try {
			lst = EP011002Dao.selectListEnaMonthPayMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<EP011002VO> selectListEnaMonthPayMstCrt(EP011002VO vo) throws Exception {
		List<EP011002VO> lst = null;

		try {
			lst = EP011002Dao.selectListEnaMonthPayMstCrt(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}	
	
	
	public boolean insertEnaMonthPayMst(HttpServletRequest request) throws Exception {
		boolean chkFlag = false;
		EP011002VO delVo = new EP011002VO();
		
		try {
			String userId = request.getParameter("USERID");
			String sysId = request.getParameter("SYSID");
			String menuId = request.getParameter("MENUID");
			

			HttpSession session = null;
			session = request.getSession(false);
			String sessionUserId = (String)session.getAttribute("userId");
			
			
			delVo.setS_YEARMONTH(request.getParameter("S_YEARMONTH"));			
			delVo.setS_BRANCHCODE(request.getParameter("S_BRANCHCODE"));			
			delVo.setS_DEPTCODE(request.getParameter("S_DEPTCODE"));			
			
			
			
			logger.debug("[insertEnaMonthPayMst.length                   biz]");
			EP011002Dao.deleteEnaMonthPayMstAll(delVo);
			logger.debug("[insertEnaMonthPayMst.length                   biz1]");

				//Insert Array
				String yearmonthArr[] = request.getParameterValues("yearmonthArr[]");
				logger.debug("[yearmonthArr.length]");
				String paydateArr[] = request.getParameterValues("paydateArr[]");
				String branchcodeArr[] = request.getParameterValues("branchcodeArr[]");
				String deptcodeArr[] = request.getParameterValues("deptcodeArr[]");
				String gradeArr[] = request.getParameterValues("gradeArr[]");
				String dutyArr[] = request.getParameterValues("dutyArr[]");
				String insacodeArr[] = request.getParameterValues("insacodeArr[]");
				String knameArr[] = request.getParameterValues("knameArr[]");
				String basicamtArr[] = request.getParameterValues("basicamtArr[]");
				String actamtArr[] = request.getParameterValues("actamtArr[]");
				String dailyamtArr[] = request.getParameterValues("dailyamtArr[]");
				String prizeamtArr[] = request.getParameterValues("prizeamtArr[]");
				String totalamtArr[] = request.getParameterValues("totalamtArr[]");
				String taxgubunArr[] = request.getParameterValues("taxgubunArr[]");
				String taxincomeArr[] = request.getParameterValues("taxincomeArr[]");
				String taxlocalArr[] = request.getParameterValues("taxlocalArr[]");
				String supplytaxArr[] = request.getParameterValues("supplytaxArr[]");
				String deductamtArr[] = request.getParameterValues("deductamtArr[]");
				String bankidArr[] = request.getParameterValues("bankidArr[]");
				String acctnoArr[] = request.getParameterValues("acctnoArr[]");
				String acctownerArr[] = request.getParameterValues("acctownerArr[]");				
				logger.debug("[yearmonthArr.length]" + yearmonthArr);
				
				
				int cnt = 0;
				for (String ym : yearmonthArr) {
					EP011002VO vo = new EP011002VO();
					//저장 사용자아이디 지정
					vo.setUSERID(userId);
//					vo.setUSERIDSESSION(sessionUserId);
					
					//각 값들 배열에서 지정
					vo.setYEARMONTH(yearmonthArr[cnt]);
					vo.setPAYDATE(paydateArr[cnt]);
					vo.setBRANCHCODE(branchcodeArr[cnt]);
					vo.setDEPTCODE(deptcodeArr[cnt]);
					vo.setGRADE(gradeArr[cnt]);
					vo.setDUTY(dutyArr[cnt]);
					vo.setINSACODE(insacodeArr[cnt]);
					vo.setKNAME(knameArr[cnt]);
					vo.setBASICAMT(basicamtArr[cnt]);
					vo.setACTAMT(actamtArr[cnt]);
					vo.setDAILYAMT(dailyamtArr[cnt]);
					vo.setPRIZEAMT(prizeamtArr[cnt]);
					vo.setTOTALAMT(totalamtArr[cnt]);
					vo.setTAXGUBUN(taxgubunArr[cnt]);
					vo.setTAXINCOME(taxincomeArr[cnt]);
					vo.setTAXLOCAL(taxlocalArr[cnt]);
					vo.setSUPPLYTAX(supplytaxArr[cnt]);
					vo.setDEDUCTAMT(deductamtArr[cnt]);
					vo.setBANKID(bankidArr[cnt]);
					vo.setACCTNO(acctnoArr[cnt]);
					vo.setACCTOWNER(acctownerArr[cnt]);
					
					chkFlag = EP011002Dao.insertEnaMonthPayMst(vo);
					
					if (chkFlag = false) {
						break;
					} else {
						cnt++;
						chkFlag = true;
					}
				}
			
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	
	}
	
	public int updateEnaMonthPayMst(EP011002VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = EP011002Dao.updateEnaMonthPayMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}
	
	public boolean deleteEnaMonthPayMstAll(EP011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011002Dao.deleteEnaMonthPayMstAll(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
		
	}

	public boolean deleteEnaMonthPayMst(EP011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011002Dao.deleteEnaMonthPayMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
		
	}	
	
}
