package kr.co.jmena.www.web.home.buyingMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Dao.MM012003Dao;
import kr.co.jmena.www.web.home.buyingMng.Vo.MM012003VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MM012003Biz {
	
	@Resource(name = "MM012003Dao")
	private MM012003Dao MM012003Dao;
	
	public MM012003Biz() {}

	protected final Logger logger = Logger.getLogger(getClass());

	public List<MM012003VO> selectListBuyMst(MM012003VO vo) throws Exception {
		List<MM012003VO> lst = null;
		
		try {
			lst = MM012003Dao.selectListBuyMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
}
