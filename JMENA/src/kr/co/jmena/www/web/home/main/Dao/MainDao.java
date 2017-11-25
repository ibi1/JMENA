package kr.co.jmena.www.web.home.main.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.main.Vo.MainVO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class MainDao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "MAIN.";

	/**
	 * 로그인
	 * @return
	 * @throws DataAccessException
	 */
	public List<MainVO> selectUserInfo(MainVO vo) throws DataAccessException {
		List<MainVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectUserInfo", vo);
		
		return lst;
	}
	
	/**
	 * 시스템 메뉴
	 * @return
	 * @throws DataAccessException
	 */
	public List<MainVO> selectSystemMenu(MainVO vo) throws DataAccessException {
		List<MainVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectSystemMenu", vo);
		
		return lst;
	}
	
	/**
	 * 트리 메뉴
	 * @param vo
	 * @return
	 * @throws DataAccessException
	 */
	public List<MainVO> selectMenuTb(MainVO vo) throws DataAccessException {
		List<MainVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectMenuTb", vo);
		
		return lst;
	}
	
	/**
	 * 트리 메뉴 프로그램 리스트
	 * @param vo
	 * @return
	 * @throws DataAccessException
	 */
	public List<MainVO> selectPgmTb(MainVO vo) throws DataAccessException {
		List<MainVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectPgmTb", vo);
		
		return lst;
	}
	
	/**
	 * 프로그램 권한 가져오기
	 * @param vo
	 * @return
	 * @throws DataAccessException
	 */
	public List<MainVO> selectPgmAuth(MainVO vo) throws DataAccessException {
		List<MainVO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectPgmAuth", vo);
		
		return lst;
	}
}
