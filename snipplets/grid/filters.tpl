
{% if applied_filters %}

	{# Applied filters chips #}

	{% if has_applied_filters %}

		<div class="mt-4 text-center">
			<p>{{ 'Filtro aplicado:' | translate }}</p>
			{% for product_filter in product_filters %}
				{% for value in product_filter.values %}

					{# List applied filters as tags #}
					
					{% if value.selected %}
						<button class="js-remove-filter chip" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.pill-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
							{{ value.pill_label }}
							{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-icon-text chip-remove-icon"} %}
						</button>
					{% endif %}
				{% endfor %}
			{% endfor %}
			<a href="#" class="js-remove-all-filters btn-link btn-link-primary mt-1" data-component="filter-delete">{{ 'Borrar filtros' | translate }}</a> 
		</div>
	{% endif %}
{% else %}
	{% embed "snipplets/modal.tpl" with{modal_id: 'nav-filters', modal_class: 'filters', modal_position: 'top', modal_transition: 'slide', modal_header: true, modal_context_sm: true, modal_width: 'full', modal_mobile_full_screen: 'true'} %}
		{% block modal_head %}
			{{'Filtros ' | translate }}
		{% endblock %}
		{% block modal_body %}
			<div class="container-fluid" data-store="filters-nav">
				<div id="filters" class="row mt-5 mt-sm-2">
					{% if filter_categories is not empty %}
						{% snipplet 'grid/categories.tpl' %}
					{% endif %}
					{% if product_filters is not empty %}
						{% for product_filter in product_filters %}
							{% if product_filter.type == 'price' %}

								{% if settings.theme_variant == 'rounded' %}
									{% set btn_price_class = 'btn-default btn-smallest d-inline-block pr-3' %}
								{% else %}
									{% set btn_price_class = 'btn-link btn-link-primary ml-2' %}
								{% endif %}

			                    {{ component(
									'price-filter',
									{'group_class': 'price-filter-container col-12 col-sm-4 mb-5 mb-sm-3 p-0 p-sm-3', 'title_class': 'h4 font-weight-bold mb-3', 'button_class': 'btn ' ~ btn_price_class }
								) }}

			                {% else %}
								{% if product_filter.has_products %}
									<div class="col-12 col-sm-4 mb-5 mb-sm-3 p-0 p-sm-3" data-store="filters-group" data-component="list.filter-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
										<h4 class="mb-3"><strong>{{product_filter.name}}</strong></h4>
										{% set index = 0 %}
										{% for value in product_filter.values %}
											{% if value.product_count > 0 %}
												{% set index = index + 1 %}
												{% if product_filter.type == 'color' and index == 1 %}
													<div class="row filter-color-container">
												{% endif %}
													<label class="js-filter-checkbox {% if not value.selected %}js-apply-filter{% else %}js-remove-filter{% endif %} checkbox-container btn-filter {% if product_filter.type == 'color' %}btn-filter-color {% if value.color_type == 'insta_color' %}color-filter{% else %}color-filter-custom{% endif %}{% endif %}" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.option" data-component-value="{{ value.name }}">
														<input type="checkbox" autocomplete='off' {% if value.selected %}checked{% endif %}>
														<span class="checkbox">
															{% if product_filter.type == 'color' and value.color_type == 'insta_color' %}
																<span class="checkbox-color" style="background-color: {{ value.color_hexa }};"></span>
																<span class="text-color m-left p-left-quarter">
															{% endif %}
																{{ value.name }} ({{ value.product_count }})
															{% if product_filter.type == 'color' and value.color_type == 'insta_color' %}
																</span>
															{% endif %}
														</span>
													</label>
												{% if index == 8 and product_filter.values_with_products > 8 %}
													{% if product_filter.type == 'color' %}
													</div>
													{% endif %}
													<div class="js-accordion-container {% if product_filter.type == 'color' %}row filter-color-container hidden-filters{% else %}float-left w-100{% endif %}" style="display: none;">
												{% endif %}
											{% endif %}
											{% if loop.last and product_filter.values_with_products > 8 %}
												</div>
												<a href="#" class="js-accordion-toggle btn btn-link btn-link-primary pl-0 float-left w-100 mt-2 text-left">
													<span class="js-accordion-toggle-inactive">
														{{ 'Ver todos' | translate }}
													</span>
													<span class="js-accordion-toggle-active" style="display: none;">
														{{ 'Ver menos' | translate }}
													</span>
												</a>
											{% endif %}
											{% if product_filter.type == 'color' and loop.last and product_filter.values_with_products <= 8 %}
												</div>
											{% endif %}
										{% endfor %}
									</div>
								{% endif %}
							{% endif %}
						{% endfor %}	
					{% endif %}
				</div>
			</div>
			<div class="js-filters-overlay filters-overlay" style="display: none;">
				<div class="filters-updating-message">
					<h3 class="js-applying-filter" style="display: none;">{{ 'Aplicando filtro...' | translate }}</h3>
					<h3 class="js-removing-filter" style="display: none;">{{ 'Borrando filtro...' | translate }}</h3>
				</div>
			</div>
		{% endblock %}
	{% endembed %}
{% endif %}
