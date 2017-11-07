package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Dao.SY021002Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY021002Biz {
	
	@Resource(name = "SY021002Dao")
	private SY021002Dao SY021002Dao;

	public SY021002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY021002VO> selectListEnaBranchMst(SY021002VO vo) throws Exception {
		List<SY021002VO> lst = null;

		try {
			lst = SY021002Dao.selectListEnaBranchMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SY021002VO> selectListEnaDeptMst(SY021002VO vo) throws Exception {
		List<SY021002VO> lst = null;

		try {
			lst = SY021002Dao.selectListEnaDeptMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SY021002VO> chkEnaDeptMst(SY021002VO vo) throws Exception {
		List<SY021002VO> lst = null;

		try {
			lst = SY021002Dao.chkEnaDeptMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean updateEnaBranchMst(SY021002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY021002Dao.updateEnaBranchMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean insertEnaBranchMst(SY021002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY021002Dao.insertEnaBranchMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}

	public int saveEnaDeptMst(SY021002VO vo) throws Exception {
		int insertCnt = 0;

		try {
			insertCnt = SY021002Dao.saveEnaDeptMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
}
