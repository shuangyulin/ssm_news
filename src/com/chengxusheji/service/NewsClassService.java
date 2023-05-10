package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.NewsClass;

import com.chengxusheji.mapper.NewsClassMapper;
@Service
public class NewsClassService {

	@Resource NewsClassMapper newsClassMapper;
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

    /*添加新闻分类记录*/
    public void addNewsClass(NewsClass newsClass) throws Exception {
    	newsClassMapper.addNewsClass(newsClass);
    }

    /*按照查询条件分页查询新闻分类记录*/
    public ArrayList<NewsClass> queryNewsClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return newsClassMapper.queryNewsClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<NewsClass> queryNewsClass() throws Exception  { 
     	String where = "where 1=1";
    	return newsClassMapper.queryNewsClassList(where);
    }

    /*查询所有新闻分类记录*/
    public ArrayList<NewsClass> queryAllNewsClass()  throws Exception {
        return newsClassMapper.queryNewsClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = newsClassMapper.queryNewsClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻分类记录*/
    public NewsClass getNewsClass(int newsClassId) throws Exception  {
        NewsClass newsClass = newsClassMapper.getNewsClass(newsClassId);
        return newsClass;
    }

    /*更新新闻分类记录*/
    public void updateNewsClass(NewsClass newsClass) throws Exception {
        newsClassMapper.updateNewsClass(newsClass);
    }

    /*删除一条新闻分类记录*/
    public void deleteNewsClass (int newsClassId) throws Exception {
        newsClassMapper.deleteNewsClass(newsClassId);
    }

    /*删除多条新闻分类信息*/
    public int deleteNewsClasss (String newsClassIds) throws Exception {
    	String _newsClassIds[] = newsClassIds.split(",");
    	for(String _newsClassId: _newsClassIds) {
    		newsClassMapper.deleteNewsClass(Integer.parseInt(_newsClassId));
    	}
    	return _newsClassIds.length;
    }
}
