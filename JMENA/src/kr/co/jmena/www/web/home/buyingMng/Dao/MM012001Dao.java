package kr.co.jmena.www.web.home.buyingMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM012001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class MM012001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "MM012001.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM012001VO> selectListMM012001(MM012001VO vo) throws DataAccessException {
		List<MM012001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListMM012001", vo);
		
		return lst;
	}

	public List<MM012001VO> selectListMM012001_1(MM012001VO vo) throws DataAccessException {
		List<MM012001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListMM012001_1", vo);
		
		return lst;
	}
	
}
