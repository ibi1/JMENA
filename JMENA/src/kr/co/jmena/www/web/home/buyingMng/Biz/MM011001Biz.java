package kr.co.jmena.www.web.home.buyingMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Dao.MM011001Dao;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;

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
	
}
