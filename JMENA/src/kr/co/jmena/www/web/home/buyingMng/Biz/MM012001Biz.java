package kr.co.jmena.www.web.home.buyingMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Dao.MM012001Dao;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012001VO;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012007VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MM012001Biz {
	
	@Resource(name = "MM012001Dao")
	private MM012001Dao MM012001Dao;

	public MM012001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<MM012001VO> selectListMM012001(MM012001VO vo) throws Exception {
		List<MM012001VO> lst = null;

		try {
			lst = MM012001Dao.selectListMM012001(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MM012001VO> selectListMM012001_1(MM012001VO vo) throws Exception {
		List<MM012001VO> lst = null;

		try {
			lst = MM012001Dao.selectListMM012001_1(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
