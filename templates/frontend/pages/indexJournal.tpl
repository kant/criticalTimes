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

<div class="row issueGroup">
	<div class="col--left">
		<div class="issueGroup__section">Current Issue</div>
		<div class="issueGroup__title">Inaugural Edition</div>
		<div class="issueGroup__identity">1:1 November 2017</div>
		<div class="issueGroup__description">
			<p>
				Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit aliquam vehicula. In id accumsan neque. Nullam eu erat a tortor ullamcorper pretium at rhoncus ipsum. Nulla facilisis neque at eleifend dignissim. Cras eget lorem justo. Vestibulum nibh purus, dictum sit amet molestie vel, tristique ac massa.
			</p>
			<p>
				Quisque dictum tincidunt mi vitae consectetur. Donec sit amet fringilla dolor, id blandit massa. Cras sed pretium lectus. Sed pharetra eget orci vitae pharetra.
			</p>
		</div>
		<div class="issueGroup__galleys">
			<a href="#" class="button">PDF</a>
		</div>
	</div>
	<div class="col--right">
		<div class="articleSummary">
			<a href="#">
				<div class="articleSummary__section">Essays</div>
				<div class="articleSummary__title">On the Critical Task of the University Today</div>
				<div class="articleSummary__authors">Sandro Mezzadra</div>
			</a>
		</div>
		<div class="articleSummary">
			<a href="#">
				<div class="articleSummary__section">Essays</div>
				<div class="articleSummary__title">On the Critical Task of the University Today</div>
				<div class="articleSummary__authors">Sandro Mezzadra</div>
			</a>
		</div>
		<div class="articleSummary">
			<a href="#">
				<div class="articleSummary__section">Essays</div>
				<div class="articleSummary__title">On the Critical Task of the University Today</div>
				<div class="articleSummary__authors">Sandro Mezzadra</div>
			</a>
		</div>
		<div class="articleSummary">
			<a href="#">
				<div class="articleSummary__section">Essays</div>
				<div class="articleSummary__title">On the Critical Task of the University Today</div>
				<div class="articleSummary__authors">Sandro Mezzadra</div>
			</a>
		</div>
	</div>
</div>

<div class="row issueGroup issueGroup--special">
	<div class="col--left">
		<div class="issueGroup__section">Special Section</div>
		<div class="issueGroup__title">On the Critical Task of the University Today</div>
		<div class="issueGroup__description">
			<p>
				Quisque dictum tincidunt mi vitae consectetur. Donec sit amet fringilla dolor, id blandit massa. Cras sed pretium lectus. Sed pharetra eget orci vitae pharetra.
			</p>
			<p>
				Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit aliquam vehicula. In id accumsan neque. Nullam eu erat a tortor ullamcorper pretium at rhoncus ipsum. Nulla facilisis neque at eleifend dignissim. Cras eget lorem justo. Vestibulum nibh purus, dictum sit amet molestie vel, tristique ac massa.
			</p>
		</div>
	</div>
	<div class="col--right">
		<div class="articleList">
			<div class="articleSummary">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
			<div class="articleSummary">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
			<div class="articleSummary articleSummary--hasArt">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<img src="https://images.unsplash.com/photo-1474770447574-779d47496484?auto=format&fit=crop&w=1950&q=60&ixid=dW5zcGxhc2guY29tOzs7Ozs%3D" class="articleSummary__art" width="300" height="200">
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
			<div class="articleSummary">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
		</div>
	</div>
</div>

<div class="row issueGroup">
	<div class="col--right">
		<div class="articleList">
			<div class="articleSummary">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
			<div class="articleSummary">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
			<div class="articleSummary articleSummary--hasArt">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<img src="https://images.unsplash.com/photo-1474770447574-779d47496484?auto=format&fit=crop&w=1950&q=60&ixid=dW5zcGxhc2guY29tOzs7Ozs%3D" class="articleSummary__art" width="300" height="200">
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
			<div class="articleSummary">
				<a href="#">
					<div class="articleSummary__section">Essays</div>
					<div class="articleSummary__title">On the Critical Task of the University Today</div>
					<div class="articleSummary__authors">Sandro Mezzadra</div>
				</a>
			</div>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
