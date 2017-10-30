package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012003Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012003Biz {
	
	@Resource(name = "SA012003Dao")
	private SA012003Dao SA012003Dao;

	public SA012003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012003VO> selectListEnaInsaMst() throws Exception {
		List<SA012003VO> lst = null;

		try {
			//lst = SA012003Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
