package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.NewsComment;

public interface NewsCommentMapper {
	/*添加新闻评论信息*/
	public void addNewsComment(NewsComment newsComment) throws Exception;

	/*按照查询条件分页查询新闻评论记录*/
	public ArrayList<NewsComment> queryNewsComment(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻评论记录*/
	public ArrayList<NewsComment> queryNewsCommentList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻评论记录数*/
	public int queryNewsCommentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻评论记录*/
	public NewsComment getNewsComment(int commentId) throws Exception;

	/*更新新闻评论记录*/
	public void updateNewsComment(NewsComment newsComment) throws Exception;

	/*删除新闻评论记录*/
	public void deleteNewsComment(int commentId) throws Exception;

}
