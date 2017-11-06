package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012008VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012008Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012008.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012008VO> selectListSA012008(SA012008VO vo) throws DataAccessException {
		List<SA012008VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012008", vo);
		
		return lst;
	}

	public List<SA012008VO> selectListSA012008_2(SA012008VO vo) throws DataAccessException {
		List<SA012008VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012008_2", vo);
		
		return lst;
	}
	
}
