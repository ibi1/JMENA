package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021003VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY021003Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY021003.";

	public List<SY021003VO> selectListEnaCityMst(SY021003VO vo) throws DataAccessException {
		List<SY021003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaCityMst", vo);
		
		return lst;
	}

	public List<SY021003VO> selectListEnaCityDtl(SY021003VO vo) throws DataAccessException {
		List<SY021003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaCityDtl", vo);
		
		return lst;
	}
	
	
	public boolean insertEnaCityMst(SY021003VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaCityMst", vo);
		
		if (cnt > 0) chkFlag = true;
		
		return chkFlag;
	}
	
	public boolean updateEnaCityMst(SY021003VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaCityMst", vo);
		
		if (cnt > 0) chkFlag = true;
		
		return chkFlag;
	}
	
}
