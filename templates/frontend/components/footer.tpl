{**
 * lib/pkp/templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site footer.
 *}

		</div><!-- .siteBody -->
		<footer id="content-footer"></footer>
	</div><!-- .siteWrapper -->

	{load_script context="frontend"}
	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
