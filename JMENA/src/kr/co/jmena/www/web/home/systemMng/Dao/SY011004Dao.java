package kr.co.jmena.www.web.home.systemMng.Dao;

import java.util.List;

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
}
