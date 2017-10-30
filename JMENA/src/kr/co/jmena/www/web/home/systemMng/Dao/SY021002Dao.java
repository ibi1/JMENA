package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY021002Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY021002.";

	public List<SY021002VO> selectListEnaBranchMst(SY021002VO vo) throws DataAccessException {
		List<SY021002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaBranchMst", vo);
		
		return lst;
	}

	public List<SY021002VO> selectListEnaDeptMst(SY021002VO vo) throws DataAccessException {
		List<SY021002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaDeptMst", vo);
		
		return lst;
	}
	
	public List<SY021002VO> chkEnaDeptMst(SY021002VO vo) throws DataAccessException {
		List<SY021002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "chkEnaDeptMst", vo);
		
		return lst;
	}
	
	public int updateEnaBranchMst(SY021002VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaBranchMst", vo);
		
		return updateCnt;
	}
	
	public int insertEnaBranchMst(SY021002VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaBranchMst", vo);
		
		return insertCnt;
	}

	public int saveEnaDeptMst(SY021002VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "saveEnaDeptMst", vo);
		
		return insertCnt;
	}
	
}
