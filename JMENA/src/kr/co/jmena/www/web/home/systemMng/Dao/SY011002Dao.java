package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.systemMng.Vo.SY011002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY011002Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY011002.";

	public List<SY011002VO> selectListMenuPgmTb(SY011002VO vo) throws DataAccessException {
		List<SY011002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListMenuPgmTb", vo);
		
		return lst;
	}
	
	public boolean insertDataPgmTb(SY011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataPgmTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataPgmTb(SY011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataPgmTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
}
