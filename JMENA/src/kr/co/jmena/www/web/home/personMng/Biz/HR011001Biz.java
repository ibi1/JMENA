package kr.co.jmena.www.web.home.personMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.personMng.Dao.HR011001Dao;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;

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
	
	public int insertEnaInsaMst(HR011001VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = HR011001Dao.insertEnaInsaMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
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
	
	
	
	public List<HR011001VO> selectListEnaAppointItem(HR011001VO vo) throws Exception {
		List<HR011001VO> lst = null;

		try {
			lst = HR011001Dao.selectListEnaAppointItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}	
	
	
	public int insertEnaAppointItem(HR011001VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = HR011001Dao.insertEnaAppointItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	
	public int updateEnaAppointItem(HR011001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = HR011001Dao.updateEnaAppointItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}
	
	public boolean deleteEnaAppointItem(HR011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = HR011001Dao.deleteEnaAppointItem(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
		
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
	
	public int insertEnaTexPayerItem(HR011001VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = HR011001Dao.insertEnaTexPayerItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	
	public int updateEnaTexPayerItem(HR011001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = HR011001Dao.updateEnaTexPayerItem(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}
	
	
	public boolean deleteEnaTexPayerItem(HR011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = HR011001Dao.deleteEnaTexPayerItem(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}	
	
	public int updateBasicAcct(HR011001VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = HR011001Dao.updateBasicAcct(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}	
	
	public List<HR011001VO> selectDeptGubun(HR011001VO vo) throws Exception {
		List<HR011001VO> lst = null;

		try {
			lst = HR011001Dao.selectDeptGubun(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
		
	public boolean deleteDataInsaMst(HR011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = HR011001Dao.deleteDataInsaMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}

	public List<HR011001VO> selectHRInsamst(HR011001VO vo) throws Exception {
		List<HR011001VO> lst = null;

		try {
			lst = HR011001Dao.selectHRInsamst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
