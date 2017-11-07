package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012001Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012001Biz {
	
	@Resource(name = "SA012001Dao")
	private SA012001Dao SA012001Dao;

	public SA012001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012001VO> selectListSA012001_1(SA012001VO vo) throws Exception {
		List<SA012001VO> lst = null;

		try {
			lst = SA012001Dao.selectListSA012001_1(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SA012001VO> selectListSA012001_2(SA012001VO vo) throws Exception {
		List<SA012001VO> lst = null;

		try {
			lst = SA012001Dao.selectListSA012001_2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SA012001VO> selectListSA012001_3(SA012001VO vo) throws Exception {
		List<SA012001VO> lst = null;

		try {
			lst = SA012001Dao.selectListSA012001_3(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SA012001VO> selectListSA012001_4(SA012001VO vo) throws Exception {
		List<SA012001VO> lst = null;

		try {
			lst = SA012001Dao.selectListSA012001_4(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
