package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012010Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012010VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012010Biz {

	@Resource(name = "SA012010Dao")
	private SA012010Dao SA012010Dao;

	public SA012010Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());

	public List<SA012010VO> selectListSA012010(SA012010VO vo) throws Exception {
		List<SA012010VO> lst = null;

		try {
			lst = SA012010Dao.selectListSA012010(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
