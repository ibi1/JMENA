package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012004Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012004VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012004Biz {
	
	@Resource(name = "SA012004Dao")
	private SA012004Dao SA012004Dao;

	public SA012004Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012004VO> selectListEnaInsaMst() throws Exception {
		List<SA012004VO> lst = null;

		try {
			//lst = SA012004Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
