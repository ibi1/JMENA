package kr.co.jmena.www.web.home.buyingMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM012002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class MM012002Dao extends SqlMapClientDaoSupport{
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "MM012002.";
	
	/**
	 * 매입현황
	 * @return
	 * @throws DataAccessException
	 */	
	public List<MM012002VO> selectListBuyMst(MM012002VO vo) throws DataAccessException {
		List<MM012002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListBuyMst", vo);
		
		return lst;
	}
}
