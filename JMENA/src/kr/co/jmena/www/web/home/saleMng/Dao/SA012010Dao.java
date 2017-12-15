package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012010VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012010Dao extends SqlMapClientDaoSupport{
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012010.";

	/**
	 * 위탁매출 - 위탁수수료 현황
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012010VO> selectListSA012010(SA012010VO vo) throws DataAccessException {
		List<SA012010VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012010", vo);
		
		return lst;
	}	
	
}
