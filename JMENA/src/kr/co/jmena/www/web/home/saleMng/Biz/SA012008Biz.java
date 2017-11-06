package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012008Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012008VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012008Biz {
	
	@Resource(name = "SA012008Dao")
	private SA012008Dao SA012008Dao;

	public SA012008Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012008VO> selectListSA012008(SA012008VO vo) throws Exception {
		List<SA012008VO> lst = null;

		try {
			lst = SA012008Dao.selectListSA012008(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SA012008VO> selectListSA012008_2(SA012008VO vo) throws Exception {
		List<SA012008VO> lst = null;

		try {
			lst = SA012008Dao.selectListSA012008_2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
