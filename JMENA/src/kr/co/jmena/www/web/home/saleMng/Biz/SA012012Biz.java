package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012012VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012012Biz {
	
	@Resource(name = "SA012012Dao")
	private kr.co.jmena.www.web.home.saleMng.Dao.SA012012Dao SA012012Dao;
	
	public SA012012Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012012VO> selectListSaleMst(SA012012VO vo) throws Exception {
		List<SA012012VO> lst = null;
			
		try {
			lst = SA012012Dao.selectListSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
}
