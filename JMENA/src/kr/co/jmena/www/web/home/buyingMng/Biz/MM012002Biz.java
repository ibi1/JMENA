package kr.co.jmena.www.web.home.buyingMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Dao.MM012002Dao;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012002VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MM012002Biz {
	
	@Resource(name = "MM012002Dao")
	private MM012002Dao MM012002Dao;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<MM012002VO> selectListBuyMst(MM012002VO vo) throws Exception {
		List<MM012002VO> lst = null;
		
		try {
			lst = MM012002Dao.selectListBuyMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
}
