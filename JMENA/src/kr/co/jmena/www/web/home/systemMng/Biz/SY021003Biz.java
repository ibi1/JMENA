package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Dao.SY021003Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY021003Biz {
	
	@Resource(name = "SY021003Dao")
	private SY021003Dao SY021003Dao;

	public SY021003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY021003VO> selectListEnaCityMst(SY021003VO vo) throws Exception {
		List<SY021003VO> lst = null;

		try {
			lst = SY021003Dao.selectListEnaCityMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SY021003VO> selectListEnaCityDtl(SY021003VO vo) throws Exception {
		List<SY021003VO> lst = null;

		try {
			lst = SY021003Dao.selectListEnaCityDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertEnaCityMst(SY021003VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY021003Dao.insertEnaCityMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateEnaCityMst(SY021003VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY021003Dao.updateEnaCityMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
}
