package kr.co.jmena.www.web.home.buyingMng.Dao;

import java.util.List;
import java.util.Map;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class MM011001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "MM011001.";

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM011001VO> selectListEnaBuyMst(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaBuyMst", vo);
		
		return lst;
	}

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM011001VO> selectListEnaPayScheduleTb(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaPayScheduleTb", vo);
		
		return lst;
	}

	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MM011001VO> selectListEnaSalesOpenTb(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSalesOpenTb", vo);
		
		return lst;
	}
	
	public boolean insertDataBuyMst(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataBuyMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataBuyMst(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataBuyMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataPayScheduleTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataPayScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataSalesopenTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataSalesopenTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean insertDataPayScheduleTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataPayScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataPayScheduleTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataPayScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public int selectAllSalesopenTb(MM011001VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectAllSalesopenTb", vo);

		return cnt;
	}
	
	public boolean deleteAllSalesopenTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteAllSalesopenTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public int selectAllPayScheduleTb(MM011001VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectAllPayScheduleTb", vo);

		return cnt;
	}
	
	public boolean deleteAllPayScheduleTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteAllPayScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataBuyMst(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataBuyMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean insertDataSalesopenTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataSalesopenTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataSalesopenTb(MM011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataSalesopenTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<MM011001VO> selectSumSaleMst(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectSumSaleMst", vo);
		
		return lst;
	}
}
