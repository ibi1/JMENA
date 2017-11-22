package kr.co.jmena.www.web.home.expayMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.expayMng.Vo.EP011002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class EP011002Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "EP011002.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	@SuppressWarnings("unchecked")
	public List<EP011002VO> selectListEnaMonthPayMst(EP011002VO vo) throws DataAccessException {
		List<EP011002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaMonthPayMst", vo);
		
		return lst;
	}	
	
	@SuppressWarnings("unchecked")
	public List<EP011002VO> selectListEnaMonthPayMstCrt(EP011002VO vo) throws DataAccessException {
		List<EP011002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaMonthPayMstCrt", vo);
		
		return lst;
	}		
	
	public int insertEnaMonthPayMst(EP011002VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaMonthPayMst", vo);
		
		return insertCnt;
	}	

	public int updateEnaMonthPayMst(EP011002VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaMonthPayMst", vo);
		
		return updateCnt;
	}

	public boolean deleteEnaMonthPayMstAll(EP011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaMonthPayMstAll", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}	
	
	public boolean deleteEnaMonthPayMst(EP011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaMonthPayMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}		
	
}
