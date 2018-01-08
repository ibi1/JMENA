package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.buyingMng.Vo.MM011001VO;
import kr.co.jmena.www.web.home.saleMng.Dao.SA011005Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA011005VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA011005Biz {
	
	@Resource(name = "SA011005Dao")
	private SA011005Dao SA011005Dao;

	public SA011005Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	
	public int selectDataSaleHistoryTb004(SA011005VO vo) throws Exception {
		try {
			return SA011005Dao.selectDataSaleHistoryTb004(vo);
		} catch ( Exception e ) {
			throw e;
		}
	}
	
	public List<SA011005VO> selectListEanSaleMst(SA011005VO vo) throws Exception {
		List<SA011005VO> lst = null;

		try {
			lst = SA011005Dao.selectListEanSaleMst(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataSaleMst(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.insertDataSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataSaleMst(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.updateDataSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllSaleHistoryTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011005Dao.selectAllSaleHistoryTb(vo) > 0) {
				chkFlag = SA011005Dao.deleteAllSaleHistoryTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllJointnameTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011005Dao.selectAllJointnameTb(vo) > 0) {
				chkFlag = SA011005Dao.deleteAllJointnameTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteAllIpgumScheduleTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			if (SA011005Dao.selectAllIpgumScheduleTb(vo) > 0) {
				chkFlag = SA011005Dao.deleteAllIpgumScheduleTb(vo);
			} else {
				chkFlag = true;
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSaleDtl(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.deleteDataSaleDtl(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataSaleMst(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.deleteDataSaleMst(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEnaIpgumScheduleTb(SA011005VO vo) throws Exception {
		List<SA011005VO> lst = null;

		try {
			lst = SA011005Dao.selectListEnaIpgumScheduleTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaIpgumScheduleTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.insertDataEnaIpgumScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaIpgumScheduleTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.updateDataEnaIpgumScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaIpgumScheduleTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.deleteDataEnaIpgumScheduleTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEnaJointNameTb(SA011005VO vo) throws Exception {
		List<SA011005VO> lst = null;

		try {
			lst = SA011005Dao.selectListEnaJointNameTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaJointNameTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			//공동명의 구분 및 등기여부, 등기일자 업데이트
			chkFlag = SA011005Dao.updateDataJoint(vo);
			
			if (chkFlag == true) {
				if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
				chkFlag = SA011005Dao.insertDataEnaJointNameTb(vo);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaJointNameTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
	
		try {
			//공동명의 구분 및 등기여부, 등기일자 업데이트
			chkFlag = SA011005Dao.updateDataJoint(vo);
			
			if (chkFlag == true) {
				if (!"".equals(vo.getJOINTNAME())) {	//그리드 추가 값이 있을 경우
				chkFlag = SA011005Dao.updateDataEnaJointNameTb(vo);
				}
			}
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaJointNameTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.deleteDataEnaJointNameTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEnaSaleHistoryTb(SA011005VO vo) throws Exception {
		List<SA011005VO> lst = null;

		try {
			lst = SA011005Dao.selectListEnaSaleHistoryTb(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public boolean insertDataEnaSaleHistoryTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.insertDataEnaSaleHistoryTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean updateDataEnaSaleHistoryTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.updateDataEnaSaleHistoryTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public boolean deleteDataEnaSaleHistoryTb(SA011005VO vo) throws Exception {
		boolean chkFlag = false;
		
		try {
			chkFlag = SA011005Dao.deleteDataEnaSaleHistoryTb(vo);
		} catch (Exception e) {
			throw e;
		}
		
		return chkFlag;
	}
	
	public List<SA011005VO> selectListEanSaleMstPopup(SA011005VO vo) throws Exception {
		List<SA011005VO> lst = null;

		try {
			lst = SA011005Dao.selectListEanSaleMstPopup(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MM011001VO> selectListEnaBuyMstPopup(MM011001VO vo) throws Exception {
		List<MM011001VO> lst = null;

		try {
			lst = SA011005Dao.selectListEnaBuyMstPopup(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<SA011005VO> selectHRInsamstBranchCode(SA011005VO vo) throws Exception {
		List<SA011005VO> lst = null;
		
		try {
			lst = SA011005Dao.selectHRInsamstBranchCode(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<Map<String, Object>> selectListIpgumDtl(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011005Dao.selectListIpgumDtl(param);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
	
	public List<Map<String, Object>> selectListIpgumMst(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> lst = null;
		
		try {
			lst = SA011005Dao.selectListIpgumMst(param);
		} catch (Exception e) {
			throw e;
		}
		
		return lst;
	}
	
	public int insertIpgumDtl(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011005Dao.insertIpgumDtl(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}

	public int deleteIpgumDtl(Map<String, Object> param) throws Exception {
		int cnt = 0;
		
		try {
			cnt = SA011005Dao.deleteIpgumDtl(param);
		} catch (Exception e) {
			throw e;
		}
		
		return cnt;
	}
}
