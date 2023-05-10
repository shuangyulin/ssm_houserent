package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.PriceRange;

public interface PriceRangeMapper {
	/*添加租金范围信息*/
	public void addPriceRange(PriceRange priceRange) throws Exception;

	/*按照查询条件分页查询租金范围记录*/
	public ArrayList<PriceRange> queryPriceRange(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有租金范围记录*/
	public ArrayList<PriceRange> queryPriceRangeList(@Param("where") String where) throws Exception;

	/*按照查询条件的租金范围记录数*/
	public int queryPriceRangeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条租金范围记录*/
	public PriceRange getPriceRange(int rangeId) throws Exception;

	/*更新租金范围记录*/
	public void updatePriceRange(PriceRange priceRange) throws Exception;

	/*删除租金范围记录*/
	public void deletePriceRange(int rangeId) throws Exception;

}
