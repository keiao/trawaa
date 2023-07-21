<form class="js-search-container js-search-form" action="{{ store.search_url }}" method="get">
	<div class="form-group search-container form-vertical-align mb-0">
        <input class="js-search-input form-control small search-input" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscador' | translate }}"/>
        <button type="submit" class="search-input-submit" value="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscar' | translate }}">
            {% include "snipplets/svg/search.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text"} %}
        </button>
	</div>
</form>
<div class="js-search-suggest search-suggest">
    {# AJAX container for search suggestions #}
</div>
