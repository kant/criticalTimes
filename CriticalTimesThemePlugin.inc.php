<?php

/**
 * @file plugins/themes/criticalTimes/CriticalTimesThemePlugin.inc.php
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class CriticalTimesThemePlugin
 * @ingroup plugins_themes_criticaltimes
 *
 * @brief OJS 3 theme for Critical Times, a journal run by the International
 *  Consortium of Critical Theory
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class CriticalTimesThemePlugin extends ThemePlugin {

	/**
	 * @copydoc ThemePlugin::init()
	 */
	public function init() {

		$this->addStyle(
			'fontSourceSerifPro',
			'//fonts.googleapis.com/css?family=Source+Serif+Pro:400,700',
			array('baseUrl' => '')
		);

		$this->addStyle(
			'fontAwesome',
			'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css',
			array('baseUrl' => '')
		);

		$this->addStyle('stylesheet', 'styles/index.less');

		$this->addScript('jQuery', '//code.jquery.com/jquery-3.1.1.slim.min.js', array('baseUrl' => ''));
		$this->addScript('popper', 'js/lib/popper/popper.js');
		$this->addScript('bsUtil', 'js/lib/bootstrap/util.js');
		$this->addScript('bsDropdown', 'js/lib/bootstrap/dropdown.js');
		$this->addScript('criticalTimes', 'js/main.js');

		$this->addMenuArea(array('primary', 'footer'));

		HookRegistry::register ('TemplateManager::display', array($this, 'loadTemplateData'));
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	public function getDisplayName() {
		return __('plugins.themes.criticalTimes.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	public function getDescription() {
		return __('plugins.themes.criticalTimes.description');
	}

	/**
	 * Load custom data for templates
	 *
	 * @param string $hookName
	 * @param array $args [
	 *		@option TemplateManager
	 *		@option string Template file requested
	 *		@option string
	 *		@option string
	 *		@option string output HTML
	 * ]
	 */
	public function loadTemplateData($hookName, $args) {
		$request = Application::getRequest();
		$templateMgr = $args[0];
		$template = $args[1];

		$templateMgr->assign('ctThemePath', $request->getBaseUrl() . '/' . $this->getPluginPath());

		if ($template === 'frontend/pages/article.tpl') {
			$this->loadArticleTemplateData($hookName, $args);
		}
	}

	/**
	 * Load custom data for article templates
	 *
	 * @see CriticalTimesThemePlugin::loadTemplateData()
	 */
	public function loadArticleTemplateData($hookName, $args) {
		$request = Application::getRequest();
		$context = $request->getContext();
		$contextId = $context ? $context->getId() : CONTEXT_ID_NONE;
		$dispatcher = $request->getDispatcher();
		$templateMgr = $args[0];
		$article = $templateMgr->get_template_vars('article');

		$authorString = join(', ', array_map(function($author) {
			return $author->getFullName();
		}, $article->getAuthors()));

		$section = $templateMgr->get_template_vars('section');
		$sectionDao = DAORegistry::getDAO('SectionDAO');
		$section = $sectionDao->getById($section->getId(), $contextId);

		$templateMgr->assign(array(
			'authorString' => $authorString,
			'sectionPath' => $section->getData('browseByPath'),
		));
	}
}

?>
