 <div class="oh h490">
 	<h1 class="h1Tit borBot"><a class="ico1"><#if (lang=="zh_CN")>热读期刊<#else>Hotreading periodical</#if></a></h1>
<#if (hotlist?? && 0 < hotlist?size)>
	<div class="featureContainer">
		<div class="feature">
			<div class="lblack49">
				<div id="botton-scroll3">
					<ul class=featureUL>
	                    <li class=featureBox style="height:450px;">
		                    <div class="oh">
		                    <#list hotlist as p>
			                     <div class="bookBlock">
			                     	<#if p.cover??>
				                     	<a href="${request.contextPath}/pages/publications/form/article/${p.id}">
											<img src="<#if p.cover??>${request.contextPath}/pages/publications/form/cover?t=1&id=${p.id}<#else>${request.contextPath}/images/noimg.jpg</#if>"  width="95" height="130" onerror="this.src='${request.contextPath}/images/noimg.jpg'"/>
										</a>
			                     	<#else>
			                     		<a href="${request.contextPath}/pages/publications/form/article/${p.id}">
			                     		<div class="imgMoren">
											<p>${(p.title)!}</p>
										</div>
										</a>
			                     	</#if>
									<p class="bookTit">
										<a class="a_title" title="${(p.title)!}" href="${request.contextPath}/pages/publications/form/article/${p.id}">
											<#if (8 < p.title?length)>${p.title[0..7]}...<#else>${p.title}</#if>
										</a>
									</p>
									<p>${(p.year)!}年 ${(p.issueCode)!}期</p>
								</div>
								
								<#if (7 == p_index || 15 == p_index)></div></li><li class=featureBox style="height:450px;"><div class="oh"></#if>
								<#if (23 == p_index)></div></li></#if>
	                  		</#list>
                    </ul>
				</div>
			</div>
			<a class="prev3" href="javascript:;">Previous</a>
			<a class="next3" href="javascript:;">Next</a> 
		</div>
	</div>            
</#if>
</div>