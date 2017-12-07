package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
	
	
	public int selectDataSaleHistoryTb004(SA011001VO vo) throws Exception {
		try {
			return SA011001Dao.selectDataSaleHistoryTb004(vo);
		} catch ( Exception e ) {
			throw e;
		}
	}
	
	public List<SA011001VO> selectListEanSaleMst(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEanSaleMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataSaleMst(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.insertDataSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataSaleMst(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.updateDataSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllSaleHistoryTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011001Dao.selectAllSaleHistoryTb(vo) > 0) {
				chkFlag = SA011001Dao.deleteAllSaleHistoryTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllJointnameTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011001Dao.selectAllJointnameTb(vo) > 0) {
				chkFlag = SA011001Dao.deleteAllJointnameTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllIpgumScheduleTb(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011001Dao.selectAllIpgumScheduleTb(vo) > 0) {
				chkFlag = SA011001Dao.deleteAllIpgumScheduleTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSaleDtl(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.deleteDataSaleDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSaleMst(SA011001VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011001Dao.deleteDataSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
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
	
	public List<SA011001VO> selectListEanSaleMstPopup(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEanSaleMstPopup(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MM011001VO> selectListEnaBuyMstPopup(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = SA011001Dao.selectListEnaBuyMstPopup(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SA011001VO> selectHRInsamstBranchCode(SA011001VO vo) throws Exception {
		List<SA011001VO> lst = null;
		
		try {
			lst = SA011001Dao.selectHRInsamstBranchCode(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
