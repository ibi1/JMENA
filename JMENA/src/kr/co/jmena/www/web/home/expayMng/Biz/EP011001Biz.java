package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.expayMng.Dao.EP011001Dao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;


@Service
public class EP011001Biz {
	
	@Resource(name = "EP011001Dao")
	private EP011001Dao EP011001Dao;

	public EP011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP011001VO> selectListEnaSudangMst(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;

		try {
			lst = EP011001Dao.selectListEnaSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<EP011001VO> selectEnaSudangMstList(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;
		
		try {
			lst = EP011001Dao.selectEnaSudangMstList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<EP011001VO> selectEnaSudangMstInsert(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;
		
		try {
			lst = EP011001Dao.selectEnaSudangMstInsert(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public int selectDataEnaSudangMst(EP011001VO vo) throws Exception {
		int cnt = 0;
		
		try {
			cnt = EP011001Dao.selectDataEnaSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return cnt;
	}	
	
	@SuppressWarnings("unused")
	public boolean updateEnaSudangMst(HttpServletRequest request) throws Exception {
		boolean chkFlag = false;
		EP011001VO delVo = new EP011001VO();
		try {
			String userId = request.getParameter("USERID");
			String sysId = request.getParameter("SYSID");
			String menuId = request.getParameter("MENUID");
			

			HttpSession session = null;
			session = request.getSession(false);
			String sessionUserId = (String)session.getAttribute("userId");
			

				
				//Insert Array
			logger.debug("[yearmonthArr.length]");
			
			String insacodeArr[] = request.getParameterValues("insacodeArr[]");
//			String branchcodeArr[] = request.getParameterValues("branchcodeArr[]");
//			String deptcodeArr[] = request.getParameterValues("deptcodeArr[]");
//			String gradeArr[] = request.getParameterValues("gradeArr[]");
//			String dutyArr[] = request.getParameterValues("dutyArr[]");
//			String paydateArr[] = request.getParameterValues("paydateArr[]");
			String sudangrateArr[] = request.getParameterValues("sudangrateArr[]");
			String addrateArr[] = request.getParameterValues("addrateArr[]");
			String payamtArr[] = request.getParameterValues("payamtArr[]");
			String taxgubunArr[] = request.getParameterValues("taxgubunArr[]");
			String taxincomeArr[] = request.getParameterValues("taxincomeArr[]");
			String taxlocalArr[] = request.getParameterValues("taxlocalArr[]");
			String supplytaxArr[] = request.getParameterValues("supplytaxArr[]");
			String deductamtArr[] = request.getParameterValues("deductamtArr[]");
			String remarkArr[] = request.getParameterValues("remarkArr[]");
			String SALEID = request.getParameter("SALEID");
			String PAYDATE = request.getParameter("PAYDATE");
			
			delVo.setSALEID(SALEID);
			EP011001Dao.deleteEnaSudangMst(delVo);
			EP011001Dao.deleteEnaSudangMst(delVo);
				logger.debug("[yearmonthArr.length]" + insacodeArr);
				
				
				int cnt = 0;
				for (String tmp : insacodeArr) {
					EP011001VO vo = new EP011001VO();
					//저장 사용자아이디 지정
					vo.setUSERID(sessionUserId);
//					vo.setUSERIDSESSION(sessionUserId);
					
					//각 값들 배열에서 지정
					vo.setSALEID(SALEID);
					vo.setPAYDATE(PAYDATE);
					vo.setINSACODE(insacodeArr[cnt]);
//					vo.setBRANCHCODE(branchcodeArr[cnt]);
//					vo.setDEPTCODE(deptcodeArr[cnt]);
//					vo.setGRADE(gradeArr[cnt]);
//					vo.setDUTY(dutyArr[cnt]);
					vo.setSUDANGRATE(sudangrateArr[cnt]);
					vo.setADDRATE(addrateArr[cnt]);
					vo.setPAYAMT(payamtArr[cnt]);
					vo.setTAXGUBUN(taxgubunArr[cnt]);
					vo.setTAXINCOME(taxincomeArr[cnt]);
					vo.setTAXLOCAL(taxlocalArr[cnt]);
					vo.setSUPPLYTAX(supplytaxArr[cnt]);
					vo.setDEDUCTAMT(deductamtArr[cnt]);
					vo.setREMARK(remarkArr[cnt]);					
					
					chkFlag = EP011001Dao.insertEnaSudangMst(vo);
					
					if (chkFlag = false) {
						break;
					} else {
						cnt++;
						chkFlag = true;
					}
				}
			
		} catch ( Exception e ) {
			throw e;
		}
		
		return chkFlag;
	}
	
	
//	public int updateEnaSudangMst(EP011001VO vo) throws Exception {
//		int updateCnt = 0;
//
//		try {
//			updateCnt = EP011001Dao.updateEnaSudangMst(vo);
//		} catch ( Exception e ) {
//			throw e;
//		}
//		
//		return updateCnt;
//	}	
//	
	public boolean deleteEnaSudangMst(EP011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011001Dao.deleteEnaSudangMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}	
	
	public boolean deleteEnaSudangMstPTb(EP011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011001Dao.deleteEnaSudangMstPTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}		
	
	
	public List<EP011001VO> selectListEnaSudangPTb(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;

		try {
			lst = EP011001Dao.selectListEnaSudangPTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}	
	
	
	public int insertEnaSudangPTb(EP011001VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = EP011001Dao.insertEnaSudangPTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	
	public int updateEnaSudangPTb(EP011001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = EP011001Dao.updateEnaSudangPTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}	
	
	public boolean deleteEnaSudangPTb(EP011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011001Dao.deleteEnaSudangPTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}	
	
	public List<EP011001VO> selectListEnaSaleSudangList(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;

		try {
			lst = EP011001Dao.selectListEnaSaleSudangList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}		
	

	
}
