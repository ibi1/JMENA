package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011006Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011006VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011006Biz {
	
	@Resource(name = "SY011006Dao")
	private SY011006Dao SY011006Dao;

	public SY011006Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011006VO> selectListBankMst(SY011006VO vo) throws Exception {
		List<SY011006VO> lst = null;

		try {
			lst = SY011006Dao.selectListBankMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean selectDataBankMst(SY011006VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011006Dao.selectDataBankMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean insertDataBankMst(SY011006VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011006Dao.insertDataBankMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataBankMst(SY011006VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011006Dao.updateDataBankMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
}
