/**
 * @file plugins/themes/criticalTimes/js/main.js
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Handle JavaScript functionality unique to this theme.
 */
(function($) {

	// Initialize dropdown navigation menus
	// See bootstrap dropdowns: https://getbootstrap.com/docs/4.0/components/dropdowns/
	if (typeof $.fn.dropdown !== 'undefined') {
		$('[data-toggle="dropdown"]').dropdown();
	}
})(jQuery);
