package kr.co.jmena.www.web.home.expayMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO;
import kr.co.jmena.www.web.home.expayMng.Dao.EP011001Dao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class EP011001Biz {
	
	@Resource(name = "EP011001Dao")
	private EP011001Dao EP011001Dao;

	public EP011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<EP011001VO> selectListEnaSudangMst(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;

		try {
			lst = EP011001Dao.selectListEnaSudangMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<EP011001VO> selectListEnaSudangPTb(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;

		try {
			lst = EP011001Dao.selectListEnaSudangPTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}	
	
	public List<EP011001VO> selectListEnaSaleSudangList(EP011001VO vo) throws Exception {
		List<EP011001VO> lst = null;

		try {
			lst = EP011001Dao.selectListEnaSaleSudangList(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}		
	
	
}
