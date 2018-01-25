package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Dao.EP012002Dao;
import kr.co.jmena.www.web.home.expayMng.Vo.EP012002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP012002Biz {
	
	@Resource(name = "EP012002Dao")
	private EP012002Dao EP012002Dao;

	public EP012002Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP012002VO> selectListSudangMst(EP012002VO vo) throws Exception {
		List<EP012002VO> lst = null;

		try {
			lst = EP012002Dao.selectListSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
