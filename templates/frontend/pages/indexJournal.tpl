{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description
 * @uses $issue Issue Current issue
 *
 * Added by the Critical Times theme
 * @uses $spotlightArticle PublishedArticle Article to highlight on the homepage
 * @uses $spotlightIntro string Descriptive text before the spotlight title
 * @uses $spotlightIssue Issue The issue the spotlight is in.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

{if $spotlightArticle}
	<div class="row spotlight" style="background-image: url('{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}')">
		<div class="col--left">
			<div class="spotlight__text">
				<a href="{url page="article" op="view" path=$spotlightArticle->getBestArticleId()}">
					{if $spotlightIntro}
						<div class="spotlight__context">{$spotlightIntro|strip_unsafe_html}</div>
					{/if}
					<div class="spotlight__title">{$spotlightArticle->getLocalizedTitle()|strip_unsafe_html}</div>
					<div class="spotlight__authors">{$spotlightArticle->getAuthorString()|strip_unsafe_html}</div>
				</a>
				{if $spotlightIssue}
					<div class="spotlight__issue">
						From
						<a href="{url page="issue" op="view" path=$spotlightIssue->getBestIssueId()}">{$ctThemePlugin->getIssueIdentification($spotlightIssue)|strip_unsafe_html}</a>
					</div>
				{/if}
			</div>
		</div>
		<div class="col--right">
			<img class="spotlight__image" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}">
		</div>
	</div>
{/if}

{include file="frontend/objects/issue_toc.tpl" ctIsCurrent=true}


{include file="frontend/components/footer.tpl"}
