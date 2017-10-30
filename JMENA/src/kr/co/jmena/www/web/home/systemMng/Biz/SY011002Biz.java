package kr.co.jmena.www.web.home.systemMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.systemMng.Dao.SY011002Dao;
import kr.co.jmena.www.web.home.systemMng.Vo.SY011002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SY011002Biz {
	
	@Resource(name = "SY011002Dao")
	private SY011002Dao SY011002Dao;

	public SY011002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SY011002VO> selectListMenuPgmTb(SY011002VO vo) throws Exception {
		List<SY011002VO> lst = null;

		try {
			lst = SY011002Dao.selectListMenuPgmTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
}
