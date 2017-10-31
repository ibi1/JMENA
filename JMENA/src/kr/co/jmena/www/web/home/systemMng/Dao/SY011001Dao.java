package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY011001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY011001.";

	public List<SY011001VO> selectListSysMst() throws DataAccessException {
		List<SY011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSysMst");
		
		return lst;
	}
	
	public List<SY011001VO> selectListSysDtl(SY011001VO vo) throws DataAccessException {
		List<SY011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSysDtl", vo);
		
		return lst;
	}
	
	public boolean selectCheckSysId(SY011001VO vo)  throws DataAccessException {
		boolean chkFlag = true;
		
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectCheckSysId", vo);
		
		if (cnt > 0) chkFlag = false;
		
		return chkFlag;
	}
	
	public boolean insertDataSysMst(SY011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataSysMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
}
