package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Dao.SA011001Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011001VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011001Biz {
	
	@Resource(name = "SA011001Dao")
	private SA011001Dao SA011001Dao;

	public SA011001Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA011001VO> selectListEanSaleMst(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEanSaleMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SA011001VO> selectListEnaIpgumScheduleTb(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEnaIpgumScheduleTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaIpgumScheduleTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.insertDataEnaIpgumScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaIpgumScheduleTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.updateDataEnaIpgumScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaIpgumScheduleTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.deleteDataEnaIpgumScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011001VO> selectListEnaJointNameTb(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEnaJointNameTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaJointNameTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			//공동명의 구분 및 등기여부, 등기일자 업데이트
			chkFlag = SA011001Dao.updateDataJoint(vo);
			
			if (chkFlag == true) {
				if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
				chkFlag = SA011001Dao.insertDataEnaJointNameTb(vo);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaJointNameTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
	
		try {
			//공동명의 구분 및 등기여부, 등기일자 업데이트
			chkFlag = SA011001Dao.updateDataJoint(vo);
			
			if (chkFlag == true) {
				if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
				chkFlag = SA011001Dao.updateDataEnaJointNameTb(vo);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaJointNameTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.deleteDataEnaJointNameTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011001VO> selectListEnaSaleHistoryTb(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEnaSaleHistoryTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaSaleHistoryTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.insertDataEnaSaleHistoryTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaSaleHistoryTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.updateDataEnaSaleHistoryTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaSaleHistoryTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.deleteDataEnaSaleHistoryTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
}
