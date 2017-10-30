package kr.co.jmena.www.web.home.personMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.personMng.Dao.HR012003Dao;
import kr.co.jmena.www.web.home.personMng.Vo.HR012003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class HR012003Biz {
	
	@Resource(name = "HR012003Dao")
	private HR012003Dao HR012003Dao;

	public HR012003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<HR012003VO> selectListEnaInsaMst() throws Exception {
		List<HR012003VO> lst = null;

		try {
			//lst = HR012003Dao.selectListEnaInsaMst();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
