package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012005VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012005Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012005.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012005VO> selectListSA012005(SA012005VO vo) throws DataAccessException {
		List<SA012005VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012005", vo);
		
		return lst;
	}

	public List<SA012005VO> selectListSA012005_2(SA012005VO vo) throws DataAccessException {
		List<SA012005VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012005_2", vo);
		
		return lst;
	}
	
}
