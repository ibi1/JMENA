package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Vo.SY021001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY021001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY021001.";

	public List<SY021001VO> selectListEnaCompanyMst(SY021001VO vo) throws DataAccessException {
		List<SY021001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaCompanyMst", vo);
		
		return lst;
	}
	
	
	public int updateEnaCompanyMst(SY021001VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaCompanyMst", vo);
		
		return updateCnt;
	}
	
	public int insertEnaCompanyMst(SY021001VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaCompanyMst", vo);
		
		return insertCnt;
	}
	
}
