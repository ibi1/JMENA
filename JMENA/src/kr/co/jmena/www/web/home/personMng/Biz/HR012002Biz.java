package kr.co.jmena.www.web.home.personMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.personMng.Dao.HR012002Dao;
import kr.co.jmena.www.web.home.personMng.Vo.HR012002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class HR012002Biz {
	
	@Resource(name = "HR012002Dao")
	private HR012002Dao HR012002Dao;

	public HR012002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<HR012002VO> selectListHR012002(HR012002VO vo) throws Exception {
		List<HR012002VO> lst = null;

		try {
			lst = HR012002Dao.selectListHR012002(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<HR012002VO> selectListHR012002_2(HR012002VO vo) throws Exception {
		List<HR012002VO> lst = null;

		try {
			lst = HR012002Dao.selectListHR012002_2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	
	public List<HR012002VO> selectListHR012002_3(HR012002VO vo) throws Exception {
		List<HR012002VO> lst = null;

		try {
			lst = HR012002Dao.selectListHR012002_3(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
