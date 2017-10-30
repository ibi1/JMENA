package kr.co.jmena.www.web.home.buyingMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class MM011001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "MM011001.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM011001VO> selectListEnaBuyMst(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaBuyMst", vo);
		
		return lst;
	}

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM011001VO> selectListEnaPayScheduleTb(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaPayScheduleTb", vo);
		
		return lst;
	}

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM011001VO> selectListEnaSalesOpenTb(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSalesOpenTb", vo);
		
		return lst;
	}
	
}
