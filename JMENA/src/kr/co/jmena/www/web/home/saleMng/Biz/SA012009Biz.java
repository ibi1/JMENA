package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012009Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012009VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012009Biz {
	
	@Resource(name = "SA012009Dao")
	private SA012009Dao SA012009Dao;

	public SA012009Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012009VO> selectListEnaInsaMst() throws Exception {
		List<SA012009VO> lst = null;

		try {
			//lst = SA012009Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
