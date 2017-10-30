package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA011001Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011001Biz {
	
	@Resource(name = "SA011001Dao")
	private SA011001Dao SA011001Dao;

	public SA011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA011001VO> selectListEnaSaleMst(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEnaSaleMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
