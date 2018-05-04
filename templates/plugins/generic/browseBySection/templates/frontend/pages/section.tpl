{**
 * plugins/generic/browseBySection/templates/frontend/pages/section.tpl
 *
 * Copyright (c) 2017 Simon Fraser University
 * Copyright (c) 2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the reader-facing section page.
 *
 * @uses $section Section
 * @uses $sectionPath string The URL path for this section
 * @uses $sectionDescription string
 * @uses $articles array List of Submission objects
 * @uses $issues array List of Issue objects the $articles are published in
 * @uses $showingStart int 20 in `20-30 of 100 results`
 * @uses $showingEnd int 30 in `20-30 of 100 results`
 * @uses $total int 100 in `20-30 of 100 results`
 * @uses $currentlyShowingPage int 2 in `2 of 10 pages`
 * @uses $countMaxPage int 10 in `2 of 10 pages`.
 *}

{include file="frontend/components/header.tpl" pageTitleTranslated=$section->getLocalizedTitle()}

<div class="sectionArchive">
	<div class="row issueGroup issueGroup--sectionArchive">
		<div class="col--left">
			<h1 class="sectionArchive__title">{$section->getLocalizedTitle()}</h1>
			<div class="sectionArchive__description">{$sectionDescription}</div>
		</div>
	</div>

	{assign var="currentIssueId" value=false}
	{foreach name="articleDisplayLoop" from=$articles item="article"}

		{* Print issue details when it's a new issue *}
		{if !$currentIssueId || $currentIssueId != $article->getIssueId()}
			{if $currentIssueId}
					</div>
				</div><!-- .row -->
			{/if}
			<div class="row issueGroup issueGroup--sectionArchive">
				<div class="col--left">
					{foreach from=$issues item="issue"}
						{if $issue->getId() == $article->getIssueId()}
							<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
								<h2 class="sectionArchive__issueTitle">{$issue->getLocalizedTitle()}</h2>
								<div class="sectionArchive__issueId">{$ctThemePlugin->getIssueIdentification($issue)|strip_unsafe_html}</div>
							</a>
						{/if}
					{/foreach}
				</div>
				<div class="col--right">
		{/if}

		{include file="frontend/objects/article_summary.tpl" hideSection=true}

		{* Close the last column *}
		{if $smarty.foreach.articleDisplayLoop.last}
				</div>
			</div><!-- .row -->
		{/if}

		{assign var="currentIssueId" value=$article->getIssueId()}
	{/foreach}
</div>

<div class="row issueGroup issueGroup--pagination">
	<div class="col--left"></div>
	<div class="col--right">
		<div class="pagination">
			<span class="pagination__current">
				{translate key="plugins.themes.criticalTimes.section.showing" start=$showingStart end=$showingEnd total=$total}
			</span>
			{if $urlPrevPage}
				<a class="pagination__prev" href="{$urlPrevPage|escape}">
					<span class="fa fa-long-arrow-left"></span>
					{translate key="plugins.themes.criticalTimes.section.prev"}
				</a>
			{/if}
			{if $urlNextPage}
				<a class="pagination_next" href="{$urlNextPage|escape}">
					{translate key="plugins.themes.criticalTimes.section.next"}
					<span class="fa fa-long-arrow-right"></span>
				</a>
			{/if}
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
