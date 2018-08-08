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
		<footer id="content-footer">
			{include file="frontend/components/browseArchives.tpl"}
			<div class="siteFooter">
				<div class="siteFooter__main -clearFix">
					<div class="siteFooter__contactColumn">
						<a class="siteFooter__siteLogo" href="{$homeUrl}">
							<img src="{$ctThemePath|concat:"/img/logo-white.png"}" alt="{translate|escape key="plugins.themes.criticalTimes.logoAltText"}">
						</a>
						<div class="siteFooter__address">
							{$currentJournal->getData('mailingAddress')|strip_unsafe_html|nl2br}
						</div>
						<div class="siteFooter__social">
							<a class="siteFooter__socialItem" href="https://www.facebook.com/Critical-Times-Interventions-in-Global-Critical-Theory-441655652939972/">
								<span class="fa fa-facebook-square"></span>
							</a>
						</div>
					</div>
					<div class="siteFooter__sitemapColumn">
						{load_menu name="footer" ulClass="siteFooter__siteMap" liClass="siteFooter__siteMapItem"}
					</div>
					<div class="siteFooter__platformColumn">
						<a class="siteFooter__platformLink" href="{url page="about" op="aboutThisPublishingSystem"}">
							<img alt="{translate key="about.aboutThisPublishingSystem"}" src="{$baseUrl}/templates/images/ojs_brand_white.png">
						</a>
					</div>
				</div>
				<div class="siteFooter__support">
					{translate key="plugins.themes.criticalTimes.footer.support"}
				</div>
			</div>
		</footer>
	</div><!-- .siteWrapper -->

	{* Used as a screen on the page when the nav menu is open on small screens *}
	<div id="siteHeader__screen" class="siteHeader__screen"></div>

	{load_script context="frontend"}
	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
