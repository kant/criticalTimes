{**
 * lib/pkp/templates/frontend/components/browseArchives.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief A panel to display a list of section archives to browse.
 *
 * @uses ctSections array All browseable sections on the site
 *}
<div class="row browseArchives">
	<div class="col--left">
		<h2 class="browseArchives__title">
			{translate key="plugins.themes.criticalTimes.browseArchives.title"}
		</h2>
		<p class="browseArchives__description">
			{translate key="plugins.themes.criticalTimes.browseArchives.description"}
		</p>
	</div>
	<div class="col--right">
		<div class="browseArchives__list -clearFix">
			{foreach from=$ctSections item="ctSection"}
				<div class="browseArchives__listItem">
					<a class="browseArchives__listItemText" href="{url router=$smarty.const.ROUTE_PAGE page="section" op="view" path=$ctSection->getData('browseByPath')}">
						{$ctSection->getLocalizedTitle()}
					</a>
				</div>
			{/foreach}
		</div>
	</div>
</div>
