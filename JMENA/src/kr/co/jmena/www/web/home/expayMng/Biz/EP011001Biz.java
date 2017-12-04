package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

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
	
	public int selectDataEnaSudangMst(EP011001VO vo) throws Exception {
		int cnt = 0;
		
		try {
			cnt = EP011001Dao.selectDataEnaSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return cnt;
	}	
	
	public int insertEnaSudangMst(EP011001VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = EP011001Dao.insertEnaSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	
	public int updateEnaSudangMst(EP011001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = EP011001Dao.updateEnaSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}	
	
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
