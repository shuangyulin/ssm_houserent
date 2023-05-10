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
import com.chengxusheji.service.HourseService;
import com.chengxusheji.po.Hourse;
import com.chengxusheji.service.BuildingInfoService;
import com.chengxusheji.po.BuildingInfo;
import com.chengxusheji.service.HourseTypeService;
import com.chengxusheji.po.HourseType;
import com.chengxusheji.service.PriceRangeService;
import com.chengxusheji.po.PriceRange;

//Hourse管理控制层
@Controller
@RequestMapping("/Hourse")
public class HourseController extends BaseController {

    /*业务层对象*/
    @Resource HourseService hourseService;

    @Resource BuildingInfoService buildingInfoService;
    @Resource HourseTypeService hourseTypeService;
    @Resource PriceRangeService priceRangeService;
	@InitBinder("buildingObj")
	public void initBinderbuildingObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("buildingObj.");
	}
	@InitBinder("hourseTypeObj")
	public void initBinderhourseTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("hourseTypeObj.");
	}
	@InitBinder("priceRangeObj")
	public void initBinderpriceRangeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("priceRangeObj.");
	}
	@InitBinder("hourse")
	public void initBinderHourse(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("hourse.");
	}
	/*跳转到添加Hourse视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Hourse());
		/*查询所有的BuildingInfo信息*/
		List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
		request.setAttribute("buildingInfoList", buildingInfoList);
		/*查询所有的HourseType信息*/
		List<HourseType> hourseTypeList = hourseTypeService.queryAllHourseType();
		request.setAttribute("hourseTypeList", hourseTypeList);
		/*查询所有的PriceRange信息*/
		List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
		request.setAttribute("priceRangeList", priceRangeList);
		return "Hourse_add";
	}

	/*客户端ajax方式提交添加房屋信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Hourse hourse, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			hourse.setHousePhoto(this.handlePhotoUpload(request, "housePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        hourseService.addHourse(hourse);
        message = "房屋信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询房屋信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String hourseName,@ModelAttribute("buildingObj") BuildingInfo buildingObj,@ModelAttribute("hourseTypeObj") HourseType hourseTypeObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,String madeYear,String connectPerson,String connectPhone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (hourseName == null) hourseName = "";
		if (madeYear == null) madeYear = "";
		if (connectPerson == null) connectPerson = "";
		if (connectPhone == null) connectPhone = "";
		if(rows != 0)hourseService.setRows(rows);
		List<Hourse> hourseList = hourseService.queryHourse(hourseName, buildingObj, hourseTypeObj, priceRangeObj, madeYear, connectPerson, connectPhone, page);
	    /*计算总的页数和总的记录数*/
	    hourseService.queryTotalPageAndRecordNumber(hourseName, buildingObj, hourseTypeObj, priceRangeObj, madeYear, connectPerson, connectPhone);
	    /*获取到总的页码数目*/
	    int totalPage = hourseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = hourseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Hourse hourse:hourseList) {
			JSONObject jsonHourse = hourse.getJsonObject();
			jsonArray.put(jsonHourse);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询房屋信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Hourse> hourseList = hourseService.queryAllHourse();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Hourse hourse:hourseList) {
			JSONObject jsonHourse = new JSONObject();
			jsonHourse.accumulate("hourseId", hourse.getHourseId());
			jsonHourse.accumulate("hourseName", hourse.getHourseName());
			jsonArray.put(jsonHourse);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询房屋信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String hourseName,@ModelAttribute("buildingObj") BuildingInfo buildingObj,@ModelAttribute("hourseTypeObj") HourseType hourseTypeObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,String madeYear,String connectPerson,String connectPhone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (hourseName == null) hourseName = "";
		if (madeYear == null) madeYear = "";
		if (connectPerson == null) connectPerson = "";
		if (connectPhone == null) connectPhone = "";
		List<Hourse> hourseList = hourseService.queryHourse(hourseName, buildingObj, hourseTypeObj, priceRangeObj, madeYear, connectPerson, connectPhone, currentPage);
	    /*计算总的页数和总的记录数*/
	    hourseService.queryTotalPageAndRecordNumber(hourseName, buildingObj, hourseTypeObj, priceRangeObj, madeYear, connectPerson, connectPhone);
	    /*获取到总的页码数目*/
	    int totalPage = hourseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = hourseService.getRecordNumber();
	    request.setAttribute("hourseList",  hourseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("hourseName", hourseName);
	    request.setAttribute("buildingObj", buildingObj);
	    request.setAttribute("hourseTypeObj", hourseTypeObj);
	    request.setAttribute("priceRangeObj", priceRangeObj);
	    request.setAttribute("madeYear", madeYear);
	    request.setAttribute("connectPerson", connectPerson);
	    request.setAttribute("connectPhone", connectPhone);
	    List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
	    request.setAttribute("buildingInfoList", buildingInfoList);
	    List<HourseType> hourseTypeList = hourseTypeService.queryAllHourseType();
	    request.setAttribute("hourseTypeList", hourseTypeList);
	    List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
	    request.setAttribute("priceRangeList", priceRangeList);
		return "Hourse/hourse_frontquery_result"; 
	}

     /*前台查询Hourse信息*/
	@RequestMapping(value="/{hourseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer hourseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键hourseId获取Hourse对象*/
        Hourse hourse = hourseService.getHourse(hourseId);

        List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
        request.setAttribute("buildingInfoList", buildingInfoList);
        List<HourseType> hourseTypeList = hourseTypeService.queryAllHourseType();
        request.setAttribute("hourseTypeList", hourseTypeList);
        List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
        request.setAttribute("priceRangeList", priceRangeList);
        request.setAttribute("hourse",  hourse);
        return "Hourse/hourse_frontshow";
	}

	/*ajax方式显示房屋信息修改jsp视图页*/
	@RequestMapping(value="/{hourseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer hourseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键hourseId获取Hourse对象*/
        Hourse hourse = hourseService.getHourse(hourseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonHourse = hourse.getJsonObject();
		out.println(jsonHourse.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新房屋信息信息*/
	@RequestMapping(value = "/{hourseId}/update", method = RequestMethod.POST)
	public void update(@Validated Hourse hourse, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String housePhotoFileName = this.handlePhotoUpload(request, "housePhotoFile");
		if(!housePhotoFileName.equals("upload/NoImage.jpg"))hourse.setHousePhoto(housePhotoFileName); 


		try {
			hourseService.updateHourse(hourse);
			message = "房屋信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "房屋信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除房屋信息信息*/
	@RequestMapping(value="/{hourseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer hourseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  hourseService.deleteHourse(hourseId);
	            request.setAttribute("message", "房屋信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "房屋信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条房屋信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String hourseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = hourseService.deleteHourses(hourseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出房屋信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String hourseName,@ModelAttribute("buildingObj") BuildingInfo buildingObj,@ModelAttribute("hourseTypeObj") HourseType hourseTypeObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,String madeYear,String connectPerson,String connectPhone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(hourseName == null) hourseName = "";
        if(madeYear == null) madeYear = "";
        if(connectPerson == null) connectPerson = "";
        if(connectPhone == null) connectPhone = "";
        List<Hourse> hourseList = hourseService.queryHourse(hourseName,buildingObj,hourseTypeObj,priceRangeObj,madeYear,connectPerson,connectPhone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Hourse信息记录"; 
        String[] headers = { "房屋名称","所在楼盘","房屋图片","房屋类型","价格范围","面积","租金(元/月)","楼层/总楼层","装修","朝向","建筑年代","联系人","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<hourseList.size();i++) {
        	Hourse hourse = hourseList.get(i); 
        	dataset.add(new String[]{hourse.getHourseName(),hourse.getBuildingObj().getBuildingName(),hourse.getHousePhoto(),hourse.getHourseTypeObj().getTypeName(),hourse.getPriceRangeObj().getPriceName(),hourse.getArea(),hourse.getPrice() + "",hourse.getLouceng(),hourse.getZhuangxiu(),hourse.getCaoxiang(),hourse.getMadeYear(),hourse.getConnectPerson(),hourse.getConnectPhone()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Hourse.xls");//filename是下载的xls的名，建议最好用英文 
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
