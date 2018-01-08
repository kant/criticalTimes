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

define('CRITICAL_TIMES_MAX_GROUPS', 6);
import('lib.pkp.classes.plugins.ThemePlugin');

class CriticalTimesThemePlugin extends ThemePlugin {

	/**
	 * @copydoc ThemePlugin::init()
	 */
	public function init() {

		$this->addOption('spotlightItem', 'text', array(
			'label' => 'plugins.themes.criticalTimes.spotlight.item'
		));

		$this->addOption('spotlightIntro', 'text', array(
			'label' => 'plugins.themes.criticalTimes.spotlight.intro',
			'description' => 'plugins.themes.criticalTimes.spotlight.intro.description'
		));

		$context = Application::getRequest()->getContext();
		if ($context) {
			$userGroupDao = DAORegistry::getDAO('UserGroupDAO');
			$userGroupsResult = $userGroupDao->getByRoleId($context->getId(), ROLE_ID_AUTHOR);
			$options = array();
			while ($userGroup = $userGroupsResult->next())  {
				$options[$userGroup->getId()] = $userGroup->getLocalizedName();
			}
			$this->addOption('translatorUserGroupId', 'radio', array(
				'label' => 'plugins.themes.criticalTimes.article.translatorGroup',
				'description' => 'plugins.themes.criticalTimes.article.translatorGroup.description',
				'options' => $options,
			));
		}

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

		// Get extra data for templates
		HookRegistry::register ('TemplateManager::display', array($this, 'loadTemplateData'));

		// Add custom settings to issues
		HookRegistry::register('issuedao::getAdditionalFieldNames', array($this, 'addIssueDaoFields'));
		HookRegistry::register('LoadComponentHandler', array($this, 'loadIssueTocHandler'));
		HookRegistry::register ('TemplateManager::fetch', array($this, 'loadIssueTocTemplateData'));
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
		$context = $request->getContext();
		$contextId = $context ? $context->getId() : CONTEXT_ID_NONE;
		$templateMgr = $args[0];
		$template = $args[1];

		$sectionDao = DAORegistry::getDAO('SectionDAO');
		$result = $sectionDao->getByContextId($contextId);
		$browseableSections = array();
		while ($section = $result->next()) {
			if ($section->getData('browseByEnabled')) {
				$browseableSections[] = $section;
			}
		}
		$templateMgr->assign('ctSections', $browseableSections);

		$templateMgr->assign('ctThemePath', $request->getBaseUrl() . '/' . $this->getPluginPath());
		$templateMgr->assign('ctThemePlugin', $this);

		if ($template === 'frontend/pages/article.tpl') {
			$this->loadArticleTemplateData($hookName, $args);
		}

		if ($template === 'frontend/pages/issue.tpl' || $template === 'frontend/pages/indexJournal.tpl') {
			$this->loadIssueTemplateData($hookName, $args);
		}

		if ($template === 'frontend/pages/indexJournal.tpl') {
			$this->loadSpotlightTemplateData($hookName, $args);
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
		$article = $templateMgr->getTemplateVars('article');

		// Determine if this article was published as part of a special section
		$publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
		$issueDao = DAORegistry::getDAO('IssueDAO');
		$issue = $issueDao->getById($article->getIssueId(), $contextId);
		$specialSection = null;
		for ($i = 1; $i < (CRITICAL_TIMES_MAX_GROUPS + 1); $i++) {
			if (!$issue->getData('group' . $i . 'IsSpecial')) {
				continue;
			}
			$items = explode(',', trim($issue->getData('group' . $i . 'Items')));
			$items = array_values(array_unique($items));
			if (in_array($article->getId(), $items)) {
				$groupArticles = array();
				foreach ($items as $item) {
					if (!ctype_digit($item) || $item == $article->getId()) {
						continue;
					}
					$groupArticle = $publishedArticleDao->getById($item);
					if ($groupArticle) {
						$groupArticles[] = $groupArticle;
					}
				}
			}
			if (count($groupArticles)) {
				$specialSection = array(
					'name' => $issue->getData('group' . $i . 'Name'),
					'description' => $issue->getData('group' . $i . 'Description'),
					'editor' => $issue->getData('group' . $i . 'Editor'),
					'articles' => $groupArticles,
				);
			}
			break;
		}

		$templateMgr->assign(array(
			'specialSection' => $specialSection,
		));
	}

	/**
	 * Load custom data for an issue (homepage and single issue)
	 *
	 * @see CriticalTimesThemePlugin::loadTemplateData()
	 */
	public function loadIssueTemplateData($hookName, $args) {
		$request = Application::getRequest();
		$context = $request->getContext();
		$contextId = $context ? $context->getId() : CONTEXT_ID_NONE;
		$templateMgr = $args[0];
		$issue = $templateMgr->getTemplateVars('issue');

		if (!$issue) {
			return;
		}

		// Get data for grouped issue table of contents
		$publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
		$toc = array();
		for ($i = 1; $i < (CRITICAL_TIMES_MAX_GROUPS + 1); $i++) {
			$items = explode(',', trim($issue->getData('group' . $i . 'Items')));
			$items = array_values(array_unique($items));
			$articles = array();
			foreach ($items as $item) {
				if (!ctype_digit($item)) {
					continue;
				}
				$article = $publishedArticleDao->getByArticleId($item);
				if ($article) {
					$articles[] = $article;
				}
			}

			if (!empty($articles)) {
				$toc[] = array(
					'name' => $issue->getData('group' . $i . 'Name'),
					'description' => $issue->getData('group' . $i . 'Description'),
					'articles' => $articles,
					'isSpecial' => $issue->getData('group' . $i . 'IsSpecial'),
					'editor' => $issue->getData('group' . $i . 'Editor'),
				);
			}
		}

		$templateMgr->assign(array(
			'ctToc' => $toc,
		));
	}

	/**
	 * Load custom data for the spotlight on the homepage
	 *
	 * @see CriticalTimesThemePlugin::loadTemplateData()
	 */
	public function loadSpotlightTemplateData($hookName, $args) {
		$request = Application::getRequest();
		$context = $request->getContext();
		$contextId = $context ? $context->getId() : CONTEXT_ID_NONE;
		$templateMgr = $args[0];

		$spotlightItem = $this->getOption('spotlightItem');

		if (!$spotlightItem || !ctype_digit($spotlightItem)) {
			return;
		}

		$publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
		$spotlightArticle = $publishedArticleDao->getByArticleId($spotlightItem, $contextId);

		if (!$spotlightArticle) {
			return;
		}

		$issueDao = DAORegistry::getDAO('IssueDAO');
		$spotlightIssue = $issueDao->getById($spotlightArticle->getIssueId(), $contextId);

		$templateMgr->assign(array(
			'spotlightArticle' => $spotlightArticle,
			'spotlightIntro' => $this->getOption('spotlightIntro'),
			'spotlightIssue' => $spotlightIssue,
		));
	}

	/**
	 * Get a list of authors that excludes translators. Returns an empty string if
	 * no non-translator authors exist.
	 *
	 * @param $authors Array
	 * @return string
	 */
	public function getAuthorString($authors) {
		$translatorUserGroupId = $this->getOption('translatorUserGroupId');

		if (empty($authors)) {
			return '';
		}

		$authorNames = array();
		foreach ($authors as $author) {
			if ($author->getUserGroupId() != $translatorUserGroupId) {
				$authorNames[] = $author->getFullName();
			}
		}

		if (empty($authorNames)) {
			return '';
		}

		return join(__('common.listSeparator'), $authorNames);
	}

	/**
	 * Get a list of translators to be displayed alongside authors. Returns an
	 * empty string if no translators exist
	 *
	 * @param $authors Array
	 * @return string
	 */
	public function getTranslatorString($authors) {
		$translatorUserGroupId = $this->getOption('translatorUserGroupId');

		if (!$translatorUserGroupId || empty($authors)) {
			return '';
		}

		$translators = array();
		foreach ($authors as $author) {
			if ($author->getUserGroupId() == $translatorUserGroupId) {
				$translators[] = $author->getFullName();
			}
		}

		if (empty($translators)) {
			return '';
		}

		$translatorsString = join(__('common.listSeparator'), $translators);

		return __('plugins.themes.criticalTimes.article.translatedBy', array('translators' => $translatorsString));
	}

	/**
	 * A replacement for Issue::getIssueIdentification()
	 *
	 * Returns a custom format for the issue identification (vol, no, title)
	 *
	 * @param $issue Issue
	 */
	public function getIssueIdentification($issue) {
		return __('plugins.themes.criticalTimes.issue.identification', array(
			'vol' => $issue->getData('volume'),
			'num' => $issue->getData('number'),
			'year' => $issue->getData('year'),
			'title' => $issue->getLocalizedTitle(),
		));
	}


	/**
	 * Add the additional sttings fields to the issue dao
	 *
	 * @param $hookName string
	 * @param $args array [
	 *		@option SectionDAO
	 *		@option array List of additional fields
	 * ]
	 */
	public function addIssueDaoFields($hookName, $args) {
		$fields =& $args[1];
		$fields[] = 'group1Items';
		$fields[] = 'group1IsSpecial';
		$fields[] = 'group1Editor';
		$fields[] = 'group2Name';
		$fields[] = 'group2Description';
		$fields[] = 'group2Items';
		$fields[] = 'group2IsSpecial';
		$fields[] = 'group2Editor';
		$fields[] = 'group3Name';
		$fields[] = 'group3Description';
		$fields[] = 'group3Items';
		$fields[] = 'group3IsSpecial';
		$fields[] = 'group3Editor';
		$fields[] = 'group4Name';
		$fields[] = 'group4Description';
		$fields[] = 'group4Items';
		$fields[] = 'group4IsSpecial';
		$fields[] = 'group4Editor';
		$fields[] = 'group5Name';
		$fields[] = 'group5Description';
		$fields[] = 'group5Items';
		$fields[] = 'group5IsSpecial';
		$fields[] = 'group5Editor';
		$fields[] = 'group6Name';
		$fields[] = 'group6Description';
		$fields[] = 'group6Items';
		$fields[] = 'group6IsSpecial';
		$fields[] = 'group6Editor';
	}

	/**
	 * Load the handler to deal with issue table of contents tab requests
	 *
	 * @param $hookName string `LoadComponentHandler`
	 * @param $args array [
	 * 		@option string component
	 * 		@option string op
	 * ]
	 * @return bool
	 */
	public function loadIssueTocHandler($hookName, $args) {
		$component = $args[0];

		if ($component === 'plugins.themes.criticalTimes.controllers.CriticalTimesIssueTocHandler') {
			$op = $args[1];
			$this->import('controllers.CriticalTimesIssueTocHandler');
			$handler = new CriticalTimesIssueTocHandler();
			$handler->_plugin = $this;
			if (method_exists($handler, $op)) {
				$request = Application::getRequest();
				$router = $request->getRouter();
				$serviceEndpoint = array($handler, $op);
				$router->_authorizeInitializeAndCallRequest($serviceEndpoint, $request, $args);
				exit;
			}
		}
	}

	/**
	 * Load custom data for the issue table of contents form
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
	public function loadIssueTocTemplateData($hookName, $args) {
		$templateMgr =& $args[0];
		$template = $args[1];

		if ($template === 'controllers/grid/issues/issueToc.tpl') {
			$this->import('controllers.CriticalTimesIssueTocFormHandler');
			$issueTocForm = new CriticalTimesIssueTocFormHandler($templateMgr->getTemplateVars('issue'));
			$issueTocForm->initData($request);
			$templateMgr->assign($issueTocForm->_data);
		}
	}

}

?>
