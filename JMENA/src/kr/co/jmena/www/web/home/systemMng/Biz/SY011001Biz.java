package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011001Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011001Biz {
	
	@Resource(name = "SY011001Dao")
	private SY011001Dao SY011001Dao;

	public SY011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011001VO> selectListSysMst() throws Exception {
		List<SY011001VO> lst = null;

		try {
			lst = SY011001Dao.selectListSysMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SY011001VO> selectListSysDtl(SY011001VO vo) throws Exception {
		List<SY011001VO> lst = null;

		try {
			lst = SY011001Dao.selectListSysDtl(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
