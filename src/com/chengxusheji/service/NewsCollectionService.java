package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.News;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.NewsCollection;

import com.chengxusheji.mapper.NewsCollectionMapper;
@Service
public class NewsCollectionService {

	@Resource NewsCollectionMapper newsCollectionMapper;
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

    /*添加新闻收藏记录*/
    public void addNewsCollection(NewsCollection newsCollection) throws Exception {
    	newsCollectionMapper.addNewsCollection(newsCollection);
    }

    /*按照查询条件分页查询新闻收藏记录*/
    public ArrayList<NewsCollection> queryNewsCollection(News newsObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsCollection.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_newsCollection.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return newsCollectionMapper.queryNewsCollection(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<NewsCollection> queryNewsCollection(News newsObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsCollection.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_newsCollection.userObj='" + userObj.getUser_name() + "'";
    	return newsCollectionMapper.queryNewsCollectionList(where);
    }

    /*查询所有新闻收藏记录*/
    public ArrayList<NewsCollection> queryAllNewsCollection()  throws Exception {
        return newsCollectionMapper.queryNewsCollectionList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(News newsObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsCollection.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_newsCollection.userObj='" + userObj.getUser_name() + "'";
        recordNumber = newsCollectionMapper.queryNewsCollectionCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻收藏记录*/
    public NewsCollection getNewsCollection(int collectionId) throws Exception  {
        NewsCollection newsCollection = newsCollectionMapper.getNewsCollection(collectionId);
        return newsCollection;
    }

    /*更新新闻收藏记录*/
    public void updateNewsCollection(NewsCollection newsCollection) throws Exception {
        newsCollectionMapper.updateNewsCollection(newsCollection);
    }

    /*删除一条新闻收藏记录*/
    public void deleteNewsCollection (int collectionId) throws Exception {
        newsCollectionMapper.deleteNewsCollection(collectionId);
    }

    /*删除多条新闻收藏信息*/
    public int deleteNewsCollections (String collectionIds) throws Exception {
    	String _collectionIds[] = collectionIds.split(",");
    	for(String _collectionId: _collectionIds) {
    		newsCollectionMapper.deleteNewsCollection(Integer.parseInt(_collectionId));
    	}
    	return _collectionIds.length;
    }
}
