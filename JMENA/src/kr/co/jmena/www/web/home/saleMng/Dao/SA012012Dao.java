package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012012VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012012Dao extends SqlMapClientDaoSupport{
	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012012.";
	
	/**
	 * 등기현황 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012012VO> selectListSA012012(SA012012VO vo) throws DataAccessException {
		List<SA012012VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012012", vo);
		
		return lst;
	}
}
