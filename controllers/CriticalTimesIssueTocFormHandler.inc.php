<?php
/**
 * @file controllers/CriticalTimesIssueTocFormHandler.inc.php
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Handle form to save the custom table of contents setup
 */
import('lib.pkp.classes.form.Form');

class CriticalTimesIssueTocFormHandler extends Form {
	/**
	 * Issue being edited
	 *
	 * @param Issue
	 */
	public $_issue;

	/**
	 * Constructor
	 * @param $issue int
	 */
	function __construct($issue) {
		parent::__construct('controllers/grid/issues/issueToc.tpl');
		$this->addCheck(new FormValidatorPost($this));
		$this->addCheck(new FormValidatorCSRF($this));
		$this->_issue = $issue;
	}

	/**
	 * @copydoc Form::initData()
	 */
	function initData($request) {
		$this->setData('group1Items', $this->_issue->getData('group1Items'));
		$this->setData('group1IsSpecial', $this->_issue->getData('group1IsSpecial'));
		$this->setData('group2Name', $this->_issue->getData('group2Name'));
		$this->setData('group2Description', $this->_issue->getData('group2Description'));
		$this->setData('group2Items', $this->_issue->getData('group2Items'));
		$this->setData('group2IsSpecial', $this->_issue->getData('group2IsSpecial'));
		$this->setData('group3Name', $this->_issue->getData('group3Name'));
		$this->setData('group3Description', $this->_issue->getData('group3Description'));
		$this->setData('group3Items', $this->_issue->getData('group3Items'));
		$this->setData('group3IsSpecial', $this->_issue->getData('group3IsSpecial'));
		$this->setData('group4Name', $this->_issue->getData('group4Name'));
		$this->setData('group4Description', $this->_issue->getData('group4Description'));
		$this->setData('group4Items', $this->_issue->getData('group4Items'));
		$this->setData('group4IsSpecial', $this->_issue->getData('group4IsSpecial'));
		$this->setData('group5Name', $this->_issue->getData('group5Name'));
		$this->setData('group5Description', $this->_issue->getData('group5Description'));
		$this->setData('group5Items', $this->_issue->getData('group5Items'));
		$this->setData('group5IsSpecial', $this->_issue->getData('group5IsSpecial'));
		$this->setData('group6Name', $this->_issue->getData('group6Name'));
		$this->setData('group6Description', $this->_issue->getData('group6Description'));
		$this->setData('group6Items', $this->_issue->getData('group6Items'));
		$this->setData('group6IsSpecial', $this->_issue->getData('group6IsSpecial'));
		parent::initData($request);
	}

	/**
	 * @copydoc Form::readInputData()
	 */
	function readInputData() {
		$this->readUserVars(array(
			'group1Items','group1IsSpecial',
			'group2Name','group2Description','group2Items','group2IsSpecial',
			'group3Name','group3Description','group3Items','group3IsSpecial',
			'group4Name','group4Description','group4Items','group4IsSpecial',
			'group5Name','group5Description','group5Items','group5IsSpecial',
			'group6Name','group6Description','group6Items','group6IsSpecial',
		));
	}

	/**
	 * Save issue table of content settings.
	 * @param $request PKPRequest
	 */
	function execute($request) {
		$context = $request->getContext();
		$contextId = $context ? $context->getId() : CONTEXT_ID_NONE;
		$issueDao = DAORegistry::getDAO('IssueDAO');

		$this->_issue->setData('group1Items', $this->getData('group1Items'));
		$this->_issue->setData('group1IsSpecial', $this->getData('group1IsSpecial'));
		$this->_issue->setData('group2Name', $this->getData('group2Name'));
		$this->_issue->setData('group2Description', $this->getData('group2Description'));
		$this->_issue->setData('group2Items', $this->getData('group2Items'));
		$this->_issue->setData('group2IsSpecial', $this->getData('group2IsSpecial'));
		$this->_issue->setData('group3Name', $this->getData('group3Name'));
		$this->_issue->setData('group3Description', $this->getData('group3Description'));
		$this->_issue->setData('group3Items', $this->getData('group3Items'));
		$this->_issue->setData('group3IsSpecial', $this->getData('group3IsSpecial'));
		$this->_issue->setData('group4Name', $this->getData('group4Name'));
		$this->_issue->setData('group4Description', $this->getData('group4Description'));
		$this->_issue->setData('group4Items', $this->getData('group4Items'));
		$this->_issue->setData('group4IsSpecial', $this->getData('group4IsSpecial'));
		$this->_issue->setData('group5Name', $this->getData('group5Name'));
		$this->_issue->setData('group5Description', $this->getData('group5Description'));
		$this->_issue->setData('group5Items', $this->getData('group5Items'));
		$this->_issue->setData('group5IsSpecial', $this->getData('group5IsSpecial'));
		$this->_issue->setData('group6Name', $this->getData('group6Name'));
		$this->_issue->setData('group6Description', $this->getData('group6Description'));
		$this->_issue->setData('group6Items', $this->getData('group6Items'));
		$this->_issue->setData('group6IsSpecial', $this->getData('group6IsSpecial'));

		$issueDao->updateObject($this->_issue);

		parent::execute();
	}


}
