package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012007VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012007Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012007.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012007VO> selectListSA012007(SA012007VO vo) throws DataAccessException {
		List<SA012007VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012007", vo);
		
		return lst;
	}

	public List<SA012007VO> selectListSA012007_1(SA012007VO vo) throws DataAccessException {
		List<SA012007VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012007_1", vo);
		
		return lst;
	}

	public List<SA012007VO> selectListSA012007_2(SA012007VO vo) throws DataAccessException {
		List<SA012007VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012007_2", vo);
		
		return lst;
	}
	
}
