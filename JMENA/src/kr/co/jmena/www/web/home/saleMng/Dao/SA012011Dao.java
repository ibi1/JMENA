package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012011VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012011Dao extends SqlMapClientDaoSupport{
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012011.";
	
	/**
	 * 매출현황 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012011VO> selectListSA012011(SA012011VO vo) throws DataAccessException {
		List<SA012011VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012011", vo);
		
		return lst;
	}
}
