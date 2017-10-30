package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Dao.EP011002Dao;
import kr.co.jmena.www.web.home.expayMng.Vo.EP011002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP011002Biz {
	
	@Resource(name = "EP011002Dao")
	private EP011002Dao EP011002Dao;

	public EP011002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP011002VO> selectListEnaInsaMst() throws Exception {
		List<EP011002VO> lst = null;

		try {
			//lst = EP011002Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
