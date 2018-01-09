package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA011004Dao extends SqlMapClientDaoSupport{
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA011004.";
	
	/**
	 * (신)입금관리 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectListIpgumMst(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListIpgumMst", param);
		
		return lst;
	}
	
	/**
	 * (신)입금관리 > 입금목록(팝업) : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectPopListIpgumMst(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectPopListIpgumMst", param);
		
		return lst;
	}	
	
	/**
	 * (신)입금관리 : 담당자 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectOneInsamst(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectOneInsamst", param);
		
		return lst;
	}
	
	/**
	 * (신)입금관리 : 추가
	 * @return
	 * @throws DataAccessException
	 */
	public String insertIpgumMst(Map<String, Object> param) throws DataAccessException {
		String sKey = "";
		
		sKey = (String) getSqlMapClientTemplate().insert(NAME_SPACE + "insertIpgumMst", param);
		
		return sKey;
	}
	
	/**
	 * (신)입금관리 : 수정
	 * @return
	 * @throws DataAccessException
	 */
	public int updateIpgumMst(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateIpgumMst", param);
		
		return cnt;
	}
	
	/**
	 * (신)입금관리 : 추가 (환불 입금번호 Update)
	 * @return
	 * @throws DataAccessException
	 */
	public int updateRefundIpgumMst(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateRefundIpgumMst", param);
		
		return cnt;
	}	
	
	/**
	 * (신)입금관리 : 삭제
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteIpgumMst(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "deleteIpgumMst", param);
		
		return cnt;
	}	
}
