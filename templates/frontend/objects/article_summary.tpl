{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *
 * Added by Critical Times Theme
 * @uses $hideSection bool
 *}

{assign var="authors" value=$article->getAuthors()}
{assign var="authorString" value=$ctThemePlugin->getAuthorString($authors)}
{assign var="translatorString" value=$ctThemePlugin->getTranslatorString($authors)}
<div class="articleSummary{if $article->getLocalizedCoverImage()} articleSummary--withCover{/if}">

	{if $article->getLocalizedCoverImage()}
		<div class="articleSummary__cover">
			<a href="{url page="article" op="view" path=$article->getBestArticleId()}">
				<img src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText() != ''} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
			</a>
		</div>
	{/if}

	<a href="{url page="article" op="view" path=$article->getBestArticleId()}">
		{if !$hideSection}
			<div class="articleSummary__section">{$article->getSectionTitle()}</div>
		{/if}
		<div class="articleSummary__title">{$article->getLocalizedTitle()|strip_unsafe_html}</div>
		<div class="articleSummary__authors">{$authorString|strip_unsafe_html}</div>
		{if $translatorString}
			<div class="articleSummary__translators">{$translatorString|strip_unsafe_html}</div>
		{/if}
	</a>
	{call_hook name="Templates::Issue::Issue::Article"}
</div>
