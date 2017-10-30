package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Dao.EP012003Dao;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP012003Biz {
	
	@Resource(name = "EP012003Dao")
	private EP012003Dao EP012003Dao;

	public EP012003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP012003VO> selectListEnaInsaMst() throws Exception {
		List<EP012003VO> lst = null;

		try {
			//lst = EP012003Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
