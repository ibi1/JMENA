package kr.co.jmena.www.web.codeCom.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.codeCom.Dao.CodeComDao;
import kr.co.jmena.www.web.codeCom.Vo.BankVO;
import kr.co.jmena.www.web.codeCom.Vo.CityVO;
import kr.co.jmena.www.web.codeCom.Vo.DcodeVO;
import kr.co.jmena.www.web.codeCom.Vo.UserVO;
import kr.co.jmena.www.web.codeCom.Vo.BranchVO;
import kr.co.jmena.www.web.codeCom.Vo.DeptVO;
import kr.co.jmena.www.web.codeCom.Vo.InsaVO;


import kr.co.jmena.www.web.home.main.Dao.MainDao;
import kr.co.jmena.www.web.home.main.Vo.MainVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class CodeComBiz {
	
	@Resource(name = "codeComDao")
	private CodeComDao codeComDao;

	public CodeComBiz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<BankVO> selectBankList() throws Exception {
		List<BankVO> lst = null;

		try {
			lst = codeComDao.selectBankList();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<DcodeVO> selectDcodeList(DcodeVO vo) throws Exception {
		List<DcodeVO> lst = null;

		try {
			lst = codeComDao.selectDcodeList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<UserVO> selectUserList() throws Exception {
		List<UserVO> lst = null;

		try {
			lst = codeComDao.selectUserList();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<CityVO> selectCityMstList() throws Exception {
		List<CityVO> lst = null;

		try {
			lst = codeComDao.selectCityMstList();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<CityVO> selectCityDtlList(CityVO vo) throws Exception {
		List<CityVO> lst = null;

		try {
			lst = codeComDao.selectCityDtlList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<BranchVO> selectBranchMstList() throws Exception {
		List<BranchVO> lst = null;

		try {
			lst = codeComDao.selectBranchMstList();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	public List<DeptVO> selectDeptMstList(DeptVO vo) throws Exception {
		List<DeptVO> lst = null;

		try {
			lst = codeComDao.selectDeptMstList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	public List<InsaVO> selectInsaMstList(InsaVO vo) throws Exception {
		List<InsaVO> lst = null;

		try {
			lst = codeComDao.selectInsaMstList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
