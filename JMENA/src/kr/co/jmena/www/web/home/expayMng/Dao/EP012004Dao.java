package kr.co.jmena.www.web.home.expayMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.expayMng.Vo.EP012004VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class EP012004Dao extends SqlMapClientDaoSupport{

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "EP012004.";
	
	/**
	 * 소득세 및 부가세신고 현황 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<EP012004VO> selectListEP012004(EP012004VO vo) throws DataAccessException {
		List<EP012004VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEP012004", vo);
		
		return lst;
	}
}
