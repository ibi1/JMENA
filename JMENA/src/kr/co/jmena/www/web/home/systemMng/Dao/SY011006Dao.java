package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011006VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY011006Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY011006.";

	public List<SY011006VO> selectListBankMst(SY011006VO vo) throws DataAccessException {
		List<SY011006VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListBankMst", vo);
		
		return lst;
	}
	
	public boolean selectDataBankMst(SY011006VO vo) throws DataAccessException {
		boolean chkFlag = true;
		
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectDataBankMst", vo);
		
		if (cnt > 0) chkFlag = false;
		return chkFlag;
	}
	
	public boolean insertDataBankMst(SY011006VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataBankMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataBankMst(SY011006VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataBankMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
}
