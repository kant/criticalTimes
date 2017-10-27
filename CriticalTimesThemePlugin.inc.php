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

		$this->addMenuArea(array('primary', 'footer1', 'footer2'));
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.themes.criticalTimes.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.themes.criticalTimes.description');
	}
}

?>
