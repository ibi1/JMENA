package kr.co.jmena.www.web.sample.Biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.jmena.www.web.sample.Dao.EnaSampleDao;
import kr.co.jmena.www.web.sample.Vo.EnaSampleVO;

import org.springframework.stereotype.Service;

@Service
public class EnaSampleBiz {
	
	@Resource(name = "enaSampleDao")
	private EnaSampleDao enaSampleDao;
	
	public EnaSampleBiz() {}
	
	public List<EnaSampleVO> selectEnaSample() throws Exception {
		List<EnaSampleVO> lst = null;

		try {
			lst = enaSampleDao.selectEnaSample();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
		
	}
	
	public boolean insertEnaSample(List<EnaSampleVO> vo) throws Exception {
		boolean bRc = false;

		try {
			enaSampleDao.insertEnaSample(vo);
			bRc = true;
		} catch ( Exception e ) {
			throw e;
		}
		
		return bRc;
	}
	
	public boolean updateEnaSample(List<EnaSampleVO> vo) throws Exception {
		boolean bRc = false;

		try {
			enaSampleDao.updateEnaSample(vo);
			bRc = true;
		} catch ( Exception e ) {
			throw e;
		}
		
		return bRc;
	}
	
	public boolean deleteEnaSample(List<EnaSampleVO> vo) throws Exception {
		boolean bRc = false;
		
		try {
			enaSampleDao.deleteEnaSample(vo);
			bRc = true;
		} catch ( Exception e ) {
			throw e;
		}
		
		return bRc;
	}
}
