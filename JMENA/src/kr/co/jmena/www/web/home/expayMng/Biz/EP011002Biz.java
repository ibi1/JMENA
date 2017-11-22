package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Dao.EP011002Dao;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP011002Biz {
	
	@Resource(name = "EP011002Dao")
	private EP011002Dao EP011002Dao;

	public EP011002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP011002VO> selectListEnaMonthPayMst(EP011002VO vo) throws Exception {
		List<EP011002VO> lst = null;

		try {
			lst = EP011002Dao.selectListEnaMonthPayMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<EP011002VO> selectListEnaMonthPayMstCrt(EP011002VO vo) throws Exception {
		List<EP011002VO> lst = null;

		try {
			lst = EP011002Dao.selectListEnaMonthPayMstCrt(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}	
	
	
	public int insertEnaMonthPayMst(EP011002VO vo) throws Exception {
		int insertCnt = 0;
		
		try {
			insertCnt = EP011002Dao.insertEnaMonthPayMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return insertCnt;
	}
	
	public int updateEnaMonthPayMst(EP011002VO vo) throws Exception {
		int updateCnt = 0;

		try {
			updateCnt = EP011002Dao.updateEnaMonthPayMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return updateCnt;
	}
	
	public boolean deleteEnaMonthPayMstAll(EP011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011002Dao.deleteEnaMonthPayMstAll(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
		
	}

	public boolean deleteEnaMonthPayMst(EP011002VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = EP011002Dao.deleteEnaMonthPayMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
		
	}	
	
}
