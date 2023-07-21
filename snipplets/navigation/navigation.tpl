<div class="utilities-container">
	{% if settings.search_more_visible %}
	<div class="row no-gutters align-items-center">
	{% endif %}
		<a href="#" class="js-modal-open utilities-link utilities-item {% if settings.search_more_visible %}col-auto pr-4{% endif %}" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
			{% include "snipplets/svg/bars.tpl" %}
		</a>
 	{% if settings.search_more_visible %}
	 	<div class="col-7 p-0">
	        <div class="d-none d-md-block">
	            {% snipplet "header/header-search.tpl" %}
	        </div>
	    </div>
    {% endif %}
    {% if settings.search_more_visible %}
	</div>
	{% endif %}
</div>
	