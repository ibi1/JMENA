package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012004VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA012004Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA012004.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA012004VO> selectListSA012004(SA012004VO vo) throws DataAccessException {
		List<SA012004VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSA012004", vo);
		
		return lst;
	}
	
}
