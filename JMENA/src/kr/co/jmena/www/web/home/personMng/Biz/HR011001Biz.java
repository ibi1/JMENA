package kr.co.jmena.www.web.home.personMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.personMng.Dao.HR011001Dao;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class HR011001Biz {
	
	@Resource(name = "HR011001Dao")
	private HR011001Dao HR011001Dao;

	public HR011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<HR011001VO> selectListEnaInsaMst(HR011001VO vo) throws Exception {
		List<HR011001VO> lst = null;

		try {
			lst = HR011001Dao.selectListEnaInsaMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public int updateEnaInsaMst(HR011001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = HR011001Dao.updateEnaInsaMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}
	
	public int insertEnaInsaMst(HR011001VO vo) throws Exception {
		int insertCnt = 0;

		try {
			insertCnt = HR011001Dao.insertEnaInsaMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}	
	
	
	public List<HR011001VO> selectListEnaAppointItem(HR011001VO vo) throws Exception {
		List<HR011001VO> lst = null;

		try {
			lst = HR011001Dao.selectListEnaAppointItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
		
	
	public List<HR011001VO> selectListEnaTexPayerItem(HR011001VO vo) throws Exception {
		List<HR011001VO> lst = null;
		
		try {
			lst = HR011001Dao.selectListEnaTexPayerItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	
}
