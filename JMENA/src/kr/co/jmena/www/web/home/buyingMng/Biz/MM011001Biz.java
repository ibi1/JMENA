package kr.co.jmena.www.web.home.buyingMng.Biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Dao.MM011001Dao;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY021002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MM011001Biz {
	
	@Resource(name = "MM011001Dao")
	private MM011001Dao MM011001Dao;

	public MM011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<MM011001VO> selectListEnaBuyMst(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = MM011001Dao.selectListEnaBuyMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MM011001VO> selectListEnaPayScheduleTb(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = MM011001Dao.selectListEnaPayScheduleTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<MM011001VO> selectListEnaSalesOpenTb(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = MM011001Dao.selectListEnaSalesOpenTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataBuyMst(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.insertDataBuyMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataBuyMst(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.updateDataBuyMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllSalesopenTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (MM011001Dao.selectAllSalesopenTb(vo) > 0) {
				chkFlag = MM011001Dao.deleteAllSalesopenTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllPayScheduleTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (MM011001Dao.selectAllPayScheduleTb(vo) > 0) {
				chkFlag = MM011001Dao.deleteAllPayScheduleTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataBuyMst(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.deleteDataBuyMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}

	public boolean deleteDataPayScheduleTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.deleteDataPayScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSalesopenTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.deleteDataSalesopenTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean insertDataPayScheduleTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.insertDataPayScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataPayScheduleTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.updateDataPayScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean insertDataSalesopenTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.insertDataSalesopenTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataSalesopenTb(MM011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = MM011001Dao.updateDataSalesopenTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<MM011001VO> selectSumSaleMst(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = MM011001Dao.selectSumSaleMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
