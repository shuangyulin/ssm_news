package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.News;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.NewsTag;

import com.chengxusheji.mapper.NewsTagMapper;
@Service
public class NewsTagService {

	@Resource NewsTagMapper newsTagMapper;
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

    /*添加新闻标记记录*/
    public void addNewsTag(NewsTag newsTag) throws Exception {
    	newsTagMapper.addNewsTag(newsTag);
    }

    /*按照查询条件分页查询新闻标记记录*/
    public ArrayList<NewsTag> queryNewsTag(News newsObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsTag.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_newsTag.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return newsTagMapper.queryNewsTag(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<NewsTag> queryNewsTag(News newsObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsTag.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_newsTag.userObj='" + userObj.getUser_name() + "'";
    	return newsTagMapper.queryNewsTagList(where);
    }

    /*查询所有新闻标记记录*/
    public ArrayList<NewsTag> queryAllNewsTag()  throws Exception {
        return newsTagMapper.queryNewsTagList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(News newsObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsTag.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_newsTag.userObj='" + userObj.getUser_name() + "'";
        recordNumber = newsTagMapper.queryNewsTagCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻标记记录*/
    public NewsTag getNewsTag(int tagId) throws Exception  {
        NewsTag newsTag = newsTagMapper.getNewsTag(tagId);
        return newsTag;
    }

    /*更新新闻标记记录*/
    public void updateNewsTag(NewsTag newsTag) throws Exception {
        newsTagMapper.updateNewsTag(newsTag);
    }

    /*删除一条新闻标记记录*/
    public void deleteNewsTag (int tagId) throws Exception {
        newsTagMapper.deleteNewsTag(tagId);
    }

    /*删除多条新闻标记信息*/
    public int deleteNewsTags (String tagIds) throws Exception {
    	String _tagIds[] = tagIds.split(",");
    	for(String _tagId: _tagIds) {
    		newsTagMapper.deleteNewsTag(Integer.parseInt(_tagId));
    	}
    	return _tagIds.length;
    }
}
