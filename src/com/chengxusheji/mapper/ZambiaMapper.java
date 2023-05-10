package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Zambia;

public interface ZambiaMapper {
	/*添加新闻赞信息*/
	public void addZambia(Zambia zambia) throws Exception;

	/*按照查询条件分页查询新闻赞记录*/
	public ArrayList<Zambia> queryZambia(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有新闻赞记录*/
	public ArrayList<Zambia> queryZambiaList(@Param("where") String where) throws Exception;

	/*按照查询条件的新闻赞记录数*/
	public int queryZambiaCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条新闻赞记录*/
	public Zambia getZambia(int zambiaId) throws Exception;

	/*更新新闻赞记录*/
	public void updateZambia(Zambia zambia) throws Exception;

	/*删除新闻赞记录*/
	public void deleteZambia(int zambiaId) throws Exception;

}
