package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Vo.SA012011VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012011Biz {
	
	@Resource(name = "SA012011Dao")
	private kr.co.jmena.www.web.home.saleMng.Dao.SA012011Dao SA012011Dao;
	
	public SA012011Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012011VO> selectListSaleMst(SA012011VO vo) throws Exception {
		List<SA012011VO> lst = null;
			
		try {
			lst = SA012011Dao.selectListSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
}
