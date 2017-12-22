package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Vo.EP012004VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP012004Biz {
	
	@Resource(name = "EP012004Dao")
	private kr.co.jmena.www.web.home.expayMng.Dao.EP012004Dao EP012004Dao;
	
	public EP012004Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP012004VO> selectListEP012004(EP012004VO vo) throws Exception {
		List<EP012004VO> lst = null;
			
		try {
			lst = EP012004Dao.selectListEP012004(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}	
}
