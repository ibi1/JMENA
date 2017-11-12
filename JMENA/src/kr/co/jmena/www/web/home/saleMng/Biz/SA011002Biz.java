package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA011002Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011002Biz {
	
	@Resource(name = "SA011002Dao")
	private SA011002Dao SA011002Dao;

	public SA011002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA011002VO> selectListEnaSaleMst2(SA011002VO vo) throws Exception {
		List<SA011002VO> lst = null;

		try {
			lst = SA011002Dao.selectListEnaSaleMst2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
