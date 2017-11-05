package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.systemMng.Vo.SY011003VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011004VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY011004Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY011004.";

	public List<SY011004VO> selectListUserMst4(SY011004VO vo) throws DataAccessException {
		List<SY011004VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListUserMst4", vo);
		
		return lst;
	}
	
	public List<SY011004VO> selectListUserPgmAuthTb(SY011004VO vo) throws DataAccessException {
		List<SY011004VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListUserPgmAuthTb", vo);
		
		return lst;
	}
	
	public int selectIsExistDataUserPgmAuthTb(SY011004VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectIsExistDataUserPgmAuthTb", vo);
		
		return cnt;
	}
	
	public int deleteDataUserPgmAuthTb(SY011004VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataUserPgmAuthTb", vo);
		
		return cnt;
	}
	
	public boolean insertDataUserPgmAuthTb(SY011004VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataUserPgmAuthTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
}
