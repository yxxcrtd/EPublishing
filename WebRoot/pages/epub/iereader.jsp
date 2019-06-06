<!DOCTYPE html>
<%@ include file="/common/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="CONTENT_PATH" value="<%=basePath %>"></c:set>

<html lang="zh-CN" class="ua-windows ">
<head>
<meta charset="utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Expires" content="Sun, 6 Mar 2005 01:00:00 GMT">
<meta name="google-site-verification"
	content="Wyui6dsg_StZ9K3rJ6xtsNbxPhELyhMkEp2MsAhviBQ">
<meta name="keywords" content="阅读,原创,自出版,写作,作者,电子书,免费,在线阅读" />
<meta name="description"
	content="在线阅读我拥有的优秀数字作品和出版社精品电子书，可以同步到 iPhone, iPad, Android 多设备随时随地阅读，支持批注、划线、分享、讨论。" />
<link rel="shortcut icon"
	href="${CONTENT_PATH }/ark/pics/favicon/favicon.ico?v=7728138265"
	type="image/x-icon">
<title></title>
<!--[if IE]><script src="${CONTENT_PATH }/ark/js/widget/html5-elements-4496665314.js"></script><![endif]-->
<script>
	(function() {
	})();
</script>
<meta name="viewport"
	content="minimal-ui user-scalable=no, width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="renderer" content="webkit" />
<meta property="weixin:image"
	content="${CONTENT_PATH }/ark/pics/weixin_cover.jpg?v=6256540224" />
<link rel="stylesheet"
	href="${CONTENT_PATH }/ark/css/galreader/galreader-3239564825.css" />
<link rel="stylesheet"
	href="${CONTENT_PATH }/ark/css/reader/index-1967910543.css" />
<link rel="stylesheet"
	href="${CONTENT_PATH }/ark/css/reader/ebook/index-9302270828.css"
	id="ebook-style-sheet" />
<link rel="stylesheet"
	href="${CONTENT_PATH }/ark/css/reader/gallery/index-1713725503.css"
	id="gallery-style-sheet" />
<link rel="stylesheet"
	href="${CONTENT_PATH }/ark/css/reader/lite-5979647643.css"
	id="column-style-sheet" />
<link rel="stylesheet"
	href="${CONTENT_PATH }/ark/css/reader/phone-1743494991.css"
	media="screen and (-webkit-min-device-pixel-ratio: 1.1) and (max-width: 720px), screen and (max-device-width: 480px)" />
<!--[if IE]><script src="${CONTENT_PATH }/ark/js/mod/browser-6294740651.js"></script><script>
      !function(){var Ark=window.Ark||{};window.Ark=Ark,Ark.requireAwesomeBrowser=function(options){var env=Ark.env,distUrl=options.fallback,distUrlHash="";env.nonsupport=env.msie&&env.msie<options.minIE,env.nonsupport&&(env.msie&&env.shell&&env.rank>0&&(distUrlHash=2===env.rank?"#requireChangeToWebkit":"#requireNewIE"),distUrlHash&&(distUrl+=distUrlHash),location.replace(distUrl))}}();

      Ark.requireAwesomeBrowser({
        fallback: "/awesome_browsers"
      , minIE: 8
      });
    </script><![endif]-->
</head>
<body>
	<div style="display:none;" id="home" class=""></div>
	<div style="display:none" id="notifications" class="">
		<header class="bookshelf-header">
			<div class="top-info">
				<div class="inner">
					<h1 class="logo">
						<a href="/" title="阅读">阅读</a><span class="section-name">我的阅读器</span>
					</h1>
					<div class="entrances">
						<a href="/app?icn=from-bookshelf" class="app-download icon-phone">客户端免费下载</a><a
							href="/" class="back-to-store icon-store">作品商店</a>
					</div>
				</div>
			</div>
			<nav class="nav">
				<div class="inner">
					<ul class="nav-main items">
						<li class=""><a href="/reader/ebooks">完整作品</a></li>
						<li class=""><a href="/reader/columns">专栏 / 连载</a></li>
						<li class=""><a href="/reader/collection/朱岳">朱岳</a></li>
						<li class=""><a href="/reader/collection/社会">社会</a></li>
						<li class=""><a href="/reader/collection/短篇小说">短篇小说</a></li>
						<li class=""><a href="/reader/collection/想象">想象</a></li>
						<li class=""><a href="/reader/collection/文学">文学</a></li>
					</ul>
					<ul class="items items-minor user-info">
						<!-- _performtips_ -->
						<li class="nav-reminder"><a href="/reader/notifications/">阅读提醒&nbsp;<span
								class="num notification-counter-tip"></span></a></li>
						<li class="nav-reminder"><a href="/account/billing"
							target="_blank">购买记录</a></li>
						<li class="more-active"><a href="/account/" title="账户"
							class="bn-more-hoverable"></a><a href="/account/" title="账户"
							class="name bn-more"><span>jack</span><span class="arrow"></span></a>
						<div class="more-items">
								<table>
									<tr>
										<td><a href="www.douban.com" target="_blank">首页</a></td>
									</tr>
									<tr>
										<td><a href="/account/" target="_blank">我的账户</a></td>
									</tr>
									<tr>
										<td><a href="/account/wishlist" target="_blank">心愿单</a></td>
									</tr>
									<tr>
										<td><a href="/account/setting" target="_blank">设置</a></td>
									</tr>
									<tr>
										<td><a href="/logout?ck=A5wm" class="logout">退出</a></td>
									</tr>
								</table>
								<script>
									// XXX: 提醒页属于阅读器没有 jQuery 和 Do。
									if (typeof Do !== 'undefined') {
										Do(function() {
											function toggleMenu(showOrHide) {
												menuContainer
														.toggle(showOrHide)
											}
											var moreActive = $(".more-active"), menuContainer = moreActive
													.find(".more-items"), bnMore = moreActive
													.find(".bn-more"), hoverableBtns = moreActive
													.find(".bn-more-hoverable")
													.add(bnMore), useClick = "undefined" != typeof window.ontouchstart;
											if (useClick) {
												var doc = $(document), menuContainerIsShown = !1, toggleMenuWithClick = function(
														showOrHide) {
															menuContainerIsShown ? doc
																	.off(".moreItems")
																	: doc
																			.on(
																					"click.moreItems",
																					function(
																							e) {
																						moreActive
																								.has(e.target).length
																								|| toggleMenuWithClick(!1)
																					}),
															menuContainerIsShown = !menuContainerIsShown,
															toggleMenu(showOrHide)
												};
												return bnMore.click(function() {
													toggleMenuWithClick()
												}), hoverableBtns
														.click(function(e) {
															e.preventDefault()
														}), void 0
											}
											var moreActiveIsHover = !1, moniterElements = $(
													hoverableBtns).add(
													menuContainer);
													moniterElements
															.mouseenter(
																	function() {
																				moreActiveIsHover = !0,
																				toggleMenu(!0)
																	})
															.mouseleave(
																	function() {
																				moreActiveIsHover = !1,
																				setTimeout(
																						function() {
																							moreActiveIsHover
																									|| toggleMenu(!1)
																						},
																						0)
																	}),
													menuContainer.on("click",
															"a", function() {
																toggleMenu(!1)
															})
										});
									}
								</script>
							</div></li>
					</ul>
				</div>
			</nav>
		</header>
		<div class="notifications-content">
			<div class="notifications-msg"></div>
			<ol class="notifications-list"></ol>
		</div>
		<script id="tmpl-notification-item" type="text/template">
{{
var predicateText = { comment: '回复' , favorite: '收藏' , author: '创建' };}}<div class="hd {{= is_read ? '' : 'unread'}}"><div class="actions">{{ if(!isAuthor) { }}<a href="#" class="stop-notify">不再提醒</a>{{ } }}</div><div class="content">你{{= predicateText[subscribe_reason] }}的<span>《{{= works_title}}》</span>的<a href="{{= annotation_url}}" title="在阅读器查看" target="_blank" class="annotation-link">批注</a>有了<a href="{{= annotation_url}}" title="在阅读器查看" target="_blank" class="reply-count"><em>{{= count }}</em>条新回复</a></div></div><div class="bd detail"><p class="annotation-text">{{- annotation_text }}</p><div class="notification-comments"></div></div></script>
		<script id="tmpl-notification-topics" type="text/template">
{{
var topicDict = { today: '今天' , yesterday: '昨天' , week: '一周内' , month: '一月内' , older: '更早' };}}{{ for (var i = 0, ilen = topics.length; i < ilen; ++i) { }}{{ var topic = topics[i]; }}<li style="display:none;" class="period {{= topic }}"><div class="hd"><h3>{{= topicDict[topic]}}</h3></div><div class="bd"><ol></ol></div></li>{{ } }}</script>
		<script id="tmpl-notification-comment-item" type="text/template">
{{- text}}&nbsp;-&nbsp;<a href="{{- author.url }}" target="_blank" class="author">{{- author.name}}</a>{{ if (isArticleAuthor) { }}<span class="label-author">（作者）</span>{{ } }}</script>
		<div class="bookshelf-footer">
			<p class="copyright">2005 - 2014 douban.com, all rights reserved.</p>
			<ul class="footer-nav">
				<li><a href="/contact">联系我们</a></li>
				<li><a href="/copyright">版权声明</a></li>
				<li><a
					href="help.douban.com/help/ask?category=book&amp;amp;type=39">使用反馈</a></li>
				<li><a href="/faq">常见问题</a></li>
			</ul>
		</div>
	</div>
	<div style="display:none;" id="ark-reader" class="">
		<aside class="aside"></aside>
		<div class="article">
			<div class="mask-spine"></div>
			<div class="inner">
				<div class="page">
					<div class="content">
						<div class="loading-hint">作品载入中，请稍候 ...</div>
					</div>
				</div>
			</div>
			<div class="bookmarks-layout">
				<mark style="display:none" class="bookmark"></mark>
			</div>
			<div class="tiny-pagination-layer">
				<a href="#" class="tiny-page-switcher page-prev-switcher"
					data-direction="prev"></a><a href="#"
					class="tiny-page-switcher page-next-switcher" data-direction="next"></a>
			</div>
			<div class="chapter-overlay">
				<div class="chapter-switchers">
					<div class="chapter-prev-wrapper">
						<a href="#" class="chapter-switcher chapter-prev"
							data-direction="prev">上一篇</a>
					</div>
					<div class="chapter-next-wrapper">
						<a href="#" class="chapter-switcher chapter-next"
							data-direction="next">下一篇</a>
					</div>
				</div>
			</div>
			<aside class="aside-controls">
				<div class="controls-panel"></div>
				<div class="pagination"></div>
			</aside>
		</div>
		<script id="tmpl-panels-container" type="text/template"><a href="#" class="close">&times;</a><section class="panel-content"><div class="chapters-toc controls-content"></div><div class="toc controls-content"></div><div class="bookmarks controls-content"></div><div class="annotations controls-content"></div></section></script>
		<script id="tmpl-mobile-top-panel" type="text/template"><div class="bannerline"><a class="label" href="{{- url}}"><span class="arkicon-angle-left"></span> {{- label}} </a><div class="btn-placeholder"></div></div></script>
		<script id="tmpl-mobile-controls-panel" type="text/template"><ul class="controls-list"><li class="controls-item toggle-chapters-toc"><b class="arkicon-chapters-list"></b><label>篇目</label></li><li class="controls-item toggle-toc"><b class="arkicon-list"></b><label>目录</label></li><li class="controls-item controls-ark-salon"><a href="#"><b class="arkicon-salon"></b><label>讨论</label></a></li><li class="controls-app"><span class="goto-app">用客户端打开</span></li></ul><div class="panels-container"></div></script>
		<script id="tmpl-controls-panel" type="text/template"><ul class="controls-list"><li class="controls-item toggle-chapters-toc" data-helper="篇目" title="篇目"><b class="arkicon-chapters-list"></b></li><li class="controls-item toggle-toc" data-helper="目录" title="目录"><b class="arkicon-list"></b></li><li class="controls-item toggle-bookmarks" data-helper="我的书签" title="我的书签"><b class="arkicon-bookmarks"></b></li> {{ var toggleAnnotationsLabel = isGallery ? '我的批注' : '批注和划线'}} <li class="controls-item toggle-annotations" data-helper="{{- toggleAnnotationsLabel}}" title="{{- toggleAnnotationsLabel}}"><b class="arkicon-annotations"></b></li></ul><div class="panels-container"></div></script>
		<script id="tmpl-annotation-guide-dialog" type="text/template"><div class="hd"><a href="#" class="btn-close btn btn-green">知道了</a><h3 class="label">打开批注开关后:</h3></div><div class="bd"><img src="${CONTENT_PATH }/ark/pics/reader/snapshot-social-annotation.png?v=2897186105" width="679" height="230"></div></script>
		<script id="tmpl-shortcut-tips" type="text/template"><div class="shortcut-tips"><div class="hd"><a class="bn-flat close-tips" href="#">关闭提示</a></div><div class="bd"><div class="section-annotation"><h3>划线、批注操作</h3><div class="section-bd"><img src="${CONTENT_PATH }/ark/pics/reader/snapshot-annotation.png?v=1247417801" width="324" height="138"></div></div><div class="section-shortcut"><h3>快捷键</h3><ul class="section-bd"><li class="item"><span class="key-fullscreen"></span><span class="key-fn">全屏阅读</span></li><li class="item"><span class="key-turn-page"></span><span class="key-fn">翻页</span></li><li class="item"><span class="key-scroll-row"></span><span class="key-fn">整行上下移动</span></li></ul></div></div></div></script>
		<script id="tmpl-panel" type="text/template"><ul class="panel"> {{ if (!isAnonymous) { }} <li id="fn-back" class="sep" data-helper="阅读列表"><a href="/reader/ebooks/" class="arkicon-back" title="阅读列表"></a></li> {{ } }} <li id="fn-layout" class="sep" data-helper="阅读模式"><a href="#" title="阅读模式" class="arkicon-layout {{ if (layout === 'vertical') { }}vertical{{ } }}"></a></li>
              <!--<li id="fn-salon" data-helper="评论" {{ if (!canRate) { }} class="sep" {{ } }}><a href="{{- reviewsUrl}}" title="评论" target="_blank" class="arkicon-salon"></a></li> 
             {{ if (canRate) { }} 
            <li id="fn-rating" data-helper="评分"><a href="#" title="评分" target="_blank" class="arkicon-star"></a></li> 
             {{ } }} {{ if (!isAnonymous) { }} 
             <li id="fn-share" class="sep page-sharing" data-title="分享"><a href="#" title="分享" class="arkicon-share"></a></li>
                {{ } }} 
            <li id="fn-question" data-helper="提问"><a href="{{- questionsUrl }}" title="提问" target="_blank" class="arkicon-question"></a></li>
            <li id="fn-comment" data-helper="讨论"><a href="{{- reviewsUrl }}" title="讨论" target="_blank" class="arkicon-salon"></a></li>
            <li id="fn-favor" data-helper="喜欢" class="sep"><a href="#" title="喜欢" target="_blank" class="arkicon-favor"></a></li>--><!--取消评论按钮和分享按钮-->
            {{ if (!isGallery) { }} <li id="fn-annotation-filter" data-helper="切换批注可见模式" class="sep"><a href="#" title="切换批注可见模式" target="_blank" class="icon-annotations-filter"></a></li> 
             {{ } }} 
           <li id="fn-helper"><a href="#" title="指南">指南</a></li>
            </ul></script>
		<script id="tmpl-annotations-filter-list" type="text/template"><div class="hd filter-header"><label for="show-others"><span class="switch-button"><input id="show-others" type="checkbox" name="showOthers" {{- showOthers ? 'checked' : '' }} ><i></i></span>显示他人批注</label></div> {{ if (!isAnonymous) { }} <ul class="bd filter-list {{- showOthers ? 'show-others' : '' }}"><li class="filter-item"><label for="filter-follow-only"><span class="radio-button"><input id="filter-follow-only" type="radio" name="othersFilter" value="followOnly" {{- othersFilter === 'followOnly' ? 'checked' : '' }} ><i></i></span>只看友邻的</label></li><li class="filter-item"><label for="filter-others">友邻和热门的<span class="radio-button"><input id="filter-others" type="radio" name="othersFilter" value="all" {{- othersFilter === 'all' ? 'checked' : '' }} ><i></i></span></label></li></ul> {{ } }}
</script>
		 <script id="tmpl-tooltip" type="text/template"><div class="tooltip"><div class="bubble-content"></div></div></script>
		<script id="tmpl-annotation-guide-bubble" type="text/template"><div class="hd"><h3>批注的新功能上线啦<i class="icon-new"></i></h3><a href="#" class="lnk-close">&times;</a></div><div class="bd"><p>打开这个批注开关后，你就可以看到你的友邻和他人对这本书写的批注。</p><a href="#" class="btn-more-info btn btn-green" >知道了<i class="arrow-right"></i></a></div></script>
		<script id="tmpl-empty-page" type="text/template"><div class="page page-empty"><div class="loading-hint">{{= hint }}</div><div class="content"></div></div></script>
		<script id="tmpl-mathplayer-hint" type="text/template"><div class="mathplayer-hint"><p> 本作品包含数学公式，为确保内容正常显示，请先安装 MathPlayer。<br>安装完成后需重启浏览器，并允许浏览器运行该程序。</p><a href="www.dessci.com/en/dl/MathPlayer2.2setup.exe" class="btn-large">点击下载</a></div></script>
		<script id="tmpl-article" type="text/template"> {{ _.each(posts, function(art) { }} <div class="story"><div class="info"><h1>{{- art.title }}</h1> {{ if (art.subtitle) { }} <h2>{{- art.subtitle }}</h2> {{ } }} <div class="author"><span class="orig-author"> {{= art.orig_author }} </span> {{ if (art.translator) { }} <span class="translator"> {{= art.translator }}&nbsp;译 </span> {{ } }} </div></div><div class="content"> {{ _.map(art.contents, function(p) { }} <p data-pid="{{= p.id }}" class="{{= p.type }} {{ if (p.type === 'illus') { }} {{ if (p.expandable) { print('expandable') } }} {{= p.data.dimension }}_{{= p.data.layout }} {{ } }} {{ if (p.data && p.data.format) { if (p.data.format.p_indent) { print('indentall ') } if (p.data.format.t_indent) { print('indent ') } if (p.data.format.p_align) { print(p.data.format.p_align + ' ') } else if (p.data.format.p_center) { print('center ') } if (p.data.format.p_bold) { print('bold ') } if (p.data.format.p_quote) { print('quote ') } } }}"> {{ if (p.type === 'illus') { var imgSizeMaps = { H: 'large', M: 'small', S: 'tiny' } }} <span class="illus-outer"><img class="loading" data-seq="{{= p.data.seq }}" data-orig-src="{{= p.data.size.orig.src }}" data-orig-width="{{= p.data.size.orig.width }}" data-orig-height="{{= p.data.size.orig.height }}" data-src="{{= p.data.size[imgSizeMaps[p.data.dimension]].src }}" width="{{= p.data.size[imgSizeMaps[p.data.dimension]].width }}" height="{{= p.data.size[imgSizeMaps[p.data.dimension]].height }}" /></span> {{ if (p.data.legend || p.data.full_legend) { }} <span class="legend" {{ if (p.data.full_legend) { }} data-full-legend="{{- p.data.full_legend }}" {{ } }}><span class="ellipsis-prop"></span><span class="ellipsis-main"> {{= p.data.legend }} </span><span class="ellipsis-end">…</span></span> {{ } }} {{ } else if (p.type === 'pagebreak') { }} {{ } else { }} {{ if (p.type === 'code') { }} <code data-language="{{= p.data.language}}" class="{{= splitCode.doSplit ? 'line-split' : ''}}" >{{= splitCode(p.data.text) }} </code> {{ } else { }} {{= p.data.text }} {{ } }} {{ } }} </p> {{ }); }} </div></div> {{ }); }}
</script>
		<script id="tmpl-page" type="text/template"> {{ if (_.isObject(page.note)) { }} <div class="words-wrapper"><div class="words-wrapper-cell"><div class="words-main"><div class="words-hd"> 给 {{- page.note.recipient }} </div><div class="words-bd"> {{- page.note.words }} </div><div class="words-ft"> {{- page.note.sender }}<br> {{- page.note.date }} </div></div></div></div> {{ } else { }} <div class="hd"><h3><a href="{{- url }}" target="_blank">{{- page.title }}</a></h3><div class="header-extra"></div></div><div class="bd"> {{ if (page.info) { }} <div class="info" style="height:{{= page.info.height }}em"><h1>{{- page.info.title }}</h1> {{ if (page.info.subtitle) { }} <h2>{{- page.info.subtitle }}</h2> {{ } }} <div class="author"><span class="orig-author"> {{= page.info.orig_author }} </span> {{ if (page.info.translator) { }} <span class="translator"> {{= page.info.translator }} </span> {{ } }} </div></div> {{ } }} <div class="content"{{ if (page.content) { }} style="height:{{= page.content.height }}em"{{ } }}> {{ _.each(page.paragraphs, function (p) { print(getParaHtml(p)) }) }} </div></div><div class="ft" {{ if (page.pagination === 1) { }} id="page-captain" {{ } }}> {{= readPageNum }} </div> {{ } }}
</script>
		<script id="tmpl-sample-chapter-page" type="text/template"><div class="hd"> {{ if (page.title) { }} <h3>{{- page.title }}</h3> {{ } }} <div class="header-extra"></div></div><div class="bd sample-chapter-page"><div class="chapter-number">第 {{- chapterNum }} 篇</div><h1>{{- chapter.title }}</h1><div class="meta"><span class="timestamp">{{- sec2date(chapter.onsale_time) }} 发表</span><div class="social-info"> {{ if (column.subscriber_num) { }} <span class="subscription-count">{{- column.subscriber_num}} 人订阅</span> {{ } }} {{ if (chapter.comment_num) { }} <span class="comment-count"><a href="/column/{{- column.id}}/chapter/{{- chapter.id}}/comments" target="_blank"> {{- chapter.comment_num }} 讨论 </a></span> {{ } }} </div></div><p class="abstract">{{- truncate(chapter.abstract, 120) }}</p><section class="purchase-section"></section><a href="/column/{{- column.id}}/chapter/{{- chapter.id}}" class="more" target="_blank">去商店了解更多</a></div> {{ if (page.pagination) { }} <div class="ft" {{ if (page.pagination === 1) { }} id="page-captain" {{ } }}> {{= readPageNum }} </div> {{ } }}
</script>
		<script id="tmpl-paragraph" type="text/template"><p data-pid="{{= p.pid }}" {{ if (p.klass) { }}class="{{= p.klass }}"{{ } }} {{ if (p.offset || p.height) { }} style="{{ if (p.offset>0) { }}margin-top:-{{= p.offset }}em;{{ } }} {{ if (p.height) { }}height:{{= p.height }}em{{ } }}" {{ if (p.offset && p.offset > 0) { print('data-offset="' + p.offset + '"')} }} {{ } }}> {{ print(getParaContent(p)) }} </p></script>
		<script id="tmpl-tips" type="text/template"><div class="tips-outer footnote-tips"><div class="footnote"></div></div></script>
		<script id="tmpl-illus" type="text/template"><div class="orig-illus"><img src="{{= src }}" width="{{= origWidth}}" height="{{= origHeight}}"></div> {{ if (legend) { }} <div class="full-legend"> {{= legend }} </div> {{ } }}
</script>
		<!--  <script id="tmpl-collect-tips" type="text/template">点击此处将试读或免费作品加入阅读列表，可以在&nbsp;<a href="/intro/iphone" target="_blank">iPhone</a>、 <a href="/intro/ipad" target="_blank">iPad</a>&nbsp;和&nbsp; <a href="/intro/android" target="_blank">安卓阅读器</a>&nbsp;中阅读
</script>-->
		<script id="tmpl-rating-form" type="text/template"><form class="form-vertical rating-form"><fieldset><div class="field-group"><div class="fields"><label class="my-rating">我的评分</label><div class="rating"></div></div></div><div id="field-edit" class="field-group"></div><div class="form-actions"></div></fieldset></form></script>
		<script id="tmpl-rating" type="text/template"><span href="#" data-stars="{{= rating }}" class="stars-context stars-{{= rating }}"><input type="radio" name="rating" class="star-region" data-star="1" value="1"><input type="radio" name="rating" class="star-region" data-star="2" value="2"><input type="radio" name="rating" class="star-region" data-star="3" value="3"><input type="radio" name="rating" class="star-region" data-star="4" value="4"><input type="radio" name="rating" class="star-region" data-star="5" value="5"></span></script>
		<script id="tmpl-rating-comment" type="text/template"><div class="fields"> {{ if (!rated || editingMode) { }} <div class="field-comment textarea-shell"><textarea class="rating-comment" rows="5"
          name="comment" placeholder="写评论">{{- comment}}</textarea></div> {{ } else if (comment) { }} <p class="comment-text">{{- comment }}</p> {{ } }} {{ if (rated && !editingMode) { }} <a href="#" class="link-edit">修改</a> {{ } }} </div></script>
		<script id="tmpl-form-buttons" type="text/template"> {{ if (!rated || editingMode) { }} <label class="validation-error"></label><button type="submit" class="btn-link btn-cancel">取消</button><button type="submit" class="btn btn-bubble">发表</button> {{ } }}
</script>
		<script id="tmpl-note-display" type="text/template"><div class="note-owner"><a href="{{- note.owner.url}}" target="_blank"><img class="avatar" src="{{- note.owner.avatar}}" alt="{{- note.owner.name}}"></a><span class="author"><a href="{{- note.owner.url}}" class="lnk-author" target="_blank">{{- note.owner.name}}</a> {{ if (isArticleAuthor) { }} <span class="label-author">（作者）</span> {{ } }} 的批注 </span></div><div class="note-content">{{= autoLink(note.note)}}</div><div class="actions"><span class="private-info">仅自己可见&nbsp;|</span> {{ var split = ''}} {{ var dot = '·'}} {{ if ('edit' in actions) { }} {{- split}} <a class="edit" href="#">修改</a> {{ split = dot }} {{ } }} {{ if ('delete' in actions) { }} {{- split}} <a class="delete" href="#">删除</a> {{ split = dot }} {{ } }} {{ if ('comment' in actions) { }} {{- split}} <a class="comment" href="#"></a> {{ split = dot }} {{ } }} 
               <!--{{ if ('favorite' in actions) { }} {{- split}} <a class="favorite" href="#"></a> {{ split = dot }} {{ } }} {{ if ('share' in actions) { }} <span class="share-wrapper"> {{- split}} <a class="share" href="#">推荐</a> {{ split = dot }} </span>-->
                {{ } }} {{ if(total > 1) { }} <div class="right-actions tip-pagination"><span class="pagination-info">{{- current}}/{{- total}}</span><a class="prev" href="#"></a><a class="next" href="#"></a></div> {{ } }} </div></script>
		<script id="tmpl-toc" type="text/template"><div class="hd"><h2><span class="pattern-left"></span><span class="title">目录</span><span class="pattern-right"></span></h2></div><div id="contents-list" class="bd"><ul>{{ _.each(list, function(item, idx) { }}<li><a id="page-{{= item.pageNum }}" tabIndex="{{= idx+1 }}" href="#" class="toc-item text">{{= item.text }}</a><span class="num">{{= item.readPageNum }}</span></li>{{ }); }}</ul></div><div class="ft"><div class="close"></div></div></script>
		<script id="tmpl-chapters-toc" type="text/template"><div class="hd"><h2><span class="pattern-left"></span><span class="title">篇目</span><span class="pattern-right"></span></h2></div><div id="chapters-contents-list" class="bd"><ul>{{ _.each(list, function(item, idx) { }}<li><a tabIndex="{{= idx+1 }}" data-permalink="permalink" href="/reader/column/{{= columnId }}/chapter/{{= item.id }}/" class="chapter-toc-item {{= currChapterId === item.id ? 'is-current' : ''}}"><div class="item-hd"><div class="action-right">{{ if (item.is_allowed_to_read) { }}<span class="current-dot"></span>{{ } }}</div><h3 class="chapter-title {{ print(item.is_read ? '' : 'unread') }}">{{- item.title }}{{ if (!item.is_read && idx === lastItemIndex) { }}<span title="最新发表" class="icon-new"></span>{{ } }}</h3><div class="chapter-meta"><span class="timestamp">{{= sec2date(item.onsale_time) }} 发表</span></div></div><div class="item-bd"><p class="abstract">{{- truncate(item.abstract, 80) }}</p></div></a>{{ if (!item.is_allowed_to_read) { }}<div class="purchase-section">{{ print(purchaseButton.render({ data: purchaseButtonData(columnId, item) }).el.outerHTML) }}</div>{{ } }}</li>{{ }) }}</ul></div><div class="ft"><div class="close"></div></div></script>
		<script id="tmpl-bookmarks-panel" type="text/template"><div class="panel-hd"><h2>我的书签</h2></div><div class="panel-bd"></div></script>
		<script id="tmpl-bookmarks-item" type="text/template"><div class="item-hd"><div class="percentage"><mark class="bookmark active"></mark><span class="num">{{= percent }}%</span></div><div class="date"> {{= update_time }} </div></div><div class="item-bd"><p class="abstract"> {{= abstract }} </p></div></script>
		<script id="tmpl-annotations-panel" type="text/template"><div class="panel-head"><h2>我的批注和划线</h2><div class="head-nav">
         <!--<div class="annotation-tabs">-->
          <!--<ul class="filter-tabs"><li><a href="#" data-filter-type="all">全部</a></li><li><a href="#" data-filter-type="mine">我自己的</a></li><li><a href="#" data-filter-type="favorite">我收藏的</a></li></ul>-->
          <i class="divider"></i><div class="sort-switch"><div class="hd">
          <!--<i class="unfold-icon"></i>-->
          <!--<i class="sort-icon"></i>
          <span class="sort-type"></span></div>-->
         <!--<ul class="bd sort-tabs"><li><a href="#" data-sort-type="percent">按原文顺序</a></li><li><a href="#" data-sort-type="time">按添加时间</a></li></ul>-->
         </div></div></div></div><div class="panel-body"></div></script>
		<script id="tmpl-annotations-panel-item" type="text/template"><div class="progress"><span class="percentum"> {{ if (+extra.percent < 1) { print('< 1') } else { print(extra.percent) } }}% </span></div><div class="bd annotation-content"><div class="quote">{{- extra.text}}</div> {{ if (isNote) {}} <div class="note"> {{= autoLink(note)}} </div> {{ } }} <div class="actions"><div class="common-actions"> {{ if('favorite' in actions) { }} <a href="#" class="favorite-annotation"></a><i class="middle-dot"></i> {{ } }} {{ if(isMine && n_favorites) {}} <span class="favorite-num">被收藏&nbsp;{{- n_favorites}}</span><i class="middle-dot"></i> 
            {{ } }} <!--{{ if('comment' in actions) { }} <a href="#" class="comment-annotation"></a><i class="middle-dot"></i>-->
            {{ } }} 
           <!--<span class="share-wrapper"><a href="#" class="share-annotation">推荐</a><i class="middle-dot"></i></span>-->
           <a href="#" class="jump-annotation">跳至此段</a></div><div class="edit-actions"> {{ if (!isMine) { }} <span class="owner"><a href="{{- owner.url}}" target="_blank"><img class="avatar" src="{{- owner.avatar}}" alt="{{- owner.name}}"></a><span class="author"><a href="{{- owner.url}}" class="lnk-author" target="_blank">{{- owner.name}}</a> {{ if (isArticleAuthor) { }} <span class="label-author">（作者）</span> {{ } }} &nbsp;的批注 </span></span> {{ } }} <span class="timestamp">{{- printTime(create_time)}}</span> 
            <!--{{ if (isMine) {}} <span class="private-info-wrapper"><i class="middle-dot"></i><span class="private-info">仅自己可见</span></span>-->
            {{ } }} {{ if('delete' in actions || isNote && 'edit' in actions) { print('&nbsp;|&nbsp;') } }} {{ if(isNote && 'edit' in actions) { }} <a href="#" class="modify-annotation">修改</a> {{ } }} {{ if('delete' in actions) { }} <a href="#" class="delete-annotation">删除</a> {{ } }} </div></div></div></script>
		<script id="tmpl-para-annotations-overlay" type="text/template"><a href="#" class="lnk-close">&times;</a><div class="annotations-overlay para-annotations-overlay"><div class="side"></div><div class="main"><div class="head-nav"><div class="total-annotation">此段所有批注<span class="annotaiton-num">{{- totalAnnotations }}</span></div><ul class="filter-tabs"><li><a href="#" data-nav-type="hot">热门</a></li><li><a href="#" data-nav-type="newest">最新</a></li><li><a href="#" data-nav-type="favorite">我收藏的</a></li></ul></div><ul class="annotations-list"></ul></div></div></script>
		<script id="tmpl-single-annotation-overlay" type="text/template"><a href="#" class="lnk-close">&times;</a><div class="annotations-overlay single-annotation-overlay"><div class="side"></div><div class="main"></div></div></script>
		<script id="tmpl-single-note" type="text/template"><div class="hd"><div class="info"><a href="{{- owner.url}}" target="_blank"><img class="avatar" src="{{- owner.avatar}}" alt="{{- owner.name}}"></a><span class="author"><a href="{{- owner.url}}" class="lnk-author" target="_blank">{{- owner.name}}</a> {{ if (isArticleAuthor) { }} <span class="label-author">（作者）</span> {{ } }} &nbsp;的批注 </span><span class="time">{{- printTime(create_time, true)}}</span></div><a href="#" class="lnk-para-annotations">查看此段所有批注</a></div><div class="bd"><p class="note"> {{= autoLink(note)}} </p></div><div class="ft"> {{= noteActionsHtml }} </div></script>
		<script id="tmpl-para-annotations-overlay-annotation-item"
			type="text/template"><div class="hd"><div class="comments-info"><span aria-hidden="true" class="arkicon-comment"></span><span class="comments-num">{{- n_comments}}</span></div><div class="title"><img class="avatar" src="{{- owner.avatar }}"><span class="name">{{- owner.name }}</span> {{ if (isArticleAuthor) { }} <span class="label-author">（作者）</span> {{ } }} 的批注 </div></div><div class="bd"><p class="note"> {{= autoLink(note) }} </p></div><div class="ft"><span class="create-time"> {{- printTime(create_time) }} </span> {{ if(n_favorites) { }} <span class="favorites-num"> {{- n_favorites }}人收藏 </span> {{ } }} {{ if(isPrivate) {}} <span class="private-info">仅自己可见</span> {{ } }} </div></script>
		<script id="tmpl-content-container" type="text/template"><div class="content"></div></script>
		 <script id="tmpl-single-note-actions" type="text/template"><div class="actions"> 
       <!--{{ var split = ''}} {{ var dot = '·'}} {{- split}} 回复&nbsp;<span class="comments-num">{{- n_comments }}</span>--> 
     {{ split = dot }} {{ if(isMine && n_favorites) { }} {{- split}} 被收藏&nbsp;<span class="favorites-num">{{- n_favorites }}</span> {{ split = dot }} {{ } }} {{ if ('favorite' in actions) { }} {{- split}} <a class="favorite" href="#"></a> {{ split = dot }} {{ } }} {{ if ('share' in actions) { }} <span class="share-wrapper"> {{- split}} <a class="share" href="#">推荐</a> {{ split = dot }} </span> {{ } }} </div><div class="edit-actions"> {{ if (isMine) { }} <span class='private-info-wrapper'><span class="private-info">仅自己可见</span>&nbsp;| </span> {{ } }} {{ if ('edit' in actions) { }} <a class="edit" href="#">修改</a>&nbsp;· {{ } }} {{ if ('delete' in actions) { }} <a class="delete" href="#">删除</a> {{ } }} </div></script>
	    <script id="tmpl-annotation-comment-text" type="text/template">
                          <!-- 回复 {{- n_comments > 0 ? ' ' + n_comments : ''}}-->
</script>
		<script id="tmpl-annotation-favorite-text" type="text/template"> {{ if(isFavorited) { print('取消收藏') } else { print('收藏' + (n_favorites ? ' ' + n_favorites : '')) } }}
</script>
		<!--  <script id="tmpl-annotation-comments-form" type="text/template"><input maxlength="280" type="text" class="comment-input" name="text" placeholder="添加回复..."><button type="submit" class="btn btn-post">回复</button></script>-->
		<script id="tmpl-annotation-comment-item" type="text/template"><div class="hd"><div class="comment-actions"> {{ if (isMine || isAdmin) { }} <a href="#" class="delete-comment">删除</a> {{ } }} </div><a href="{{- author.url}}" target="_blank" class="author">{{- author.name}}</a> {{ if (isArticleAuthor) { }} <span class="label-author">（作者）</span> {{ } }} <span class="timestamp">{{- time}}</span></div><p class="bd comment-content">{{= autoLink(text)}}</p></script>
		<script id="tmpl-column-header" type="text/template"><header class="lite-header"><a href="/" class="lite-logo"></a><div class="inner"><div class="lite-nav"><a href="/people/{{- agent.user_id }}/" target="_blank" class="lite-author"><img src="{{- agent.picture }}" class="avatar"/><span class="name">{{- agent.name }}</span></a><a href="/column/{{- id }}/" class="lite-title"><b>专栏</b>&nbsp;· {{- title }}</a></div></div></header></script>
		<script id="tmpl-column-footer" type="text/template"><footer class="lite-footer"><div class="inner"></div></footer></script>
		<script id="tmpl-control-guide" type="text/template"><div id="control-guide"><div class="left-pad"><p class="text"><label>点击左侧</label>上一页</p></div><div class="center-pad"><p class="text"><label>点击中间</label>打开菜单</p></div><div class="right-pad"><p class="text"><label>点击右侧</label>下一页</p></div></div></script>
	</div>
	<div style="display:none" id="ark-gallery" class="">
		<aside class="gallery-aside"></aside>
		<div class="gallery-main"></div>
		<aside class="gallery-controls">
			<div class="gallery-controls-panel"></div>
			<div class="panel-shadow"></div>
			<div class="gallery-pagination"></div>
			<div class="bookmarks-container">
				<mark style="display:none" class="bookmark arkicon-bookmark"></mark>
			</div>
			<div class="chapter-overlay">
				<div class="chapter-switchers">
					<div class="chapter-prev-wrapper">
						<a href="#" data-direction="prev"
							class="chapter-switcher chapter-prev">上一篇</a>
					</div>
					<div class="chapter-next-wrapper">
						<a href="#" data-direction="next"
							class="chapter-switcher chapter-next">下一篇</a>
					</div>
				</div>
			</div>
		</aside>
		<script id="tmpl-gallery-panels-container" type="text/template"><a href="#" class="close">&times</a><section class="panel-content"><div class="toc controls-content"></div><div class="chapters-toc controls-content"></div><div class="bookmarks controls-content"><div class="panel-hd"><h2><span class="pattern-left"></span><span class="title">书签</span><span class="pattern-right"></span></h2></div><div class="panel-bd"></div></div><div class="annotations controls-content"></div></section></script>
		<script id="tmpl-gallery-toc" type="text/template"><div class="hd"><h2><span class="pattern-left"></span><span class="title">目录</span><span class="pattern-right"></span></h2></div><div class="contents-list bd"><ul>{{ _.each(list, function(item, idx) { }}<li class="item"><a data-number="{{- item.page.number}}" href="#" class="level-{{- item.tier}} toc-item"><span class="num">{{- item.page.read_number}}</span><span class="text">{{- item.title }}</span></a></li>{{ }) }}</ul></div></script>
		<script id="tmpl-gallery-chapters-toc" type="text/template"><div class="hd"><h2><span class="pattern-left"></span><span class="title">篇目</span><span class="pattern-right"></span></h2></div><div class="contents-list bd"><ul>{{ _.each(list, function(item, idx) { }}<li class="item"><a tabIndex="{{= idx+1 }}" data-permalink="permalink" href="/reader/column/{{= columnId }}/chapter/{{= item.id }}/" class="chapter-toc-item {{= currChapterId === item.id ? 'is-current' : ''}}"><div class="item-hd"><div class="action-right">{{ if (item.is_allowed_to_read) { }}<span class="current-dot"></span>{{ } }}</div><h3 class="chapter-title">{{- item.title }}</h3><div class="chapter-meta"><span class="timestamp">{{= sec2date(item.onsale_time) }} 发表</span></div></div><div class="item-bd"><p class="abstract">{{- truncate(item.abstract, 80) }}</p></div></a>{{ if (!item.is_allowed_to_read) { }}<div class="purchase-section">{{ print(purchaseButton.render({ data: purchaseButtonData(columnId, item) }).$el) }}</div>{{ } }}</li>{{ }) }}</ul></div></script>
		<script id="tmpl-gallery-bookmark-item" type="text/template"><div class="item-hd"><div class="position"><mark class="bookmark arkicon-bookmark active"></mark><span class="number">{{- numberLabel}}</span></div><div class="date">{{- update_time}}</div></div><div class="item-bd">{{ if (thumbnail) { }}<img src="{{- thumbnail.src}}" height="100" width="{{- Math.round(thumbnail.width / thumbnail.height * 100)}}" class="bookmark-snapshot"/>{{ } }}{{ if (abstract) { }}<p>{{- abstract}}</p>{{ } }}</div></script>
		<script id="tmpl-gallery-footer-controls" type="text/template"><a href="#" class="btn-annotation"><span class="annotations-number">{{- annotationsNumber}}</span><span class="icon-annotation"><b class="arkicon-annotation"></b></span></a><a href="#" class="btn-share"><b class="arkicon-share"></b></a></script>
		<script id="tmpl-gallery-page-annotations-overlay"
			type="text/template"><a href="#" class="lnk-close"><span class="cross-icon"><span class="plus"></span></span></a><div class="annotations-overlay page-annotations-overlay"><div class="side"><div class="content-container"></div></div><div class="main"></div></div></script>
		<script id="tmpl-gallery-page-annotation-item" type="text/template"><div class="bd"><p class="note">{{- note}}</p></div><div class="ft"><span class="create-time">{{- printTime(create_time) }}</span><span class="actions"><a href="#" class="modify-annotation">修改</a>&nbsp; | &nbsp;<a href="#" class="delete-annotation">删除</a></span></div></script>
		<script id="tmpl-gallery-content-container" type="text/template"><div class="progress-page"><span class="curr-page">P{{- currPage}}</span><span class="total-page">&nbsp;/&nbsp;{{- totalPage}}</span></div>{{ if (illusUrl) { }}<img src="{{- illusUrl}}"/>{{ } }}{{ if (plainDesc) { }}<div class="desc">{{= plainDesc}}</div>{{ } }}</script>
		<script id="tmpl-gallery-add-annotation" type="text/template"><div class="add-annotation"><div class="inner"><span class="plus-icon"><span class="plus"></span></span><span class="label">添加批注</span></div></div></script>
		<script id="tmpl-gallery-annotations-panel" type="text/template"><div class="panel-hd"><h2><span class="pattern-left"></span><span class="title">我的批注</span><span class="pattern-right"></span></h2><div class="head-nav"><ul class="sort-tabs"><li><a href="#" data-sort-type="page">按原文顺序</a></li><li><a href="#" data-sort-type="time">按时间顺序</a></li></ul></div></div><div class="panel-bd"></div></script>
		<script id="tmpl-gallery-annotation-panel-item" type="text/template"><div class="desc-wrapper"><div class="desc"><div class="progress-page"><span class="curr-page">P{{- currPage}}</span><span class="total-page">&nbsp;/&nbsp;{{- totalPage}}</span></div>{{ if (thumbnail) {}}<div class="thumbnail"><img src="{{- thumbnail.src}}" height="{{- thumbnail.height}}" width="{{- thumbnail.width}}"/></div>{{ } }}{{ if (plainDesc) {}}<p class="plain-desc">{{= plainDesc}}</p>{{ } }}</div></div><div class="bd"><div class="note">{{- note}}</div><div class="note-footer"><span class="timestamp">{{- printTime(create_time)}}</span><span class="edit-actions"><a href="#" class="modify-annotation">修改</a>&nbsp; | &nbsp;<a href="#" class="delete-annotation">删除</a></span><span class="common-actions"><a href="#" class="jump-annotation">跳到此页</a></span></div></div></script>
	</div>
	<script id="tmpl-purchase-dialog" type="text/template"><header class="works-info"><h4><span class="title">《{{- title }}》{{ print(extra_title ? extra_title : '') }}</span><span class="price">{{- price }} 元</span></h4></header><section class="account-info"><div class="info">使用账户余额支付<span class="inline-price">{{ print(balance > price ? price : balance) }} 元</span></div><div class="balance">账户：{{- username }}，可用余额 {{- balance }} 元</div></section>{{ if (amount) { }}<section class="payment-channels"><div class="title">使用其他方式支付<span class="inline-price">{{- amount }} 元</span></div><div class="content"></div></section>{{ } }}<section class="purchase-options"><label class="checkbox"><input type="checkbox" name="secretly" {{ print(secretly ? 'checked' : '') }}="{{ print(secretly ? 'checked' : '') }}"/>购买仅自己可见</label>{{ if (!subscribed) { }}<label class="checkbox"><input type="checkbox" name="add_subscription" checked="checked"/>订阅该专栏的后续更新消息</label>{{ } }}</section></script>
	<script id="tmpl-purchase-success" type="text/template"><div class="success-sign">购买成功！</div><p>你可以去阅读器中阅读这篇作品了</p><p class="count-down-tip"><span class="count-down-num">{{-sec }}</span>秒钟后自动关闭</p></script>
	<script id="tmpl-bought-button" type="text/template">
{{ if (isLargeBtn) { }}<a target="_blank" href="{{- url}}" data-action="read" class="btn btn-icon btn-read"><i class="icon-read"></i>阅读</a>{{ } else { }}<a target="_blank" href="{{- url}}" data-action="read" class="btn btn-read">阅读</a>{{ } }}</script>
	<script id="tmpl-payment-channels" type="text/template"><form target="_blank" action="/account/" method="POST" class="payment-form form-vertical"><div style="display:none;"><input type="hidden" name="ck" value="A5wm"/></div><div class="channel alipay-express field-group"><label class="field-label channel-name">支付宝一键支付</label><div class="fields"><label class="payment-method radio"><input type="radio" name="bankcode" value="alipay_express" checked="checked"/><div class="bank-box"><span class="bank-icon alipay-express-logo">支付宝一键支付</span></div></label><div class="help-block">无需网银，无需支付宝帐号也能付款，绑定后支付更快捷</div></div></div><div class="channel alipay-express field-group"><label class="field-label channel-name">支付宝普通支付</label><div class="fields"><label class="payment-method radio"><input type="radio" name="bankcode" value="alipay" =""/><div class="bank-box"><span class="bank-icon alipay-logo">支付宝</span></div></label></div></div><div class="channel field-group"><label class="field-label channel-name">网银支付</label><div class="fields-inline bank-list"><label class="radio bank payment-method "><input type="radio" name="bankcode" value="BOCB2C" ><div class="bank-box"><span class="BOCB2C bank-icon">中国银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="ICBCB2C" ><div class="bank-box"><span class="ICBCB2C bank-icon">中国工商银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CMB" ><div class="bank-box"><span class="CMB bank-icon">招商银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CCB" ><div class="bank-box"><span class="CCB bank-icon">中国建设银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="ABC" ><div class="bank-box"><span class="ABC bank-icon">中国农业银行</span></div></label><div class="more-bank"><a class="more-bank-lnk" href="#">选择其他银行<b class="arrow"></b></a></div></div></div></form></script>
	<script id="tmpl-banks-list" type="text/template"><div class="fields-inline bank-list"><label class="radio bank payment-method actived"><input type="radio" name="bankcode" value="BOCB2C" checked="checked"><div class="bank-box"><span class="BOCB2C bank-icon">中国银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="ICBCB2C" ><div class="bank-box"><span class="ICBCB2C bank-icon">中国工商银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CMB" ><div class="bank-box"><span class="CMB bank-icon">招商银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CCB" ><div class="bank-box"><span class="CCB bank-icon">中国建设银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="ABC" ><div class="bank-box"><span class="ABC bank-icon">中国农业银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="SPDB" ><div class="bank-box"><span class="SPDB bank-icon">上海浦东发展银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CIB" ><div class="bank-box"><span class="CIB bank-icon">兴业银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="GDB" ><div class="bank-box"><span class="GDB bank-icon">广东发展银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="SDB" ><div class="bank-box"><span class="SDB bank-icon">深圳发展银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CMBC" ><div class="bank-box"><span class="CMBC bank-icon">中国民生银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="COMM" ><div class="bank-box"><span class="COMM bank-icon">交通银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="CITIC" ><div class="bank-box"><span class="CITIC bank-icon">中信银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="HZCBB2C" ><div class="bank-box"><span class="HZCBB2C bank-icon">杭州银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="SHBANK" ><div class="bank-box"><span class="SHBANK bank-icon">上海银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="NBBANK" ><div class="bank-box"><span class="NBBANK bank-icon">宁波银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="SPABANK" ><div class="bank-box"><span class="SPABANK bank-icon">平安银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="BJRCB" ><div class="bank-box"><span class="BJRCB bank-icon">北京农村商业银行</span></div></label><label class="radio bank payment-method "><input type="radio" name="bankcode" value="FDB" ><div class="bank-box"><span class="FDB bank-icon">富滇银行</span></div></label></div></script>
	<script id="tmpl-purchase-button" type="text/template"> {{ if (username === '匿名用户') { }}{{ if (is_large_btn) { }}<a data-target-dialog="login" class="btn btn-large login {{ print(is_hollow_btn ? 'btn-hollow' : '') }}">购买本篇<span class="price">{{- readable_price }} 元</span></a>{{ } else { }}<a data-target-dialog="login" class="btn login {{ print(is_hollow_btn ? 'btn-hollow' : '') }}">{{- readable_price }} 元</a>{{ } }}{{ } else if (is_mobile_direct_purchase) { }}
<div class="action-button">{{ if (is_large_btn) { }}<a href="{{- mobile_direct_purchase_url }}" class="btn btn-large">购买本篇 {{- readable_price }} 元</a>{{ } else { }}<a href="{{- mobile_direct_purchase_url }}" class="btn">{{- readable_price }} 元</a>{{ } }}</div>{{ } else { }}<div data-title="{{- title }}" data-readable-price="{{- readable_price }}" data-price="{{- price }}" data-article-id="{{- id }}" data-url="{{- url }}" data-redirect-url="{{- redirect_url }}" data-is-large-btn="{{ print( is_large_btn ? 'true' : 'false') }}" data-kind-name="{{- kind_name }}" data-username="{{- username }}" data-widget="{{- widget }}" data-paid-url="/j/article/{{- id }}/buy" data-subscribed="{{- is_subscribed }}" class="action-button">{{ if (is_large_btn) { }}<a href="#" data-action="purchase" class="btn btn-large {{ print(is_hollow_btn ? 'btn-hollow' : '') }}">购买本篇<span class="price">{{- readable_price }} 元</span></a>{{ } else { }}<a href="#" data-action="purchase" class="btn {{ print(is_hollow_btn ? 'btn-hollow' : '') }}">{{- readable_price }} 元</a>{{ } }}</div>{{ } }}</script>
	<!-- <script id="tmpl-purchase-guide" type="text/template"><div class="item">试读已结束{{ if (device === 'iphone') { }}，{{ print(+price ? '购买' : '登录') }}后继续阅读{{ } else { }}。{{ print(+price ? '购买' : '登录') }}后，可以继续阅读。{{ } }}</div><div class="item purchase-section"></div><div class="item"><a href="/ebook/{{= id }}/" target="_blank" class="link-more">去商店了解更多</a></div></script>
	<script id="tmpl-gift-page" type="text/template"><div class="words-wrapper"><div class="words-wrapper-cell"><div class="words-main"><div class="words-hd">给 {{- recipient }}</div><div class="words-bd">{{- words }}</div><div class="words-ft">{{- sender }}<br/>{{- date }}</div></div></div></div></script>
	 -->
	<!--删除加入阅读列表按钮 -->
	 <!--<script id="tmpl-extra-controls" type="text/template">
{{ if (isSample && +price) { }}<div class="btn-purchase-wrapper"></div>{{ } }}{{ if (isAnonymous) { }}<a href="#" data-target-dialog="login" class="login">登录</a>{{ } else if (!hasAdded) { }}<a href="#" class="lnk-collect">加入阅读列表</a>{{ } }}</script>
	 <script id="tmpl-chapter-extra-controls" type="text/template">
{{ if (isAnonymous) { }}<a href="#" data-target-dialog="login" class="login">登录</a>{{ } else if (!isSubscribed) { }}<a href="#" class="lnk-subscribe">订阅本{{= kind}}</a>{{ } }}</script>-->
	<script id="tmpl-pagination" type="text/template"><div data-direction="prev" data-helper="前翻" class="turn-prev page-prev"></div><div data-direction="next" data-helper="后翻" class="turn-next page-next"></div></script>
	<script id="tmpl-page-portal" type="text/template"><div class="page-portal"><div class="page-info"><span class="curr-num">1</span><span class="slash">/</span><span class="total-num">1</span><span class="progress-num">0%</span><a href="#" class="page-form-switch"><b class="switch-arrow"></b></a></div><div class="page-jump"><form class="page-form"><input type="text" value="5" class="page-input"/><button type="submit" class="page-submit"></button></form><span class="page-custom-label">当前页</span></div></div></script>
	<script type="text/template" id="tmpl-alert"><div id="ark-alert"><div class="alert-main"><div class="bd content"><div class="title">{{= title }}</div><div class="text">{{= text }}</div></div><div class="ft"><div class="buttons"><a data-name="confirm" href="#" class="btn btn-read confirm">{{= confirm }}</a></div></div></div></div></script>
	<script type="text/template" id="tmpl-alert-with-aside"><div id="ark-alert" class="alert-with-aside"><div class="alert-main"><div class="bd content"><div class="title">{{= title }}</div><div class="text">{{= text }}</div></div><div class="ft"><div class="buttons"><a data-name="confirm" href="#" class="btn btn-read confirm">{{= confirm }}</a></div></div></div><div class="alert-aside"><div class="bd content"><div class="title">{{= asideTitle }}</div><div class="text">{{= asideText }}</div></div><div class="ft"><div class="buttons"><a data-name="asideConfirm" href="#" class="btn aside-confirm">{{= asideConfirm }}</a></div></div></div></div></script>
	<script id="tmpl-mobile-app-ad" type="text/template"><a href="{{- url}}" class="intro"><div class="logo"></div><div class="bd"><h4 class="title">阅读客户端</h4><div class="desc">下载后免费阅读原创作品</div></div></a><a href="{{- url}}" class="btn btn-primary btn-download btn-large {{- className}}">免费下载</a><a href="#" class="close-wrapper"><div class="close">&times;</div></a></script>
	<script id="tmpl-desktop-app-ad" type="text/template"><div class="hd"><a href="#" class="close">×</a></div><div class="help-msg">扫码下载客户端<br/>手机/Pad随时读</div><a href="/app?icn=qr-from-reader" target="_blank" class="app-qrcode"></a></script>
	<script id="tmpl-dialog-app-ad" type="text/template"><div class="btn-download-wrapper"><a href="{{- url}}" class="btn btn-primary btn-download btn-large"><span class="smartphone-icon"></span><span>免费下载</span><span class="arkicon-angle-right"></span></a></div></script>
	<script id="tmpl-ebook-purchase" type="text/template">
{{ if (isAnonymous) { }}<a data-target-dialog="login" class="btn btn-primary login">{{- price }} 元</a>{{ } else { }}<a href="/ebook/{{- id}}/?purchase=true" class="btn btn-primary">{{- price }} 元</a>{{ } }}</script>
	<script id="tmpl-simple-subscribe" type="text/template">
{{ if (isAnonymous) { }}<a data-target-dialog="login" class="btn btn-primary login">订 阅</a>{{ } else if (!is_subscribed) { }}<a class="btn fixed-btn btn-primary btn-subscribe">订 阅</a>{{ } }}</script>
	<!--<script id="tmpl-sharing-buttons" type="text/template"><div class="share-buttons icon-{{ print(size ? size : 'normal') }}"><span class="share-text">分享到</span><a title="分享到" href="#" class="rec-douban">分享到</a><a title="分享到微信" href="#" class="rec-wechat">分享到微信</a><a title="分享到微博" href="#" class="rec-weibo">分享到微博</a><a title="分享到腾讯微博" href="#" class="rec-tencent">分享到腾讯微博</a><a title="分享到QQ好友" href="#" class="rec-qqim">分享到QQ好友</a><a title="分享到QQ空间" href="#" class="rec-qzone">分享到QQ空间</a><a title="分享到人人网" href="#" class="rec-renren">分享到人人网</a></div></script>
	     <script id="tmpl-wechat-share" type="text/template"><div class="wechat-qrcode"><div class="qr-container"></div><div class="help">打开微信“扫一扫”，扫码后点击右上角<img src="${CONTENT_PATH }/ark/pics/sharebuttons/icon-wechat-more.png?v=9821430100" alt="分享" width="20px" height="20px" class="icon-wechat-more"/>按钮即可进行分享。</div></div></script>-->
	  <script id="tmpl-sharing-form" type="text/template">
      <!--<div class="bd"><div class="textarea-shell"><textarea class="textarea-text"
        maxlength="140"
        placeholder="写点什么吧" name="text"></textarea></div></div><div class="actions"> {{= sharingActionsHtml}} {{ if (isNote) { }} <div class="comment-action"><label class="checkbox"><input id="add-comment" name="add_comment" type="checkbox" checked>也作为回复</label></div> {{ } }} <div class="form-actions"><a class="ln-cancel" href="#">取消</a><button class="btn btn-bubble btn-post" type="submit">确定</button></div></div>-->
    </script>
	<script id="tmpl-sharing-actions" type="text/template"> 
      <!--{{ if (allowShare) { }} <div class="share-options"> {{ if (sharingLabel) { }} <span class="label"> {{- sharingLabel}}到 </span> {{ } }} <label class="checkbox"><input id="share-dou" name="share_dou" {{ if (share_dou) { print('checked') } }} type="checkbox" >广播</label><span class="item-weibo-wrapper"></span><span class="weibo-setting"><a href="/share/sina/connect" class="tips-bind" target="_blank">绑定新浪微博</a></span><a class="share-setting" target="_blank" href="/account/setting">设置</a></div> {{ } }} {{ if (hasVisibleSetting) { }} <div class="note-visible-wrapper"><label class="checkbox"><input id="note-visible" name="visible_private" {{ if (visible_private) { print('checked') } }} type="checkbox" >仅自己可见</label></div> {{ } }}-->
</script>
	<script id="tmpl-share-weibo" type="text/template"> 
     <!--{{ if (weiboBinded) { }} <label class="checkbox"><input id="share-weibo" name="share_weibo" {{ if (share_weibo) { print('checked') } }} type="checkbox">新浪微博</label> {{ } }}-->
</script>
	<script id="tmpl-debug-form" type="text/template"><div class="textarea-shell"><textarea placeholder="错误描述" name="text"
      maxlength="500" required></textarea></div><div class="actions"><div class="form-actions"><a class="ln-cancel" href="#">取消</a><button class="btn btn-bubble btn-post" type="submit">确定</button></div></div></script>
	<script id="tmpl-note-form" type="text/template">
    <div class="textarea-shell"><textarea placeholder="你的批注" name="text" required>{{- content}}</textarea></div><div class="actions"> {{= sharingActionsHtml}} <div class="form-actions"><a class="ln-cancel" href="#">取消</a><button class="btn btn-bubble btn-post" type="submit">确定</button></div></div>
   </script>
	<script id="tmpl-note-inline-form" type="text/template"><textarea type="text" maxlength="500" class="text">{{- text}}</textarea><div class="form-footer"><div class="form-actions"><a href="#" class="button cancel">取消</a><button type="submit" class="btn post">保存</button></div><div class="private-setting"><label class="checkbox"><input type="checkbox" {{ if (visible_private) { print('checked') } }} name="visible_private" >仅自己可见 </label></div></div></script>
	<script src="${CONTENT_PATH }/ark/js/dist/reader/setup-8317154807.js"></script>
	<script>
		var Ark = {
			CDN_FOR_STATIC_LIB : '${CONTENT_PATH }/',
			DOUBAN : 'www.douban.com',
			MathJaxConfigPath : "${CONTENT_PATH }/ark/js/config/reader/mathjax-config-tex-htmlormml-9996287886.js",
			DOUBAN_LOGIN_POPUP_URL : "${CONTENT_PATH }/accounts/popup/ark/"
		}

		var features = {}

		features['mwr/image_view'] = true

		Ark.features = features
	</script>
	<script type="text/x-mathjax-config">
MathJax.Hub.Config({config:["MMLorHTML.js"],extensions:["tex2jax.js","toMathML.js"],"HTML-CSS":{linebreaks:{automatic:!0,width:"95% container"}},jax:["input/TeX","output/NativeMML"],skipStartupTypeset:!0,"v1.0-compatible":!1,messageStyle:"simple",styles:{"#MathJax_MSIE_Frame":{left:"45%"},"#MathJax_Message":{top:"18.75em",left:"45%",color:"#999",border:"none",background:"none","font-size":"auto"}},showMathMenu:!1,showMathMenuMSIE:!1,positionToHash:!1,preRemoveClass:"mjp",errorSettings:{message:["[公式解析失败]"]}}),"simple"===MathJax.Hub.config.messageStyle&&(MathJax.Message.filterText=function(){var labelAlias={Loading:"加载资源文件...",Processing:"处理中...",Typesetting:"解析..."},progressAlias={"Typesetting math:":"处理数学公式:","Processing math:":"解析数学公式:"};return function(text){var alias,progressAliasMatch=text.match(/^\w+ math:/);if(progressAliasMatch&&(alias=progressAlias[progressAliasMatch[0]]))return text.replace(progressAliasMatch[0],alias);var labelAliasMatch=text.match(/^\w+/);return labelAliasMatch?labelAlias[labelAliasMatch[0]]:text}}());</script>
	<script>
		define(
				'arkenv',
				[],
				function() {
					var arkenv = {
						me : {
							"name" : "jack",
							"user_type" : 1,
							"profileURL" : "http:\/\/${CONTENT_PATH }\/people\/103726057\/",
							"avatar" : "http:\/\/${CONTENT_PATH }\/icon\/user_normal.jpg",
							"signature" : "",
							"id" : "103726057"
						},
						works : null,
						ua : {
							device : "windows",
							deviceVersion : null,
							browser : "seamonkey",
							browserVersion : 5
						}
					}
					arkenv.me.isAnonymous = false
					arkenv.me.isAdmin = false
					arkenv.me.hasAgentSite = false
					arkenv.MathJaxConfigPath = "${CONTENT_PATH }/ark/js/config/reader/mathjax-config-tex-htmlormml-9996287886.js"
					arkenv.ZeroClipboardPath = "${CONTENT_PATH }/ark/media/ZeroClipboard/1.1.7/ZeroClipboard.swf?v=5632275872"
					arkenv.ANNOTATION_GUIDE_PIC = "${CONTENT_PATH }/ark/pics/reader/snapshot-social-annotation.png?v=2897186105"
					arkenv.READER_DATA_VERSION = 'v8'
					arkenv.DOUBAN = '192.168.10.41:8080'
					arkenv.CDN_FOR_STATIC_LIB = '${CONTENT_PATH }/'
					arkenv.EBOOK_STYLE_SHEET = 'ebook-style-sheet'
					arkenv.GALLERY_STYLE_SHEET = 'gallery-style-sheet'
					arkenv.COLUMN_STYLE_SHEET = 'column-style-sheet'

					return arkenv
				})

		define('mathjax', '${CONTENT_PATH }/' + 'libs/MathJax/2.1.0/MathJax.js')

		define('widget/login-and-signup',
				"${CONTENT_PATH }/ark/js/dist/widget/login-and-signup-3618200872.js")
		define('widget/profile',
				"${CONTENT_PATH }/ark/js/dist/widget/profile-7065528535.js")
		define('reader/views/reading/canvas',
				"${CONTENT_PATH }/ark/js/dist/reader/views/reading/canvas-2561633294.js")
		define('reader/views/gallery/canvas',
				"${CONTENT_PATH }/ark/js/dist/reader/views/gallery/canvas-664076374.js")
		define('hammer',
				"${CONTENT_PATH }/ark/js/dist/lib/hammer-3438846629.js")

		require(
				[ 'reader/main', 'jquery' ],
				function(App, $) {
					App.initialize()

					// XXX: dirty but work
					var Do = function(func) {
						func()
					}
					Do(function() {
						function toggleMenu(showOrHide) {
							menuContainer.toggle(showOrHide)
						}
						var moreActive = $(".more-active"), menuContainer = moreActive
								.find(".more-items"), bnMore = moreActive
								.find(".bn-more"), hoverableBtns = moreActive
								.find(".bn-more-hoverable").add(bnMore), useClick = "undefined" != typeof window.ontouchstart;
						if (useClick) {
							var doc = $(document), menuContainerIsShown = !1, toggleMenuWithClick = function(
									showOrHide) {
										menuContainerIsShown ? doc
												.off(".moreItems")
												: doc
														.on(
																"click.moreItems",
																function(e) {
																	moreActive
																			.has(e.target).length
																			|| toggleMenuWithClick(!1)
																}),
										menuContainerIsShown = !menuContainerIsShown,
										toggleMenu(showOrHide)
							};
							return bnMore.click(function() {
								toggleMenuWithClick()
							}), hoverableBtns.click(function(e) {
								e.preventDefault()
							}), void 0
						}
						var moreActiveIsHover = !1, moniterElements = $(
								hoverableBtns).add(menuContainer);
						moniterElements.mouseenter(function() {
							moreActiveIsHover = !0, toggleMenu(!0)
						}).mouseleave(function() {
							moreActiveIsHover = !1, setTimeout(function() {
								moreActiveIsHover || toggleMenu(!1)
							}, 0)
						}), menuContainer.on("click", "a", function() {
							toggleMenu(!1)
						})
					});
				})
	</script>
	<script type="text/javascript">
		var _paq = _paq || [];
		_paq.push([ 'trackPageView' ]);
		_paq.push([ 'enableLinkTracking' ]);
		(function() {
			var p = (('https:' == document.location.protocol) ? 'https'
					: 'http'), u = p + '://192.168.10.41:8080/';
			_paq.push([ 'setTrackerUrl', u + 'piwik' ]);
			_paq.push([ 'setSiteId', '100001' ]);
			var d = document, g = d.createElement('script'), s = d
					.getElementsByTagName('script')[0];
			g.type = 'text/javascript';
			g.defer = true;
			g.async = true;
			g.src = p + '://192.168.10.41:8080/dae/fundin/piwik.js';
			s.parentNode.insertBefore(g, s);
		})();
	</script>
	<script>
		(function(i, s, o, g, r, a, m) {
			i['GoogleAnalyticsObject'] = r;
			i[r] = i[r] || function() {
				(i[r].q = i[r].q || []).push(arguments)
			}, i[r].l = 1 * new Date();
			a = s.createElement(o), m = s.getElementsByTagName(o)[0];
			a.async = 1;
			a.src = g;
			m.parentNode.insertBefore(a, m)
		})(window, document, 'script',
				'//www.google-analytics.com/analytics.js', 'ga');

		ga('create', 'UA-7019765-12', {
			userId : '103726057'
		});

		ga('require', 'ecommerce', 'ecommerce.js');
		ga('require', 'campaignLoader', {
			debug : false
		});

		ga('campaignLoader:loadCampaignFields');

		ga('send', 'pageview');

		ga('set', 'dimension1', '0');

		ga('set', 'dimension2', '3');

		ga('set', 'dimension5', 'a');

		ga('set', 'dimension3', 'desktop');
	</script>
	<script async
		src="${CONTENT_PATH }/ark/js/widget/campaign-loader-2409221021.js"></script>
	<!-- hador18 -->
</body>
</html>