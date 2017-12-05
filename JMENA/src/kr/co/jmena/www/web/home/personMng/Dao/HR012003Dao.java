package kr.co.jmena.www.web.home.personMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.codeCom.Vo.BankVO;
import kr.co.jmena.www.web.home.personMng.Vo.HR012003VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class HR012003Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "HR012003.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<HR012003VO> selectListHR012003(HR012003VO vo) throws DataAccessException {
		List<HR012003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012003", vo);
		
		return lst;
	}

	public List<HR012003VO> selectListHR012003_2(HR012003VO vo) throws DataAccessException {
		List<HR012003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012003_2", vo);
		
		return lst;
	}

	public List<HR012003VO> selectpersonCnt(HR012003VO vo) throws DataAccessException {
		List<HR012003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectpersonCnt", vo);
		
		return lst;
	}
	
	
}
