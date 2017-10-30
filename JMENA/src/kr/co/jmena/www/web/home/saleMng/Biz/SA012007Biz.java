package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012007Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012007VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012007Biz {
	
	@Resource(name = "SA012007Dao")
	private SA012007Dao SA012007Dao;

	public SA012007Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012007VO> selectListEnaInsaMst() throws Exception {
		List<SA012007VO> lst = null;

		try {
			//lst = SA012007Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
