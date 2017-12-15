package kr.co.jmena.www.web.codeCom.Dao;

import java.util.List;

import kr.co.jmena.www.web.codeCom.Vo.BankVO;
import kr.co.jmena.www.web.codeCom.Vo.CityVO;
import kr.co.jmena.www.web.codeCom.Vo.DcodeVO;
import kr.co.jmena.www.web.codeCom.Vo.UserVO;
import kr.co.jmena.www.web.codeCom.Vo.BranchVO;
import kr.co.jmena.www.web.codeCom.Vo.DeptVO;
import kr.co.jmena.www.web.codeCom.Vo.InsaVO;


import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class CodeComDao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "CODECOM.";

	public List<BankVO> selectBankList() throws DataAccessException {
		List<BankVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectBankList");
		
		return lst;
	}
	
	public List<DcodeVO> selectDcodeList(DcodeVO vo) throws DataAccessException {
		List<DcodeVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectDcodeList", vo);
		
		return lst;
	}
	
	public List<UserVO> selectUserList() throws DataAccessException {
		List<UserVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectUserList");
		
		return lst;
	}
	
	public List<CityVO> selectCityMstList() throws DataAccessException {
		List<CityVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectCityMstList");
		
		return lst;
	}
	
	public List<CityVO> selectCityDtlList(CityVO vo) throws DataAccessException {
		List<CityVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectCityDtlList", vo);
		
		return lst;
	}
	
	public List<BranchVO> selectBranchMstList(BranchVO vo) throws DataAccessException {
		List<BranchVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectBranchMstList", vo);
		
		return lst;
	}

	public List<DeptVO> selectDeptMstList(DeptVO vo) throws DataAccessException {
		List<DeptVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectDeptMstList", vo);
		
		return lst;
	}
	public List<InsaVO> selectInsaMstList(InsaVO vo) throws DataAccessException {
		List<InsaVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectInsaMstList", vo);
		
		return lst;
	}
	
}
