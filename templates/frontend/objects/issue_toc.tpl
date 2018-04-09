{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedArticles array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses ctToc array Grouped table of contents data, including articles, for
 *       custom Critical Times presentation
 * @uses ctIsCurrent bool Is this issue the current issue?
 *}
{foreach from=$ctToc item="tocGroup" key="tocGroupNumber"}
	<div class="row issueGroup{if $tocGroupNumber is odd} issueGroup--special{/if}">
		<div class="col--left">
			{* Show the issue details with the first group *}
			{if !$tocGroupNumber}
				{if $ctIsCurrent}
					<div class="issueGroup__section">{translate key="journal.currentIssue"}</div>
				{/if}
				<div class="issueGroup__title">{$issueTitle}</div>
				<div class="issueGroup__identity">{$issueSeries}</div>
				{if $tocGroup.editor}
					<div class="issueGroup__editor">{translate key="plugins.themes.criticalTimes.issue.groupEditor" editor=$tocGroup.editor|strip_unsafe_html}</div>
				{/if}
				<div class="issueGroup__description">{$issue->getLocalizedDescription()}</div>
				{if $issueGalleys}
					<div class="issueGroup__galleys">
						{foreach from=$issueGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$issue}
						{/foreach}
					</div>
				{/if}

			{* Show the group name/description for other groups *}
			{else}
				{if $tocGroup.isSpecial}
					<div class="issueGroup__section">{translate key="plugins.themes.criticalTimes.issue.specialSection"}</div>
				{/if}
				<div class="issueGroup__title">{$tocGroup.name}</div>
				{if $tocGroup.editor}
					<div class="issueGroup__editor">{translate key="plugins.themes.criticalTimes.issue.groupEditor" editor=$tocGroup.editor|strip_unsafe_html}</div>
				{/if}
				<div class="issueGroup__description">{$tocGroup.description}</div>
			{/if}
		</div>
		<div class="col--right">
			{foreach from=$tocGroup.articles item="article"}
				{include file="frontend/objects/article_summary.tpl"}
			{/foreach}
		</div>
	</div>
{/foreach}
