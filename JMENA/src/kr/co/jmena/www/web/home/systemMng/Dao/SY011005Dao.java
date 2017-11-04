package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011005VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY011005Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY011005.";

	public List<SY011005VO> selectListCcodeMst(SY011005VO vo) throws DataAccessException {
		List<SY011005VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListCcodeMst", vo);
		
		return lst;
	}
	
	public List<SY011005VO> selectListCcodeDtl(SY011005VO vo) throws DataAccessException {
		List<SY011005VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListCcodeDtl", vo);
		
		return lst;
	}
	
	public boolean insertDataCcodeMst(SY011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataCcodeMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataCcodeMst(SY011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataCcodeMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean insertDataCcodeDtl(SY011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataCcodeDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataCcodeDtl(SY011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataCcodeDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
}
