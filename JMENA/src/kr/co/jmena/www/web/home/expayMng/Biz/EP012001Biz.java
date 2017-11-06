package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Dao.EP012001Dao;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP012001Biz {
	
	@Resource(name = "EP012001Dao")
	private EP012001Dao EP012001Dao;

	public EP012001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP012001VO> selectListEP012001(EP012001VO vo) throws Exception {
		List<EP012001VO> lst = null;

		try {
			lst = EP012001Dao.selectListEP012001(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<EP012001VO> selectListEP012001_2(EP012001VO vo) throws Exception {
		List<EP012001VO> lst = null;

		try {
			lst = EP012001Dao.selectListEP012001_2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
