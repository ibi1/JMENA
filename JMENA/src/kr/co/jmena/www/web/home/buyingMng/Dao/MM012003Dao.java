package kr.co.jmena.www.web.home.buyingMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM012003VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class MM012003Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "MM012003.";
	
	/**
	 * 계약현황 : 조회 (매입내역)
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM012003VO> selectListBuyMst(MM012003VO vo) throws DataAccessException {
		List<MM012003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListBuyMst", vo);
		
		return lst;
	}
	
	/**
	 * 계약현황 : 조회 (매출내역)
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM012003VO> selectListSaleMst(MM012003VO vo) throws DataAccessException {
		List<MM012003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSaleMst", vo);
		
		return lst;
	}	
}
