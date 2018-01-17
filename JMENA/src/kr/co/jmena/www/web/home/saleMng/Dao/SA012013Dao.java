package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;
import java.util.Map;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012013VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012013Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012013.";
	
	/**
	 * 해약현황 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012013VO> selectListSaleMst(SA012013VO vo) throws DataAccessException {
		List<SA012013VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSaleMst", vo);
		
		return lst;
	}
}
