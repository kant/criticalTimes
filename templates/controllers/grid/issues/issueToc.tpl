{**
 * templates/controllers/grid/issues/issueToc.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the issue's table of contents
 *
 * @uses $issue Issue
 *}
{help file="issue-management.md#edit-issue-toc" class="pkp_help_tab"}
<script>
	$(function() {ldelim}
		// Attach the form handler.
		$('#issueTocForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="issueTocForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT component="plugins.themes.criticalTimes.controllers.CriticalTimesIssueTocHandler" op="saveToc" issueId=$issue->getId()}">
	{csrf}

	{fbvFormArea id="issueTocSection1"}
		<h2>{translate key="plugins.themes.criticalTimes.toc.group" number=1}</h2>
		<p>{translate key="plugins.themes.criticalTimes.toc.group1.note"}</p>
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.items"}
			{fbvElement type="text" label="plugins.themes.criticalTimes.toc.group.items.description" id="group1Items" value=$group1Items}
		{/fbvFormSection}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="group1IsSpecial" value="1" checked=$group1IsSpecial label="plugins.themes.criticalTimes.toc.group.special"}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.editor"}
			{fbvElement type="text" id="group1Editor" value=$group1Editor}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormArea id="issueTocSection2"}
		<h2>{translate key="plugins.themes.criticalTimes.toc.group" number=2}</h2>
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.name"}
			{fbvElement type="text" id="group2Name" value=$group2Name}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.description"}
			{fbvElement type="textarea" id="group2Description" rich=true value=$group2Description}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.items"}
			{fbvElement type="text" label="plugins.themes.criticalTimes.toc.group.items.description" id="group2Items" value=$group2Items}
		{/fbvFormSection}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="group2IsSpecial" value="2" checked=$group2IsSpecial label="plugins.themes.criticalTimes.toc.group.special"}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.editor"}
			{fbvElement type="text" id="group2Editor" value=$group2Editor}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormArea id="issueTocSection3"}
		<h2>{translate key="plugins.themes.criticalTimes.toc.group" number=3}</h2>
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.name"}
			{fbvElement type="text" id="group3Name" value=$group3Name}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.description"}
			{fbvElement type="textarea" id="group3Description" rich=true value=$group3Description}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.items"}
			{fbvElement type="text" label="plugins.themes.criticalTimes.toc.group.items.description" id="group3Items" value=$group3Items}
		{/fbvFormSection}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="group3IsSpecial" value="3" checked=$group3IsSpecial label="plugins.themes.criticalTimes.toc.group.special"}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.editor"}
			{fbvElement type="text" id="group3Editor" value=$group3Editor}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormArea id="issueTocSection4"}
		<h2>{translate key="plugins.themes.criticalTimes.toc.group" number=4}</h2>
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.name"}
			{fbvElement type="text" id="group4Name" value=$group4Name}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.description"}
			{fbvElement type="textarea" id="group4Description" rich=true value=$group4Description}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.items"}
			{fbvElement type="text" label="plugins.themes.criticalTimes.toc.group.items.description" id="group4Items" value=$group4Items}
		{/fbvFormSection}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="group4IsSpecial" value="4" checked=$group4IsSpecial label="plugins.themes.criticalTimes.toc.group.special"}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.editor"}
			{fbvElement type="text" id="group4Editor" value=$group4Editor}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormArea id="issueTocSection5"}
		<h2>{translate key="plugins.themes.criticalTimes.toc.group" number=5}</h2>
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.name"}
			{fbvElement type="text" id="group5Name" value=$group5Name}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.description"}
			{fbvElement type="textarea" id="group5Description" rich=true value=$group5Description}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.items"}
			{fbvElement type="text" label="plugins.themes.criticalTimes.toc.group.items.description" id="group5Items" value=$group5Items}
		{/fbvFormSection}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="group5IsSpecial" value="5" checked=$group5IsSpecial label="plugins.themes.criticalTimes.toc.group.special"}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.editor"}
			{fbvElement type="text" id="group5Editor" value=$group5Editor}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormArea id="issueTocSection6"}
		<h2>{translate key="plugins.themes.criticalTimes.toc.group" number=6}</h2>
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.name"}
			{fbvElement type="text" id="group6Name" value=$group6Name}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.description"}
			{fbvElement type="textarea" id="group6Description" rich=true value=$group6Description}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.items"}
			{fbvElement type="text" label="plugins.themes.criticalTimes.toc.group.items.description" id="group6Items" value=$group6Items}
		{/fbvFormSection}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="group6IsSpecial" value="6" checked=$group6IsSpecial label="plugins.themes.criticalTimes.toc.group.special"}
		{/fbvFormSection}
		{fbvFormSection title="plugins.themes.criticalTimes.toc.group.editor"}
			{fbvElement type="text" id="group6Editor" value=$group6Editor}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormButtons submitText="common.save"}
</form>
