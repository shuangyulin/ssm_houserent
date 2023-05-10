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
import com.chengxusheji.service.BuildingInfoService;
import com.chengxusheji.po.BuildingInfo;
import com.chengxusheji.service.AreaInfoService;
import com.chengxusheji.po.AreaInfo;

//BuildingInfo管理控制层
@Controller
@RequestMapping("/BuildingInfo")
public class BuildingInfoController extends BaseController {

    /*业务层对象*/
    @Resource BuildingInfoService buildingInfoService;

    @Resource AreaInfoService areaInfoService;
	@InitBinder("areaObj")
	public void initBinderareaObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("areaObj.");
	}
	@InitBinder("buildingInfo")
	public void initBinderBuildingInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("buildingInfo.");
	}
	/*跳转到添加BuildingInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BuildingInfo());
		/*查询所有的AreaInfo信息*/
		List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
		request.setAttribute("areaInfoList", areaInfoList);
		return "BuildingInfo_add";
	}

	/*客户端ajax方式提交添加楼盘信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BuildingInfo buildingInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			buildingInfo.setBuildingPhoto(this.handlePhotoUpload(request, "buildingPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        buildingInfoService.addBuildingInfo(buildingInfo);
        message = "楼盘信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询楼盘信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("areaObj") AreaInfo areaObj,String buildingName,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (buildingName == null) buildingName = "";
		if(rows != 0)buildingInfoService.setRows(rows);
		List<BuildingInfo> buildingInfoList = buildingInfoService.queryBuildingInfo(areaObj, buildingName, page);
	    /*计算总的页数和总的记录数*/
	    buildingInfoService.queryTotalPageAndRecordNumber(areaObj, buildingName);
	    /*获取到总的页码数目*/
	    int totalPage = buildingInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = buildingInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BuildingInfo buildingInfo:buildingInfoList) {
			JSONObject jsonBuildingInfo = buildingInfo.getJsonObject();
			jsonArray.put(jsonBuildingInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询楼盘信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BuildingInfo> buildingInfoList = buildingInfoService.queryAllBuildingInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BuildingInfo buildingInfo:buildingInfoList) {
			JSONObject jsonBuildingInfo = new JSONObject();
			jsonBuildingInfo.accumulate("buildingId", buildingInfo.getBuildingId());
			jsonBuildingInfo.accumulate("buildingName", buildingInfo.getBuildingName());
			jsonArray.put(jsonBuildingInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询楼盘信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("areaObj") AreaInfo areaObj,String buildingName,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (buildingName == null) buildingName = "";
		List<BuildingInfo> buildingInfoList = buildingInfoService.queryBuildingInfo(areaObj, buildingName, currentPage);
	    /*计算总的页数和总的记录数*/
	    buildingInfoService.queryTotalPageAndRecordNumber(areaObj, buildingName);
	    /*获取到总的页码数目*/
	    int totalPage = buildingInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = buildingInfoService.getRecordNumber();
	    request.setAttribute("buildingInfoList",  buildingInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("areaObj", areaObj);
	    request.setAttribute("buildingName", buildingName);
	    List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
	    request.setAttribute("areaInfoList", areaInfoList);
		return "BuildingInfo/buildingInfo_frontquery_result"; 
	}

     /*前台查询BuildingInfo信息*/
	@RequestMapping(value="/{buildingId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer buildingId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键buildingId获取BuildingInfo对象*/
        BuildingInfo buildingInfo = buildingInfoService.getBuildingInfo(buildingId);

        List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
        request.setAttribute("areaInfoList", areaInfoList);
        request.setAttribute("buildingInfo",  buildingInfo);
        return "BuildingInfo/buildingInfo_frontshow";
	}

	/*ajax方式显示楼盘信息修改jsp视图页*/
	@RequestMapping(value="/{buildingId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer buildingId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键buildingId获取BuildingInfo对象*/
        BuildingInfo buildingInfo = buildingInfoService.getBuildingInfo(buildingId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBuildingInfo = buildingInfo.getJsonObject();
		out.println(jsonBuildingInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新楼盘信息信息*/
	@RequestMapping(value = "/{buildingId}/update", method = RequestMethod.POST)
	public void update(@Validated BuildingInfo buildingInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String buildingPhotoFileName = this.handlePhotoUpload(request, "buildingPhotoFile");
		if(!buildingPhotoFileName.equals("upload/NoImage.jpg"))buildingInfo.setBuildingPhoto(buildingPhotoFileName); 


		try {
			buildingInfoService.updateBuildingInfo(buildingInfo);
			message = "楼盘信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "楼盘信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除楼盘信息信息*/
	@RequestMapping(value="/{buildingId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer buildingId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  buildingInfoService.deleteBuildingInfo(buildingId);
	            request.setAttribute("message", "楼盘信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "楼盘信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条楼盘信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String buildingIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = buildingInfoService.deleteBuildingInfos(buildingIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出楼盘信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("areaObj") AreaInfo areaObj,String buildingName, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(buildingName == null) buildingName = "";
        List<BuildingInfo> buildingInfoList = buildingInfoService.queryBuildingInfo(areaObj,buildingName);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BuildingInfo信息记录"; 
        String[] headers = { "楼盘编号","所在区域","楼盘名称","楼盘图片"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<buildingInfoList.size();i++) {
        	BuildingInfo buildingInfo = buildingInfoList.get(i); 
        	dataset.add(new String[]{buildingInfo.getBuildingId() + "",buildingInfo.getAreaObj().getAreaName(),buildingInfo.getBuildingName(),buildingInfo.getBuildingPhoto()});
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
			response.setHeader("Content-disposition","attachment; filename="+"BuildingInfo.xls");//filename是下载的xls的名，建议最好用英文 
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
