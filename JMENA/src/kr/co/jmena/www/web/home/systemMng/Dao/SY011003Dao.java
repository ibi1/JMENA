package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.systemMng.Vo.SY011003VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SY011003Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SY011003.";

	public List<SY011003VO> selectListUserMst(SY011003VO vo) throws DataAccessException {
		List<SY011003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListUserMst", vo);
		
		return lst;
	}
	
	public List<SY011003VO> selectListUserSysTb(SY011003VO vo) throws DataAccessException {
		List<SY011003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListUserSysTb", vo);
		
		return lst;
	}
}
