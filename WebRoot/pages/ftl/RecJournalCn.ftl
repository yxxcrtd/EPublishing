 <div class="oh h450">
	<h1 class="h1Tit borBot">
		<a class="ico1" href="javascript:void(0)"><#if (lang=="zh_CN")>编辑推送<#else>Recommend the journal</#if></a>
	</h1>
<#if (list?? && 0 < list?size)>
	<div class="featureContainer">
		<div class="feature">
			<div class="lblack">
				<div id="botton-scroll1">
					<ul class=featureUL>
	                    <li class=featureBox>
		                    <div class="oh">
		                    <#list list as p>
			                     <div class="bookBlock">
			                     	<#if p.cover??>
									<a href="${request.contextPath}/pages/publications/form/article/${p.id}">
										<img src="<#if p.cover??>${request.contextPath}/pages/publications/form/cover?t=1&id=${p.id}<#else>${request.contextPath}/images/noimg.jpg</#if>"  width="95" height="130" onerror="this.src='${request.contextPath}/images/noimg.jpg'"/>
									</a>
									<#else>
									<a href="${request.contextPath}/pages/publications/form/article/${p.id}">
										<div class="imgMoren">
										<p>${p.title}</p>
										</div>
									</a>
									</#if>
									<p class="bookTit"><a class="a_title" title="${(p.title)!}" href="${request.contextPath}/pages/publications/form/article/${p.id}">${(p.title)!}</a></p>
								</div>
								
								<#if (7 == p_index || 15 == p_index)></div></li><li class=featureBox style="width:730px !important; height:490px !important;"><div class="oh"></#if>
								<#if (23 == p_index)></div></li></#if>
	                  		</#list>
                    </ul>
				</div>
			</div>
			<a class="prev1" href="javascript:;">Previous</a>
			<a class="next1" href="javascript:;">Next</a> 
		</div>
	</div>            
</#if>
</div>