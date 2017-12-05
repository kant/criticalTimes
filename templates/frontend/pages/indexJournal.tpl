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
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="row spotlight" style="background-image: url('https://images.unsplash.com/photo-1474770447574-779d47496484?auto=format&fit=crop&w=1950&q=60&ixid=dW5zcGxhc2guY29tOzs7Ozs%3D')">
	<div class="col--left">
		<div class="spotlight__text">
			<a href="#">
				<div class="spotlight__context">Latin America</div>
				<div class="spotlight__title">Critical Memory: Telling Political Time in the Political Afterlife of Violence</div>
				<div class="spotlight__authors">Nelly Richard and Leonor Arfuch</div>
			</a>
			<div class="spotlight__issue">
				From
				<a href="#">Issue 1:3, May 2018</a>
			</div>
		</div>
	</div>
	<div class="col--right">
		<img class="spotlight__image" src="https://images.unsplash.com/photo-1474770447574-779d47496484?auto=format&fit=crop&w=1950&q=60&ixid=dW5zcGxhc2guY29tOzs7Ozs%3D">
	</div>
</div>

{include file="frontend/objects/issue_toc.tpl" ctIsCurrent=true}


{include file="frontend/components/footer.tpl"}
