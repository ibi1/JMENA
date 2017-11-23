package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Dao.SA011003Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011003Biz {
	
	@Resource(name = "SA011003Dao")
	private SA011003Dao SA011003Dao;

	public SA011003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA011003VO> selectListEnaIpgumMst(SA011003VO vo) throws Exception {
		List<SA011003VO> lst = null;

		try {
			lst = SA011003Dao.selectListEnaIpgumMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SA011003VO> selectListEnaIpgumDtl(SA011003VO vo) throws Exception {
		List<SA011003VO> lst = null;

		try {
			lst = SA011003Dao.selectListEnaIpgumDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public int selectOneEnaIpgumMst(SA011003VO vo) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011003Dao.selectOneEnaIpgumMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return cnt;
	}	
	
	public int insertEnaIpgumMst(SA011003VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = SA011003Dao.insertEnaIpgumMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	
	public int updateEnaIpgumMst(SA011003VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = SA011003Dao.updateEnaIpgumMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}	

	public int insertEnaIpgumDtl(SA011003VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = SA011003Dao.insertEnaIpgumDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	
	public int updateEnaIpgumDtl(SA011003VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = SA011003Dao.updateEnaIpgumDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}	
	
	public boolean deleteEnaIpgumMst(SA011003VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011003Dao.deleteEnaIpgumMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}

	public boolean deleteEnaIpgumDtl(SA011003VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011003Dao.deleteEnaIpgumDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
}
