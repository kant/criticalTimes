{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a landing page for a single issue. It will show the table of contents
 *  (toc) or a cover image, with a click through to the toc.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue, consisting of one or
 *       more of the volume, number, year and title, depending on settings
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $primaryGenreIds array List of file genre IDs for primary types
 * @uses ctToc array Grouped table of contents data, including articles, for
 *       custom Critical Times presentation
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

{if !$issue}
	<h1>{translate key="current.noCurrentIssue"}</h1>
	<p>{translate key="current.noCurrentIssueDesc"}</p>
{else }
	{include file="frontend/objects/issue_toc.tpl"}
{/if}

{include file="frontend/components/footer.tpl"}
