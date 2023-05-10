package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.NewsCollection;

public interface NewsCollectionMapper {
	/*添加新闻收藏信息*/
	public void addNewsCollection(NewsCollection newsCollection) throws Exception;

	/*按照查询条件分页查询新闻收藏记录*/
	public ArrayList<NewsCollection> queryNewsCollection(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻收藏记录*/
	public ArrayList<NewsCollection> queryNewsCollectionList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻收藏记录数*/
	public int queryNewsCollectionCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻收藏记录*/
	public NewsCollection getNewsCollection(int collectionId) throws Exception;

	/*更新新闻收藏记录*/
	public void updateNewsCollection(NewsCollection newsCollection) throws Exception;

	/*删除新闻收藏记录*/
	public void deleteNewsCollection(int collectionId) throws Exception;

}
