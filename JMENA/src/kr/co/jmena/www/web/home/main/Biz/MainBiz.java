package kr.co.jmena.www.web.home.main.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.main.Dao.MainDao;
import kr.co.jmena.www.web.home.main.Vo.MainVO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MainBiz {
	
	@Resource(name = "mainDao")
	private MainDao mainDao;

	public MainBiz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<MainVO> selectUserInfo(MainVO vo) throws Exception {
		List<MainVO> lst = null;

		try {
			lst = mainDao.selectUserInfo(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public List<MainVO> selectSystemMenu() throws Exception {
		List<MainVO> lst = null;

		try {
			lst = mainDao.selectSystemMenu();
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
	public String[] selectTreeMenu(String sysId) throws Exception {
		StringBuilder treeHtml = new StringBuilder();
		String pgmFirst = "";
		String[] strArr = new String[2];
		
		List<MainVO> menulst = null;
		List<MainVO> pgmlst = null;
		
		try {
			menulst = mainDao.selectMenuTb(sysId);	//메뉴리스트
			pgmlst = mainDao.selectPgmTb(sysId); //프로그램리스트
			
//			treeHtml.append("<div id=\"sidetree\">");
//			treeHtml.append("<div class=\"treeheader\">&nbsp;</div>");
//			treeHtml.append("<div id=\"sidetreecontrol\"><a href=\"?#\">Collapse All</a> | <a href=\"?#\">Expand All</a></div>");
//			
//			treeHtml.append("<ul id=\"tree\">");
			//tree html 생성
			for (int i = 0; i < menulst.size(); i++) {
				String menuId = menulst.get(i).getMENUID();
				
				treeHtml.append("	<li><div></div>");
				
				treeHtml.append("<a><strong>" + menulst.get(i).getMENUNAME() + "</strong></a>");
				treeHtml.append("	<ul>");
				
				pgmFirst = pgmlst.get(0).getPGMID();	//첫번째 프로그램 목록 무조건 넘겨주기
				
				for (int j = 0; j < pgmlst.size(); j++) {
					if (pgmlst.get(j).getMENUID().equals(menuId)) {
						
						
						treeHtml.append("		<li><a onclick=\"pageView('" + pgmlst.get(j).getPGMID()  + "')\" class>" + pgmlst.get(j).getPGMNAME() + "</a></li>");
					}
				}
				
				treeHtml.append("	</ul>");
				treeHtml.append("	</li>");
			}
			
//			treeHtml.append("</ul>");
//			treeHtml.append("</div>");
			
			strArr[0] = treeHtml.toString();
			strArr[1] = pgmFirst;
			
		} catch ( Exception e ) {
			throw e;
		}
		
		return strArr;
	}
}
