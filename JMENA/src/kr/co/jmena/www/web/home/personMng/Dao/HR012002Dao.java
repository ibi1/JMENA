package kr.co.jmena.www.web.home.personMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class HR012002Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "HR012002.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<HR012002VO> selectListHR012002(HR012002VO vo) throws DataAccessException {
		List<HR012002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012002", vo);
		
		return lst;
	}

	public List<HR012002VO> selectListHR012002_2(HR012002VO vo) throws DataAccessException {
		List<HR012002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012002_2", vo);
		
		return lst;
	}

	public List<HR012002VO> selectListHR012002_3(HR012002VO vo) throws DataAccessException {
		List<HR012002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012002_3", vo);
		
		return lst;
	}
	
}
