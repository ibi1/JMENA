package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012006Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012006VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012006Biz {
	
	@Resource(name = "SA012006Dao")
	private SA012006Dao SA012006Dao;

	public SA012006Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012006VO> selectListEnaInsaMst() throws Exception {
		List<SA012006VO> lst = null;

		try {
			//lst = SA012006Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
