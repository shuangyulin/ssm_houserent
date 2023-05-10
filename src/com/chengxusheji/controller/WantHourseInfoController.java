package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.WantHourseInfoService;
import com.chengxusheji.po.WantHourseInfo;
import com.chengxusheji.service.AreaInfoService;
import com.chengxusheji.po.AreaInfo;
import com.chengxusheji.service.HourseTypeService;
import com.chengxusheji.po.HourseType;
import com.chengxusheji.service.PriceRangeService;
import com.chengxusheji.po.PriceRange;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//WantHourseInfo管理控制层
@Controller
@RequestMapping("/WantHourseInfo")
public class WantHourseInfoController extends BaseController {

    /*业务层对象*/
    @Resource WantHourseInfoService wantHourseInfoService;

    @Resource AreaInfoService areaInfoService;
    @Resource HourseTypeService hourseTypeService;
    @Resource PriceRangeService priceRangeService;
    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("position")
	public void initBinderposition(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("position.");
	}
	@InitBinder("hourseTypeObj")
	public void initBinderhourseTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("hourseTypeObj.");
	}
	@InitBinder("priceRangeObj")
	public void initBinderpriceRangeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("priceRangeObj.");
	}
	@InitBinder("wantHourseInfo")
	public void initBinderWantHourseInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("wantHourseInfo.");
	}
	/*跳转到添加WantHourseInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new WantHourseInfo());
		/*查询所有的AreaInfo信息*/
		List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
		request.setAttribute("areaInfoList", areaInfoList);
		/*查询所有的HourseType信息*/
		List<HourseType> hourseTypeList = hourseTypeService.queryAllHourseType();
		request.setAttribute("hourseTypeList", hourseTypeList);
		/*查询所有的PriceRange信息*/
		List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
		request.setAttribute("priceRangeList", priceRangeList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "WantHourseInfo_add";
	}

	/*客户端ajax方式提交添加求租信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated WantHourseInfo wantHourseInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        wantHourseInfoService.addWantHourseInfo(wantHourseInfo);
        message = "求租信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询求租信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,String title,@ModelAttribute("position") AreaInfo position,@ModelAttribute("hourseTypeObj") HourseType hourseTypeObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if(rows != 0)wantHourseInfoService.setRows(rows);
		List<WantHourseInfo> wantHourseInfoList = wantHourseInfoService.queryWantHourseInfo(userObj, title, position, hourseTypeObj, priceRangeObj, page);
	    /*计算总的页数和总的记录数*/
	    wantHourseInfoService.queryTotalPageAndRecordNumber(userObj, title, position, hourseTypeObj, priceRangeObj);
	    /*获取到总的页码数目*/
	    int totalPage = wantHourseInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = wantHourseInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(WantHourseInfo wantHourseInfo:wantHourseInfoList) {
			JSONObject jsonWantHourseInfo = wantHourseInfo.getJsonObject();
			jsonArray.put(jsonWantHourseInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询求租信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<WantHourseInfo> wantHourseInfoList = wantHourseInfoService.queryAllWantHourseInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(WantHourseInfo wantHourseInfo:wantHourseInfoList) {
			JSONObject jsonWantHourseInfo = new JSONObject();
			jsonWantHourseInfo.accumulate("wantHourseId", wantHourseInfo.getWantHourseId());
			jsonWantHourseInfo.accumulate("title", wantHourseInfo.getTitle());
			jsonArray.put(jsonWantHourseInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询求租信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,String title,@ModelAttribute("position") AreaInfo position,@ModelAttribute("hourseTypeObj") HourseType hourseTypeObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		List<WantHourseInfo> wantHourseInfoList = wantHourseInfoService.queryWantHourseInfo(userObj, title, position, hourseTypeObj, priceRangeObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    wantHourseInfoService.queryTotalPageAndRecordNumber(userObj, title, position, hourseTypeObj, priceRangeObj);
	    /*获取到总的页码数目*/
	    int totalPage = wantHourseInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = wantHourseInfoService.getRecordNumber();
	    request.setAttribute("wantHourseInfoList",  wantHourseInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("title", title);
	    request.setAttribute("position", position);
	    request.setAttribute("hourseTypeObj", hourseTypeObj);
	    request.setAttribute("priceRangeObj", priceRangeObj);
	    List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
	    request.setAttribute("areaInfoList", areaInfoList);
	    List<HourseType> hourseTypeList = hourseTypeService.queryAllHourseType();
	    request.setAttribute("hourseTypeList", hourseTypeList);
	    List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
	    request.setAttribute("priceRangeList", priceRangeList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "WantHourseInfo/wantHourseInfo_frontquery_result"; 
	}

     /*前台查询WantHourseInfo信息*/
	@RequestMapping(value="/{wantHourseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer wantHourseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键wantHourseId获取WantHourseInfo对象*/
        WantHourseInfo wantHourseInfo = wantHourseInfoService.getWantHourseInfo(wantHourseId);

        List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
        request.setAttribute("areaInfoList", areaInfoList);
        List<HourseType> hourseTypeList = hourseTypeService.queryAllHourseType();
        request.setAttribute("hourseTypeList", hourseTypeList);
        List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
        request.setAttribute("priceRangeList", priceRangeList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("wantHourseInfo",  wantHourseInfo);
        return "WantHourseInfo/wantHourseInfo_frontshow";
	}

	/*ajax方式显示求租信息修改jsp视图页*/
	@RequestMapping(value="/{wantHourseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer wantHourseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键wantHourseId获取WantHourseInfo对象*/
        WantHourseInfo wantHourseInfo = wantHourseInfoService.getWantHourseInfo(wantHourseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonWantHourseInfo = wantHourseInfo.getJsonObject();
		out.println(jsonWantHourseInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新求租信息信息*/
	@RequestMapping(value = "/{wantHourseId}/update", method = RequestMethod.POST)
	public void update(@Validated WantHourseInfo wantHourseInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			wantHourseInfoService.updateWantHourseInfo(wantHourseInfo);
			message = "求租信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "求租信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除求租信息信息*/
	@RequestMapping(value="/{wantHourseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer wantHourseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  wantHourseInfoService.deleteWantHourseInfo(wantHourseId);
	            request.setAttribute("message", "求租信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "求租信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条求租信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String wantHourseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = wantHourseInfoService.deleteWantHourseInfos(wantHourseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出求租信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,String title,@ModelAttribute("position") AreaInfo position,@ModelAttribute("hourseTypeObj") HourseType hourseTypeObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        List<WantHourseInfo> wantHourseInfoList = wantHourseInfoService.queryWantHourseInfo(userObj,title,position,hourseTypeObj,priceRangeObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "WantHourseInfo信息记录"; 
        String[] headers = { "求租用户","标题","求租区域","房屋类型","价格范围","最高能出租金","联系人","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<wantHourseInfoList.size();i++) {
        	WantHourseInfo wantHourseInfo = wantHourseInfoList.get(i); 
        	dataset.add(new String[]{wantHourseInfo.getUserObj().getRealName(),wantHourseInfo.getTitle(),wantHourseInfo.getPosition().getAreaName(),wantHourseInfo.getHourseTypeObj().getTypeName(),wantHourseInfo.getPriceRangeObj().getPriceName(),wantHourseInfo.getPrice() + "",wantHourseInfo.getLianxiren(),wantHourseInfo.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"WantHourseInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
