package kr.co.jmena.www.web.home.personMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.personMng.Dao.HR011001Dao;
import kr.co.jmena.www.web.home.personMng.Vo.HR011001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class HR011001Biz {
	
	@Resource(name = "HR011001Dao")
	private HR011001Dao HR011001Dao;

	public HR011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<HR011001VO> selectListEnaInsaMst() throws Exception {
		List<HR011001VO> lst = null;

		try {
			//lst = HR011001Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
