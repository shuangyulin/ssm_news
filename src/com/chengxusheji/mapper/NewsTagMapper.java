package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.NewsTag;

public interface NewsTagMapper {
	/*添加新闻标记信息*/
	public void addNewsTag(NewsTag newsTag) throws Exception;

	/*按照查询条件分页查询新闻标记记录*/
	public ArrayList<NewsTag> queryNewsTag(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻标记记录*/
	public ArrayList<NewsTag> queryNewsTagList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻标记记录数*/
	public int queryNewsTagCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻标记记录*/
	public NewsTag getNewsTag(int tagId) throws Exception;

	/*更新新闻标记记录*/
	public void updateNewsTag(NewsTag newsTag) throws Exception;

	/*删除新闻标记记录*/
	public void deleteNewsTag(int tagId) throws Exception;

}
