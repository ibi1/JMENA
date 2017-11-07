package kr.co.jmena.www.web.home.personMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.personMng.Dao.HR012001Dao;
import kr.co.jmena.www.web.home.personMng.Vo.HR012001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class HR012001Biz {
	
	@Resource(name = "HR012001Dao")
	private HR012001Dao HR012001Dao;

	public HR012001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	/**
	 * @name 입사자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public List<HR012001VO> selectListHR012001(HR012001VO vo) throws Exception {
		List<HR012001VO> lst = null;

		try {
			lst = HR012001Dao.selectListHR012001(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<HR012001VO> selectListHR012001_2(HR012001VO vo) throws Exception {
		List<HR012001VO> lst = null;

		try {
			lst = HR012001Dao.selectListHR012001_2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<HR012001VO> selectListHR012001_3(HR012001VO vo) throws Exception {
		List<HR012001VO> lst = null;

		try {
			lst = HR012001Dao.selectListHR012001_3(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
