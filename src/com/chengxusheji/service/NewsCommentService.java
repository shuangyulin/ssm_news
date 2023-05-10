package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.News;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.NewsComment;

import com.chengxusheji.mapper.NewsCommentMapper;
@Service
public class NewsCommentService {

	@Resource NewsCommentMapper newsCommentMapper;
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

    /*添加新闻评论记录*/
    public void addNewsComment(NewsComment newsComment) throws Exception {
    	newsCommentMapper.addNewsComment(newsComment);
    }

    /*按照查询条件分页查询新闻评论记录*/
    public ArrayList<NewsComment> queryNewsComment(News newsObj,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsComment.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_newsComment.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return newsCommentMapper.queryNewsComment(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<NewsComment> queryNewsComment(News newsObj,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsComment.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_newsComment.userObj='" + userObj.getUser_name() + "'";
    	return newsCommentMapper.queryNewsCommentList(where);
    }

    /*查询所有新闻评论记录*/
    public ArrayList<NewsComment> queryAllNewsComment()  throws Exception {
        return newsCommentMapper.queryNewsCommentList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(News newsObj,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(null != newsObj && newsObj.getNewsId()!= null && newsObj.getNewsId()!= 0)  where += " and t_newsComment.newsObj=" + newsObj.getNewsId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_newsComment.userObj='" + userObj.getUser_name() + "'";
        recordNumber = newsCommentMapper.queryNewsCommentCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取新闻评论记录*/
    public NewsComment getNewsComment(int commentId) throws Exception  {
        NewsComment newsComment = newsCommentMapper.getNewsComment(commentId);
        return newsComment;
    }

    /*更新新闻评论记录*/
    public void updateNewsComment(NewsComment newsComment) throws Exception {
        newsCommentMapper.updateNewsComment(newsComment);
    }

    /*删除一条新闻评论记录*/
    public void deleteNewsComment (int commentId) throws Exception {
        newsCommentMapper.deleteNewsComment(commentId);
    }

    /*删除多条新闻评论信息*/
    public int deleteNewsComments (String commentIds) throws Exception {
    	String _commentIds[] = commentIds.split(",");
    	for(String _commentId: _commentIds) {
    		newsCommentMapper.deleteNewsComment(Integer.parseInt(_commentId));
    	}
    	return _commentIds.length;
    }
}
