package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.News;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Zambia;

import com.chengxusheji.mapper.ZambiaMapper;
@Service
public class ZambiaService {

	@Resource ZambiaMapper zambiaMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加新闻赞记录*/
    public void addZambia(Zambia zambia) throws Exception {
    	zambiaMapper.addZambia(zambia);
    }

    /*按照查询条件分页查询新闻赞记录*/
    public ArrayList<Zambia> queryZambia(News newsObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_zambia.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_zambia.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return zambiaMapper.queryZambia(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Zambia> queryZambia(News newsObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_zambia.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_zambia.userObj='" + userObj.getUser_name() + "'";
    	return zambiaMapper.queryZambiaList(where);
    }

    /*查询所有新闻赞记录*/
    public ArrayList<Zambia> queryAllZambia()  throws Exception {
        return zambiaMapper.queryZambiaList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(News newsObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_zambia.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_zambia.userObj='" + userObj.getUser_name() + "'";
        recordNumber = zambiaMapper.queryZambiaCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻赞记录*/
    public Zambia getZambia(int zambiaId) throws Exception  {
        Zambia zambia = zambiaMapper.getZambia(zambiaId);
        return zambia;
    }

    /*更新新闻赞记录*/
    public void updateZambia(Zambia zambia) throws Exception {
        zambiaMapper.updateZambia(zambia);
    }

    /*删除一条新闻赞记录*/
    public void deleteZambia (int zambiaId) throws Exception {
        zambiaMapper.deleteZambia(zambiaId);
    }

    /*删除多条新闻赞信息*/
    public int deleteZambias (String zambiaIds) throws Exception {
    	String _zambiaIds[] = zambiaIds.split(",");
    	for(String _zambiaId: _zambiaIds) {
    		zambiaMapper.deleteZambia(Integer.parseInt(_zambiaId));
    	}
    	return _zambiaIds.length;
    }
}
