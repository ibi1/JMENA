package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011004Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011003VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011004VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011004Biz {
	
	@Resource(name = "SY011004Dao")
	private SY011004Dao SY011004Dao;

	public SY011004Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011004VO> selectListUserMst4(SY011004VO vo) throws Exception {
		List<SY011004VO> lst = null;

		try {
			lst = SY011004Dao.selectListUserMst4(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SY011004VO> selectListUserPgmAuthTb(SY011004VO vo) throws Exception {
		List<SY011004VO> lst = null;

		try {
			lst = SY011004Dao.selectListUserPgmAuthTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataUserPgmAuthTb(HttpServletRequest request) throws Exception {
		boolean chkFlag = false;
		SY011004VO delVo = new SY011004VO();
		
		try {
			String userId = request.getParameter("USERID");
			String sysId = request.getParameter("SYSID");
			String menuId = request.getParameter("MENUID");
			
			delVo.setUSERID(userId);
			delVo.setSYSID(sysId);
			delVo.setMENUID(menuId);
			
			logger.debug("[USERID]" + delVo.getUSERID());
			logger.debug("[SYSID]" + delVo.getSYSID());
			logger.debug("[MENUID]" + delVo.getMENUID());

			HttpSession session = null;
			session = request.getSession(false);
			String sessionUserId = (String)session.getAttribute("userId");
			
			int rCnt = 0;
			//우선 권한 테이블에 데이터가 있는지 확인 후 있으면 Delete 후 저장
			if (SY011004Dao.selectIsExistDataUserPgmAuthTb(delVo) > 0) {
				rCnt = SY011004Dao.deleteDataUserPgmAuthTb(delVo);
			} else { //기존 데이터 없음
				rCnt = 1;
			}
			
			if (rCnt > 0) {
				//Insert Array
				String pgmIdArr[] = request.getParameterValues("pgmIdArr[]");
				String sysIdArr[] = request.getParameterValues("sysIdArr[]");
				String menuIdArr[] = request.getParameterValues("menuIdArr[]");
				String authSArr[] = request.getParameterValues("authSArr[]");
				String authIArr[] = request.getParameterValues("authIArr[]");
				String authUArr[] = request.getParameterValues("authUArr[]");
				String authDArr[] = request.getParameterValues("authDArr[]");
				String authPArr[] = request.getParameterValues("authPArr[]");
				
				logger.debug("[pgmIdArr.length]" + pgmIdArr.length);
				
				int cnt = 0;
				for (String pgmId : pgmIdArr) {
					SY011004VO upVo = new SY011004VO();
					//저장 사용자아이디 지정
					upVo.setUSERID(userId);
					upVo.setUSERIDSESSION(sessionUserId);
					
					//각 값들 배열에서 지정
					upVo.setPGMID(pgmId);
					upVo.setSYSID(sysIdArr[cnt]);
					upVo.setMENUID(menuIdArr[cnt]);
					upVo.setAUTH_S(authSArr[cnt]);
					upVo.setAUTH_I(authIArr[cnt]);
					upVo.setAUTH_U(authUArr[cnt]);
					upVo.setAUTH_D(authDArr[cnt]);
					upVo.setAUTH_P(authPArr[cnt]);
					
					chkFlag = SY011004Dao.insertDataUserPgmAuthTb(upVo);
					
					if (chkFlag = false) {
						break;
					} else {
						cnt++;
						chkFlag = true;
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
}
