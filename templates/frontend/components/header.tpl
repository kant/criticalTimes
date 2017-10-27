{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{if $pageTitleTranslated}
			{$pageTitleTranslated|strip_tags}
		{else}
			{translate|assign:"pageTitleTranslated" key=$pageTitle}
		{/if}
		{* Add the journal name to the end of page titles *}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>
	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>
<body class="body__page--{$requestedPage|escape|default:"index"} body__op--{$requestedOp|escape|default:"index"}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

	<div class="-screenReader">
		<a href="#content-main">{translate key="navigation.skip.main"}</a>
		<a href="#content-nav">{translate key="navigation.skip.nav"}</a>
		<a href="#content-footer">{translate key="navigation.skip.footer"}</a>
	</div>

	<div class="siteWrapper">

		{* Header *}
		<header class="siteHeader" role="banner">
			<div class="siteHeader__topBar">
				{url|assign:"homeUrl" page="index" router=$smarty.const.ROUTE_PAGE}
				<div class="siteHeader__logo">
					<a href="{$homeUrl}">
						<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
					</a>
				</div>
				<button class="siteHeader__navToggle">
					<span class="siteHeader__navToggleIcon">
						<span></span>
						<span></span>
						<span></span>
					</span>
					<span class="siteHeader__navToggleLabel">
						{translate key="plugins.themes.criticalTimes.nav.menu"}
					</span>
				</button>
				<a class="siteHeader__searchLink" href="{url page="search"}">
					<span class="fa fa-search" aria-hidden="true"></span>
					<span class="-screenReader">{translate key="common.search"}</span>
				</a>
			</div>
			<div class="siteHeader__details">
				<nav id="content-nav" class="navMenu" aria-label="{translate|escape key="common.navigation.site"}">
					{load_menu name="primary"}
				</nav>
				<form class="siteHeader__search" action="{url page="search" op="search"}" method="post" role="search">
					{csrf}
					<span class="fa fa-search" aria-hidden="true"></span>
					<input class="siteHeader__searchInput" name="query" value="{$searchQuery|escape}" type="text" aria-label="{translate|escape key="common.searchQuery"}" placeholder="{translate|escape key="common.search"}">
					<button type="submit" class="-screenReader">
						{translate key="common.search"}
					</button>
				</form>
				<div class="siteHeader__about">
					{$currentJournal->getLocalizedDescription()|strip_unsafe_html}
				</div>
			</div>
		</header><!-- .pkp_structure_head -->

		<div id="content-main" class="siteBody">
