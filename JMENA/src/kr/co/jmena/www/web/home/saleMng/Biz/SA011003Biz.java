package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA011003Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011003Biz {
	
	@Resource(name = "SA011003Dao")
	private SA011003Dao SA011003Dao;

	public SA011003Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA011003VO> selectListEnaIpgumMst(SA011003VO vo) throws Exception {
		List<SA011003VO> lst = null;

		try {
			lst = SA011003Dao.selectListEnaIpgumMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
