package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.systemMng.Dao.SY021001Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY021001Biz {
	
	@Resource(name = "SY021001Dao")
	private SY021001Dao SY021001Dao;

	public SY021001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY021001VO> selectListEnaCompanyMst(SY021001VO vo) throws Exception {
		List<SY021001VO> lst = null;

		try {
			lst = SY021001Dao.selectListEnaCompanyMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public int updateEnaCompanyMst(SY021001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = SY021001Dao.updateEnaCompanyMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}
	
	public int insertEnaCompanyMst(SY021001VO vo) throws Exception {
		int insertCnt = 0;

		try {
			insertCnt = SY021001Dao.insertEnaCompanyMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
}
