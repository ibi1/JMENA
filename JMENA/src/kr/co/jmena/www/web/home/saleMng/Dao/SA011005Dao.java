package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011005VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA011005Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA011005.";
	
	public int selectDataSaleHistoryTb004(SA011005VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectDataSaleHistoryTb004", vo);

		return cnt;
	}
	
	public List<SA011005VO> selectListEanSaleMst(SA011005VO vo) throws DataAccessException {
		List<SA011005VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEanSaleMst", vo);
		
		return lst;
	}
	
	public boolean insertDataSaleMst(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		String SALEID = (String) getSqlMapClientTemplate().insert(NAME_SPACE + "insertDataSaleMst", vo);
		
		vo.setSALEID(SALEID);
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataSaleDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataSaleMst(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		int cnt = 0;
		
		if ((int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataSaleMst", vo) > 0) {
			cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataSaleDtl", vo);
		}
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public int selectAllSaleHistoryTb(SA011005VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectAllSaleHistoryTb", vo);

		return cnt;
	}
	
	public boolean deleteAllSaleHistoryTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteAllSaleHistoryTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public int selectAllJointnameTb(SA011005VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectAllJointnameTb", vo);

		return cnt;
	}
	
	public boolean deleteAllJointnameTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteAllJointnameTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public int selectAllIpgumScheduleTb(SA011005VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectAllIpgumScheduleTb", vo);

		return cnt;
	}
	
	public boolean deleteAllIpgumScheduleTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteAllIpgumScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataSaleDtl(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataSaleDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataSaleMst(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataSaleMst", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEnaIpgumScheduleTb(SA011005VO vo) throws DataAccessException {
		List<SA011005VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaIpgumScheduleTb", vo);
		
		return lst;
	}
	
	public boolean insertDataEnaIpgumScheduleTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataEnaIpgumScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataEnaIpgumScheduleTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataEnaIpgumScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataEnaIpgumScheduleTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataEnaIpgumScheduleTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEnaJointNameTb(SA011005VO vo) throws DataAccessException {
		List<SA011005VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaJointNameTb", vo);
		
		return lst;
	}
	
	public boolean updateDataJoint(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataJoint", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean insertDataEnaJointNameTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataEnaJointNameTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataEnaJointNameTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataEnaJointNameTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataEnaJointNameTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataEnaJointNameTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEnaSaleHistoryTb(SA011005VO vo) throws DataAccessException {
		List<SA011005VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaSaleHistoryTb", vo);
		
		return lst;
	}
	
	public boolean insertDataEnaSaleHistoryTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataEnaSaleHistoryTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataEnaSaleHistoryTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataEnaSaleHistoryTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataEnaSaleHistoryTb(SA011005VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataEnaSaleHistoryTb", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEanSaleMstPopup(SA011005VO vo) throws DataAccessException {
		List<SA011005VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEanSaleMstPopup", vo);
		
		return lst;
	}
	
	public List<MM011001VO> selectListEnaBuyMstPopup(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaBuyMstPopup", vo);
		
		return lst;
	}
	
	public List<SA011005VO> selectHRInsamstBranchCode(SA011005VO vo) throws DataAccessException {
		List<SA011005VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectHRInsamstBranchCode", vo);
		
		return lst;
	}
	
	/**
	 * (신)매출관리 > 입금스케줄관리(탭) > 입금처리(팝업) > 매출 건별 입금처리 현황 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectListIpgumDtl(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListIpgumDtl", param);
		
		return lst;
	}
	
	/**
	 * (신)매출관리 > 입금스케줄관리(탭) > 입금처리(팝업) > 입금현황 : 조회
	 * @return
	 * @throws DataAccessException
	 */
	public List<Map<String, Object>> selectListIpgumMst(Map<String, Object> param) throws DataAccessException {
		List<Map<String, Object>> lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListIpgumMst", param);
		
		return lst;
	}
	
	/**
	 * (신)매출관리 > 입금스케줄관리(탭) > 입금처리(팝업) > 입금처리 : 추가
	 * @return
	 * @throws DataAccessException
	 */
	public int insertIpgumDtl(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "insertIpgumDtl", param);
		
		return cnt;
	}
	
	/**
	 * (신)매출관리 > 입금스케줄관리(탭) > 입금처리(팝업) > 매출 건별 입금처리 현황 : 취소
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteIpgumDtl(Map<String, Object> param) throws DataAccessException {
		int cnt = 0;
		
		cnt = getSqlMapClientTemplate().update(NAME_SPACE + "deleteIpgumDtl", param);
		
		return cnt;
	}	
}
