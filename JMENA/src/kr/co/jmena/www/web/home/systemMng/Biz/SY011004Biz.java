package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011004Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011004VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011004Biz {
	
	@Resource(name = "SY011004Dao")
	private SY011004Dao SY011004Dao;

	public SY011004Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011004VO> selectListUserMst4(SY011004VO vo) throws Exception {
		List<SY011004VO> lst = null;

		try {
			lst = SY011004Dao.selectListUserMst4(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SY011004VO> selectListUserPgmAuthTb(SY011004VO vo) throws Exception {
		List<SY011004VO> lst = null;

		try {
			lst = SY011004Dao.selectListUserPgmAuthTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
