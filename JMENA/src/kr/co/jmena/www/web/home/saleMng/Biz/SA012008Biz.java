package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012008Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012008VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012008Biz {
	
	@Resource(name = "SA012008Dao")
	private SA012008Dao SA012008Dao;

	public SA012008Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012008VO> selectListEnaInsaMst() throws Exception {
		List<SA012008VO> lst = null;

		try {
			//lst = SA012008Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
