package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012013Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012013VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012013Biz {
	
	@Resource(name = "SA012013Dao")
	private SA012013Dao SA012013Dao;
	
	public SA012013Biz() {}

	protected final Logger logger = Logger.getLogger(getClass());

	public List<SA012013VO> selectListSaleMst(SA012013VO vo) throws Exception {
		List<SA012013VO> lst = null;
		
		try {
			lst = SA012013Dao.selectListSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
}
