package kr.co.jmena.www.web.home.expayMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class EP011001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "EP011001.";

	/**
	 * 수당관리
	 * @return
	 * @throws DataAccessException
	 */
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectListEnaSudangMst(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSudangMst", vo);
		
		return lst;
	}	
	
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectEnaSudangMstList(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectEnaSudangMstList", vo);
		
		return lst;
	}	
	
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectEnaSudangMstInsert(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectEnaSudangMstInsert", vo);
		
		return lst;
	}	
	
	public int selectDataEnaSudangMst(EP011001VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectDataEnaSudangMst", vo);
			
		return cnt;
	}
	
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectEnaSudangMstSheet(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectEnaSudangMstSheet", vo);
		
		return lst;
	}
	
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectEnaSudangMstSheetList(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectEnaSudangMstSheetList", vo);
		
		return lst;
	}
	
	public boolean insertEnaSudangMst(EP011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaSudangMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}	
	
	public int updateEnaSudangMst(EP011001VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaSudangMst", vo);
		
		return updateCnt;
	}	
	
	
	public boolean deleteEnaSudangMst(EP011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaSudangMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}		
	
	public boolean deleteEnaSudangMstPTb(EP011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaSudangMstPTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}		
	
	
	
	/**
	 * 신고인 관리
	 * @return
	 * @throws DataAccessException
	 */
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectListEnaSudangPTb(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSudangPTb", vo);
		
		return lst;
	}		
	
	public int insertEnaSudangPTb(EP011001VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaSudangPTb", vo);
		
		return insertCnt;
	}	
	
	public int updateEnaSudangPTb(EP011001VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaSudangPTb", vo);
		
		return updateCnt;
	}	
	
	public boolean deleteEnaSudangPTb(EP011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaSudangPTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}	
		
	
	
	/**
	 * 수당관리 팝업
	 * @return
	 * @throws DataAccessException
	 */
	@SuppressWarnings("unchecked")
	public List<EP011001VO> selectListEnaSaleSudangList(EP011001VO vo) throws DataAccessException {
		List<EP011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSaleSudangList", vo);
		
		return lst;
	}	
	
	@SuppressWarnings("unchecked")
	public List<HR011001VO> selectListEanHRInsaMstPopup(HR011001VO vo) throws DataAccessException {
		List<HR011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEanHRInsaMstPopup", vo);
		
		return lst;
	}	
	
	public boolean deleteDataEnaSudangMstPTbBottom(EP011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = 0;
		
		if ((int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectDataEnaSudangMstPTbBottom", vo) > 0) {
			cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataEnaSudangMstPTbBottom", vo);
		} else {
			cnt = 1;
		}
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataEnaSudangMstBottom(EP011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataEnaSudangMstBottom", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
		
}
