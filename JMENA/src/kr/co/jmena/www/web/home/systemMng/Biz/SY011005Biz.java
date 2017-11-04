package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011005Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011005VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011005Biz {
	
	@Resource(name = "SY011005Dao")
	private SY011005Dao SY011005Dao;

	public SY011005Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011005VO> selectListCcodeMst(SY011005VO vo) throws Exception {
		List<SY011005VO> lst = null;

		try {
			lst = SY011005Dao.selectListCcodeMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SY011005VO> selectListCcodeDtl(SY011005VO vo) throws Exception {
		List<SY011005VO> lst = null;

		try {
			lst = SY011005Dao.selectListCcodeDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataCcodeMst(SY011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011005Dao.insertDataCcodeMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataCcodeMst(SY011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011005Dao.updateDataCcodeMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean insertDataCcodeDtl(SY011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011005Dao.insertDataCcodeDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataCcodeDtl(SY011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SY011005Dao.updateDataCcodeDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
}
