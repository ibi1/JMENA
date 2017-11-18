package kr.co.jmena.www.web.home.expayMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;

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

	
	
	public int selectDataEnaSudangMst(EP011001VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectDataEnaSudangMst", vo);
			
		return cnt;
	}
	
	
	public int insertEnaSudangMst(EP011001VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaSudangMst", vo);
		
		return insertCnt;
	}	
	
	public int updateEnaSudangMst(EP011001VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaSudangMst", vo);
		
		return updateCnt;
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
	
		
}
