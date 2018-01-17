package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA011006Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA011006.";
	
	/**
	 * 해약관리 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectListSaleMst(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListSaleMst", param);
		
		return lst;
	}
	
	/**
	 * 해약관리 : 추가
	 * @return
	 * @throws DataAccessException
	 */
	public int insertRefundTb(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertRefundTb", param);
		
		return cnt;
	}
	
	/**
	 * 해약관리 : 추가 (입금전액 대체처리)
	 * @return
	 * @throws DataAccessException
	 */
	public int insertRefundTbExport(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertRefundTbExport", param);
		
		return cnt;
	}

	/**
	 * 해약관리 : 수정
	 * @return
	 * @throws DataAccessException
	 */
	public int updateRefundTb(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateRefundTb", param);
		
		return cnt;
	}

	/**
	 * 해약관리 : 삭제
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteRefundTb(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "deleteRefundTb", param);
		
		return cnt;
	}
	
	/**
	 * 해약관리 : 처리 및 취소 (입금내역 저장)
	 * @return
	 * @throws DataAccessException
	 */
	public String insertIpgumMst(Map<String, Object> param) throws DataAccessException {
		String sKey = "";
		
		sKey = (String) getSqlMapClientTemplate().insert(NAME_SPACE + "insertIpgumMst", param);
		
		return sKey;
	}
	
	/**
	 * 해약관리 : 처리 및 취소 (환불내역 변경)
	 * @return
	 * @throws DataAccessException
	 */
	public int updateRefundTbExport(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "updateRefundTbExport", param);
		
		return cnt;
	}
	
	/**
	 * 해약관리 : 처리 및 취소 (입금처리내역 조회)
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectOneIpgumDtl(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectOneIpgumDtl", param);
		
		return lst;
	}

	/**
	 * 해약관리 : 처리 및 취소 (입금내역 삭제)
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteIpgumMst(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().delete(NAME_SPACE + "deleteIpgumMst", param);
		
		return cnt;
	}
}
