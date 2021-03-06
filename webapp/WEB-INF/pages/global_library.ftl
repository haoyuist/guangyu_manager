<#if vm.getEvnVariable() == "on">
<#assign static_domain = "http://static.guangfish.com"> 
<#else>
<#assign static_domain = "http://static.guangfish.com"> 
</#if>
<#assign static_version = "2018">

<#assign basePath = request.contextPath>

<#--插入页面 -->
<#macro include page>
<#include "${page}">
</#macro>

<#--插入页头 -->
<#macro webhead>
<@include page="common/top.ftl" />
</#macro>

<#--插入页头 -->
<#macro webheadTmp>
<@include page="templates/common/commonCss.ftl" />
</#macro>

<#-- -->
<#macro webendTmp>
<@include page="templates/common/commonJS.ftl" />
</#macro>

<#--页面头部公用部分-->
<#macro webMenu current child>
<div class="wrapper clearfix">
    <div class="sidebar">
        <div class="nav-sidebar">
            <h2><img src="/static/images/logo2.png" style="width:156px;"></h2>
            <ul>
            <#local menu = vm.getMenuList() />
            <#if (menu?exists && menu?size > 0)>
            <#list menu as res>
            <li<#if (res.childList?exists && res.childList?size > 0)> class="drop-down <#if current=="${res.tip?if_exists}">on</#if>"<#else><#if current=="${res.tip?if_exists}"> class="on"</#if></#if>>
                <a href="${res.url?if_exists}">
                    <span class="${res.icon?if_exists}"></span>
                    <p>${res.text?if_exists}</p>
                </a>
                <#if (res.childList?exists && res.childList?size > 0)>
                    <ul class="collapse">
                    <#list res.childList as l>
                        <li <#if child=="${l.tip?if_exists}">class="on"</#if>>
                            <a href="${l.url?if_exists}">${l.text?if_exists}</a>
                        </li>
                    </#list>
                    </ul>
                </#if>
            </li>
            </#list>
            </#if>
            </ul>
        </div>
    </div>
    <div class="main">
        <div class="main-wrap">
            <header class="clearfix">
                <div class="head">
                    <h1><img src="/static/images/logo4.png"></h1>
                    <div class="head-right">
                        <a href="javascript:;" class="user-name"><@shiro.principal /></a>
                        <a href="javascript:;" class="sign-out" title="退出">退出</a>
                    </div>
                </div>
            </header>
</#macro>

<#--插入菜单头部 -->
<#macro menutop>
<header class="clearfix">
			<div class="head">
				<h1><img src="${model.static_domain}/images/login_logo.png"></h1>
				<div class="head-right">
					<a href="javascript:void(0);" class="user-name"><@shiro.principal /></a>
					<a href="javascript:void(0);" class="sign-out">退 出</a>
				</div>
			</div>
</header>
<div class="top"></div>
</#macro>


<#--菜单新增-->
<#macro webMenuTmp>
             <ul class="sidebar-menu" data-widget="tree">
            <#local menu = vm.getMenuList() />
            <#if (menu?exists && menu?size > 0)>
            <#list menu as res>
            <li  class=" treeviewactive">
               <a href="${res.url?if_exists}">
                   <i class="fa fa-dashboard"></i> <span>${res.text?if_exists}</span>
                   <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
               </a>
               <ul class="treeview-menu">
                   <#if (res.childList?exists && res.childList?size > 0)>
                       <#list res.childList as l>
                        <li>
                            <a href="${l.url?if_exists}">${l.text?if_exists}</a> <i class="fa fa-circle-o"></i>
                        </li>
                       </#list>
                   </#if>
               </ul>
           </li>
           </#list>
           </#if>
            </ul>
</#macro>

<#--插入菜单左边 -->
<#macro menuleft current child>
<aside>
	<div class="sub-nav">
		<ul>
			<#local menu = vm.getMenuList() />
			<#list menu as res>
				<li<#if current=="${res.tip?if_exists}"> class="on"</#if>>
					<a href="${res.url?if_exists}">
						<span class="${res.icon?if_exists}"></span>
						${res.text?if_exists}
					</a>
					<#if (res.childList?exists && res.childList?size > 0)>
						<i class="s-caret"></i>
					    <div class="collapse"> 
					        <#list res.childList as l>
					             <a <#if child=="${l.tip?if_exists}"> class="on"</#if> href="${l.url?if_exists}">${l.text?if_exists}</a>
					        </#list>
					    </div>
					</#if>
				</li>
			</#list>
		</ul>
	</div>
</aside>
</#macro>

<#--插入页头 -->
<#macro webhead>
<@include page="common/top.ftl" />
</#macro>

<#--插入页尾 -->
<#macro webend>
<@include page="common/end.ftl" />
</#macro>

<#--插入页头 -->
<#macro webheadsearch>
<@include page="search/top.ftl" />
</#macro>

<#--插入页尾 -->
<#macro webendsearch>
<@include page="search/end.ftl" />
</#macro>

<#--插入JS-->
<#macro includeJs jsList>
<#list jsList?split(",") as js>
<script type="text/javascript" charset="utf-8" src="<#if !(js?starts_with('/'))>${jsPash?if_exists}/</#if>${js}"></script>
</#list>
</#macro>

<#macro includeEditorJs>
<@model.includeJs jsList="/editor/editor_config.js"/>
<@model.includeJs jsList="/editor/editor_all.js"/>
<link rel="stylesheet" type="text/css" href="/editor/themes/default/ueditor.css"/>
</#macro>

<#macro includeDateInputJs>
<@model.includeJs jsList="plugins/date_input.js"/>
<link href="/themes/date_input.css" type="text/css" rel="stylesheet" media="screen" />
</#macro>

<#macro includeUploadJs>
<@model.includeJs jsList="upload/fileprogress.js,upload/swfupload.js,upload/swfupload.queue.js,upload/upload.js"/>
<link href="/themes/upload.css" type="text/css" rel="stylesheet" media="screen" />
</#macro>

<#macro interactiondPic type matterSize imgSize value="-1" className="select">
	<a href="javaScript:;" id="upload${type}">上传素材
		<input id="file${type}" type="file" multiple="true" name="file" onchange="uploadPic('${type}','${matterSize}','${imgSize}')">
	</a>
	<input type="hidden" name="interactionName${type}" value="" id="file${type}name"/>		
	<input type="hidden" name="interactionMatterSize${type}" value="" id="file${type}matterSize" />
	<input type="hidden" name="interactionActualPath${type}" value="" id="file${type}actualPath"/>
	<input type="hidden" name="interactionSize${type}" value="" id="file${type}size"/>
</#macro>
<#--列表翻页共同处理-->
<#macro showPage url p parEnd colsnum hasExport="0" hasBatch="0" startname="start" sizename="size">
<#assign split = "?" />
<#if (url?index_of("?")>0)><#assign split = "&" /></#if>
<#if (!parEnd?starts_with("&"))><#local parEnd = "&"+parEnd /></#if>
<tfoot>
	<tr>
		<td colspan="${colsnum}">
			<#if hasExport == "1">
			<a href="javascript:void(0);" id="exportBtn" class="btn btn-primary">导出</a>
			</#if>
			<div class="page">
				<a>共${p.totalRow}条</a>
				<#if (p.previousPage > 0)>
				<a href="${url}${split}${startname}=${p.prePage.startRow}&${sizename}=${p.showNum}${parEnd?if_exists}"><i>‹</i></a>
				</#if>
				<#if (p.startPage!=1)>
				<a href="${url}${split}${startname}=0&${sizename}=${p.showNum}${parEnd?if_exists}">1</a>
				<a>...</a>
				</#if>
				<#list p.getVPages() as pp>
					<#if (pp.page == p.currentPage )> 
						<a href="javascript:void(0);" onclick="return false;" class="current">${pp.page}</a>
					<#else>
						<a href="${url}${split}${startname}=${pp.startRow}&${sizename}=${p.showNum}${parEnd?if_exists}">${pp.page}</a>
					</#if>
				</#list>
				<#if (p.totalPage!=p.endPage)>
				<a>...</a>
				<a href="${url}${split}${startname}=${p.lastPageStartRow}&${sizename}=${p.showNum}${parEnd?if_exists}">${p.totalPage}</a>
				</#if>
				<#if (p.nextPage > 0)>
				<a href="${url}${split}${startname}=${p.NPage.startRow}&${sizename}=${p.showNum}${parEnd?if_exists}"><i>›</i></a>
				</#if>
			</div>
		</td>
	</tr>
</tfoot>
</#macro>

<#-- 下拉框选项是否选中共同处理  -->
<#function isSelected value select="-1">
	<#if "${value}"=="${select}">
		<#return "selected=\"true\"" />
	<#else>
		<#return "" />
	</#if>
</#function>

<#-- 下拉框选项共同处理  -->
<#macro showOption value title select="-1" >
<option value="${value?if_exists}" ${isSelected("${value?if_exists}","${select?if_exists}")} >${title?if_exists}</option>
</#macro>

<#-- 地区下拉框  -->
<#macro showPartition name value="-1" className="select">
<select name="${name}" class="${className}">
    <#local list = vm.getZoneList() />
    <#if (list?exists && list?size > 0)>
    <#list list as res>
        <@showOption value="${res?if_exists}" title="${res?if_exists}" select="${value?if_exists}" />
    </#list>
    </#if>
</select>
</#macro>

<#-- 纠错任务状态下拉选项  -->
<#macro showJiucuoTaskStatusOps value="-1">
	<#local list = vm.getJiucuoTaskStatusList() />
    <#if (list?exists && list?size > 0)>
		<#list list as res>
			<@showOption value="${res.id?if_exists}" title="${res.text?if_exists}" select="${value?if_exists}" />
		</#list>
	</#if>
</#macro>

<#-- 监测任务状态下拉选项  -->
<#macro showMonitorTaskStatusOps value="-1">
	<#local list = vm.getMonitorTaskStatusList() />
    <#if (list?exists && list?size > 0)>
		<#list list as res>
			<@showOption value="${res.id?if_exists}" title="${res.text?if_exists}" select="${value?if_exists}" />
		</#list>
	</#if>
</#macro>

<#-- 活动状态下拉选项  -->
<#macro showActivityStatusOps value="-1">
	<#local list = vm.getActivityStatusList() />
    <#if (list?exists && list?size > 0)>
		<#list list as res>
			<@showOption value="${res.id?if_exists}" title="${res.text?if_exists}" select="${value?if_exists}" />
		</#list>
	</#if>
</#macro>

<#-- 所有活动下拉选项  -->
<#macro showAllActivityOps value="-1">
	<#local list = vm.getAllActivity() />
	<#if (list?exists && list?size > 0)>
		<#list list as res>
			<@showOption value="${res.id?if_exists}" title="${res.activityName?if_exists}" select="${value?if_exists}" />
		</#list>
	</#if>
</#macro>

<#-- 拥有活动下拉选项  -->
<#macro showOwnActivityOps value="-1">
	<#local list = vm.getOwnActivity() />
	<#if (list?exists && list?size > 0)>
		<#list list as res>
			<@showOption value="${res.id?if_exists}" title="${res.activityName?if_exists}" select="${value?if_exists}" />
		</#list>
	</#if>
</#macro>
