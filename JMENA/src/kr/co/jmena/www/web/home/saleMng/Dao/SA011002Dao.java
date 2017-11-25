package kr.co.jmena.www.web.home.saleMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011002VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SA011002Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "SA011002.";

	public List<SA011002VO> selectListEanSaleMstBDtl(SA011002VO vo) throws DataAccessException {
		List<SA011002VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEanSaleMstBDtl", vo);
		
		return lst;
	}
	
	public boolean insertDataSaleMstBDtl(SA011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		String SALEID = (String) getSqlMapClientTemplate().insert(NAME_SPACE + "insertDataSaleMstBDtl", vo);
		
		vo.setSALEID(SALEID);
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataSaleBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataSaleMstBDtl(SA011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		int cnt = 0;
		
		if ((int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataSaleMstBDtl", vo) > 0) {
			cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataSaleBDtl", vo);
		}
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public int selectAllJointnameTbBDtl(SA011002VO vo) throws DataAccessException {
		int cnt = (int)getSqlMapClientTemplate().queryForObject(NAME_SPACE + "selectAllJointnameTbBDtl", vo);

		return cnt;
	}
	
	public boolean deleteAllJointnameTbBDtl(SA011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteAllJointnameTbBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataSalebDtl(SA011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataSalebDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataSaleMstBDtl(SA011002VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataSaleMstBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011001VO> selectListEnaJointNameTbBDtl(SA011001VO vo) throws DataAccessException {
		List<SA011001VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaJointNameTbBDtl", vo);
		
		return lst;
	}
	
	public boolean updateDataJointBDtl(SA011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataJointBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean insertDataEnaJointNameTbBDtl(SA011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "insertDataEnaJointNameTbBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean updateDataEnaJointNameTbBDtl(SA011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().update(NAME_SPACE + "updateDataEnaJointNameTbBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public boolean deleteDataEnaJointNameTbBDtl(SA011001VO vo) throws DataAccessException {
		boolean chkFlag = false;
		
		int cnt = (int)getSqlMapClientTemplate().delete(NAME_SPACE + "deleteDataEnaJointNameTbBDtl", vo);
		
		if (cnt > 0) chkFlag = true;
		return chkFlag;
	}
	
	public List<SA011002VO> selectListEanSaleMstBDtlPopup(SA011002VO vo) throws DataAccessException {
		List<SA011002VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEanSaleMstBDtlPopup", vo);
		
		return lst;
	}
	
	public List<MM011001VO> selectListEnaBuyMstBDtlPopup(MM011001VO vo) throws DataAccessException {
		List<MM011001VO> lst = null;	
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListEnaBuyMstBDtlPopup", vo);
		
		return lst;
	}
}
