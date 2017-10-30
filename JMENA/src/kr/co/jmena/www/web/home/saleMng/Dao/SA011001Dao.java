package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA011001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA011001.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA011001VO> selectListEnaSaleMst(SA011001VO vo) throws DataAccessException {
		List<SA011001VO> lst = null;
		
		//lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSaleMst", vo);
		
		return lst;
	}
	
}
