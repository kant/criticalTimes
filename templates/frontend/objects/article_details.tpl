{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $copyright string Copyright notice. Only assigned if statement should
 *   be included with published articles.
 * @uses $copyrightHolder string Name of copyright holder
 * @uses $copyrightYear string Year of copyright
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published articles.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *
 * The following is added by this theme:
 * @uses $authorString string Comma-separated list of author names
 * @uses $specialSection array Details about a special section that this article
 *   was published in, if available.
 * @uses $ctThemePlugin ThemePlugin This theme plugin object
 *}
{assign var="authors" value=$article->getAuthors()}
{assign var="authorString" value=$ctThemePlugin->getAuthorString($authors)}
{assign var="translatorString" value=$ctThemePlugin->getTranslatorString($authors)}
<article class="articleFull">
	<div class="articleFull__header">
		<div class="articleFull__section">
			<a href="{url router=$smarty.const.ROUTE_PAGE page="section" op="view" path=$section->getData('browseByPath')}">
				{$section->getLocalizedTitle()}
			</a>
		</div>
		<h1 class="articleFull__title">
			{$article->getLocalizedTitle()|escape}

			{if $article->getLocalizedSubtitle()}
				<span class="articleFull__subtitle">
					{$article->getLocalizedSubtitle()|escape}
				</span>
			{/if}
		</h1>

		<div class="articleFull__authors">
			{$authorString|strip_unsafe_html}
		</div>
		{if $translatorString}
			<div class="articleFull__translators">
				{$translatorString|strip_unsafe_html}
			</div>
		{/if}

	</div>

	<div class="articleFull__body -clearFix">

		<div class="articleFull__main">

			{if $article->getLocalizedCoverImage()}
				<div class="articleFull__cover">
					<img src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText() != ''} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
				</div>
			{/if}

			{if $article->getLocalizedAbstract()}
				<div class="articleFull__item articleFull__item--abstract">
					<h2 class="articleFull__itemLabel">
						{translate key="article.abstract"}
					</h2>
					<div class="articleFull__itemContent">
						{$article->getLocalizedAbstract()|strip_unsafe_html}
					</div>
				</div>
			{/if}

			{if $primaryGalleys}
				<div class="articleFull__item articleFull__item--galleys">
					<h2 class="articleFull__itemLabel">
						{translate key="plugins.themes.criticalTimes.article.galleys"}
					</h2>
					<div class="articleFull__itemContent">
						{foreach from=$primaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley}
						{/foreach}
					</div>
				</div>
			{/if}

			{call_hook name="Templates::Article::Main"}

		</div><!-- .articleFull__main -->
		<div class="articleFull__details">

			{if $primaryGalleys}
				<div class="articleFull__item articleFull__item--galleys">
					<h2 class="articleFull__itemLabel">
						{translate key="plugins.themes.criticalTimes.article.galleys"}
					</h2>
					<div class="articleFull__itemContent">
						{foreach from=$primaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley}
						{/foreach}
					</div>
				</div>
			{/if}
			{if $supplementaryGalleys}
				<div class="articleFull__item articleFull__item--galleys articleFull__item--supplementaryGalleys">
					<h2 class="-screenReader">
						{translate key="plugins.themes.criticalTimes.article.galleys.supplementary"}
					</h2>
					<div class="articleFull__itemContent articleFull__galleys">
						{foreach from=$supplementaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary=true}
						{/foreach}
					</div>
				</div>
			{/if}

			<div class="articleFull__item articleFull__item--issue">
				<h2 class="articleFull__itemLabel">
					{translate key="issue.issue"}
				</h2>
				<div class="articleFull__itemContent">
					<a class="articleFull__issue" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
						{$ctThemePlugin->getIssueIdentification($issue)|strip_unsafe_html}
					</a>
				</div>
			</div>

			{* DOI (requires plugin) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() != 'doi'}
					{php}continue;{/php}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					<div class="articleFull__item articleFull__item--doi">
						<h2 class="articleFull__itemLabel">
							{translate key="plugins.pubIds.doi.readerDisplayName"}
						</h2>
						<div class="articleFull__itemContent">
							<a class="articleFull__doi" href="{$doiUrl}">
								{$doiUrl}
							</a>
						</div>
					</div>
				{/if}
			{/foreach}

			{* Keywords *}
			{if !empty($keywords[$currentLocale])}
				<div class="articleFull__item articleFull__item--keywords">
					<h2 class="articleFull__itemLabel">
						{translate key="article.subject"}
					</h2>
					<div class="articleFull__itemContent">
						{foreach from=$keywords item=keyword}
							{foreach name=keywords from=$keyword item=keywordItem}
								{$keywordItem|escape}{if !$smarty.foreach.keywords.last}, {/if}
							{/foreach}
						{/foreach}
					</div>
				</div>
			{/if}

			{call_hook name="Templates::Article::Details"}

		</div><!-- .articleFull__details -->
	</div><!-- .row -->

</article>

{if $specialSection}
	<div class="row issueGroup issueGroup--onArticleDetail">
		<div class="col--left">
			<div class="issueGroup__section">{translate key="plugins.themes.criticalTimes.article.specialSection"}</div>
			<div class="issueGroup__title">{$specialSection.name}</div>
			{if $specialSection.editor}
				<div class="issueGroup__editor">{translate key="plugins.themes.criticalTimes.issue.groupEditor" editor=$specialSection.editor|strip_unsafe_html}</div>
			{/if}
			<div class="issueGroup__description">
				{$specialSection.description}
				<p>
					{capture assign='issueUrl'}{url page="issue" op="view" path=$issue->getBestIssueId()}{/capture}
					{translate key="plugins.themes.criticalTimes.article.fullIssue" link="<a href=\""|concat:$issueUrl|concat:'">' linkEnd="</a>"}
				</p>
			</div>
		</div>
		<div class="col--right">
			{foreach from=$specialSection.articles item="article"}
				{include file="frontend/objects/article_summary.tpl"}
			{/foreach}
		</div>
	</div>
{/if}
