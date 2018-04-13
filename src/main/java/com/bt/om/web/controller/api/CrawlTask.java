package com.bt.om.web.controller.api;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.bt.om.util.GsonUtil;
import com.bt.om.util.HttpcomponentsUtil;

public class CrawlTask {

	private static String taskUrl = "https://www.gxzhservice.com/crawl/addTask";
	private static String loadDataUrl = "https://www.gxzhservice.com/crawl/loadData";
	private static int sleepTime = 6000;

	private String sendTask(String url) {
		List<NameValuePair> nvpList = new ArrayList<>();
		nvpList.add(new BasicNameValuePair("url", url));
		String retStr = "";
		try {
			String ret = HttpcomponentsUtil.postReq(nvpList, taskUrl);
			// System.out.println(ret);
			TaskBean taskBean = GsonUtil.GsonToBean(ret, TaskBean.class);
			// System.out.println(taskBean.getMap().get("sign"));
			retStr = taskBean.getMap().get("sign") + ";" + taskBean.getMap().get("type");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retStr;
	}

	private String loadData(String params) {
		List<NameValuePair> nvpList = new ArrayList<>();
		nvpList.add(new BasicNameValuePair("sign", params.split(";")[0]));
		nvpList.add(new BasicNameValuePair("type", params.split(";")[1]));
		String ret = "";
		try {
			ret = HttpcomponentsUtil.postReq(nvpList, loadDataUrl);
			System.out.println(ret);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	public TaskBean getProduct(String url) {
		String params = sendTask(url);

		String productInfo = loadData(params);
		TaskBean taskBean = GsonUtil.GsonToBean(productInfo, TaskBean.class);
		int i=0;
		while (true) {
			if(i>=30){
				break;
			}
			if (taskBean.getSucc() == true) {
				break;
			} else {
				try {
					Thread.sleep(500);
				} catch (Exception e) {
					e.printStackTrace();
				}
				productInfo = loadData(params);
				taskBean = GsonUtil.GsonToBean(productInfo, TaskBean.class);
			}
			i++;
		}
		return taskBean;
	}

	public static void main(String[] args) {
		CrawlTask crawlTask = new CrawlTask();
		TaskBean taskBean = crawlTask.getProduct("http://item.taobao.com/item.htm?id=546479931448");
		System.out.println(taskBean.getMsg());
	}

}