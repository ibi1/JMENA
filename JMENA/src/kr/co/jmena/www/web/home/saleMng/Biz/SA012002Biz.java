package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012002Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012002Biz {
	
	@Resource(name = "SA012002Dao")
	private SA012002Dao SA012002Dao;

	public SA012002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012002VO> selectListSA012002(SA012002VO vo) throws Exception {
		List<SA012002VO> lst = null;

		try {
			lst = SA012002Dao.selectListSA012002(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
