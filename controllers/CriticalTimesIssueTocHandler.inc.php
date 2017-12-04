<?php
/**
 * @file controllers/CriticalTimesIssueTocHandler.inc.php
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Handle requests to save the custom table of contents setup
 */

import('lib.pkp.classes.handler.PKPHandler');

class CriticalTimesIssueTocHandler extends PKPHandler {
	/**
	 * CriticalTimes theme plugin
	 *
	 * @param ThemePlugin
	 */
	public $_plugin;

	/**
	 * Constructor
	 */
	function __construct() {
		parent::__construct();
		$this->addRoleAssignment(
			array(ROLE_ID_MANAGER),
			array('saveToc')
		);
	}


	//
	// Implement template methods from PKPHandler
	//
	/**
	 * @copydoc PKPHandler::authorize()
	 */
	function authorize($request, &$args, $roleAssignments) {
		import('lib.pkp.classes.security.authorization.ContextAccessPolicy');
		$this->addPolicy(new ContextAccessPolicy($request, $roleAssignments));

		// Require a valid issue ID
		if ($request->getUserVar('issueId')) {
			// PKPComponentRouter only looks for the parameter in $args, not in the
			// request user vars. This is just a little hack to add the user var to
			// the $args so it can place the issue in the authorized objects
			$args['issueId'] = $request->getUserVar('issueId');
			import('classes.security.authorization.OjsIssueRequiredPolicy');
			$this->addPolicy(new OjsIssueRequiredPolicy($request, $args));
		}

		return parent::authorize($request, $args, $roleAssignments);
	}

	/**
	 * Handle requests to save the custom table of contents settings
	 */
	function saveToc($args, $request) {
		$this->_plugin->import('controllers.CriticalTimesIssueTocFormHandler');
		$issue = $this->getAuthorizedContextObject(ASSOC_TYPE_ISSUE);
		$issueTocForm = new CriticalTimesIssueTocFormHandler($issue);
		$issueTocForm->readInputData();

		if ($issueTocForm->validate($request)) {
			$issueTocForm->execute($request);
			$notificationManager = new NotificationManager();
			$notificationManager->createTrivialNotification($request->getUser()->getId());
			return DAO::getDataChangedEvent();
		}

		return new JSONMessage(true, $issueTocForm->fetch($request));
	}
}

?>
