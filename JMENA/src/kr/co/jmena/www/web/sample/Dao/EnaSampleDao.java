/**
 * Sample Transaction DataAccessObject
 * 
 * @author JaeHyeongLee
 */
package kr.co.jmena.www.web.sample.Dao;

import java.util.List;

import kr.co.jmena.www.web.sample.Vo.EnaSampleVO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class EnaSampleDao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "kr.co.jmena.www.web.sample.";

	public List<EnaSampleVO> selectEnaSample() throws DataAccessException {
		List<EnaSampleVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectEnaSample");
		
		return lst;
	}
	
	public void insertEnaSample(List<EnaSampleVO> vo) throws DataAccessException {
		getSqlMapClientTemplate().insert(NAME_SPACE + "insertEnaSample", vo.get(0));
	}
	
	public void updateEnaSample(List<EnaSampleVO> vo) throws DataAccessException {
		int rc = getSqlMapClientTemplate().update(NAME_SPACE + "updateEnaSample", vo.get(0));
		
		//rc check logic
	}
	
	public void deleteEnaSample(List<EnaSampleVO> vo) throws DataAccessException {
		int rc = getSqlMapClientTemplate().delete(NAME_SPACE + "deleteEnaSample", vo.get(0));
		
		//rc check logic
	}
}
