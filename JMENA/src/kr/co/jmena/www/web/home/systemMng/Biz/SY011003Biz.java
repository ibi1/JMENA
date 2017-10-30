package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011003Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011003Biz {
	
	@Resource(name = "SY011003Dao")
	private SY011003Dao SY011003Dao;

	public SY011003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011003VO> selectListUserMst(SY011003VO vo) throws Exception {
		List<SY011003VO> lst = null;

		try {
			lst = SY011003Dao.selectListUserMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SY011003VO> selectListUserSysTb(SY011003VO vo) throws Exception {
		List<SY011003VO> lst = null;

		try {
			lst = SY011003Dao.selectListUserSysTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
