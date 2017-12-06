package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011003VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA011003Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA011003.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<SA011003VO> selectListEnaIpgumMst(SA011003VO vo) throws DataAccessException {
		List<SA011003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaIpgumMst", vo);
		
		return lst;
	}

	public List<SA011003VO> selectListEnaIpgumDtl(SA011003VO vo) throws DataAccessException {
		List<SA011003VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaIpgumDtl", vo);
		
		return lst;
	}
	
	public int selectOneEnaIpgumMst(SA011003VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectOneEnaIpgumMst", vo);
			
		return cnt;
	}

	public int selectOneEnaIpgumDtl(SA011003VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectOneEnaIpgumDtl", vo);
			
		return cnt;
	}
	
	public int insertEnaIpgumMst(SA011003VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaIpgumMst", vo);
		
		return insertCnt;
	}	
	
	public int updateEnaIpgumMst(SA011003VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaIpgumMst", vo);
		
		return updateCnt;
	}	

	public int insertEnaIpgumDtl(SA011003VO vo) throws DataAccessException {
		int insertCnt = 0;
		
		insertCnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertEnaIpgumDtl", vo);
		
		return insertCnt;
	}	
	
	public int updateEnaIpgumDtl(SA011003VO vo) throws DataAccessException {
		int updateCnt = 0;
		
		updateCnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaIpgumDtl", vo);
		
		return updateCnt;
	}	

	public boolean deleteEnaIpgumMst(SA011003VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaIpgumMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}

	public boolean deleteEnaIpgumDtl(SA011003VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaIpgumDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}

	public boolean deleteEnaIpgumDtl2(SA011003VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaIpgumDtl2", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011003VO> selectListEanSalePopup(SA011003VO vo) throws DataAccessException {
		List<SA011003VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEanSalePopup", vo);
		
		return lst;
	}
	
}
