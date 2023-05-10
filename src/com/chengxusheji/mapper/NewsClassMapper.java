package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.NewsClass;

public interface NewsClassMapper {
	/*添加新闻分类信息*/
	public void addNewsClass(NewsClass newsClass) throws Exception;

	/*按照查询条件分页查询新闻分类记录*/
	public ArrayList<NewsClass> queryNewsClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻分类记录*/
	public ArrayList<NewsClass> queryNewsClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻分类记录数*/
	public int queryNewsClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻分类记录*/
	public NewsClass getNewsClass(int newsClassId) throws Exception;

	/*更新新闻分类记录*/
	public void updateNewsClass(NewsClass newsClass) throws Exception;

	/*删除新闻分类记录*/
	public void deleteNewsClass(int newsClassId) throws Exception;

}
