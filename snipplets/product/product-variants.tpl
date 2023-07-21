{% if quickshop %}
	<div class="col{% if settings.theme_variant == 'squared' %}-8{% else %}-10{% endif %} d-inline-block text-left mt-2 p-0">
{% endif %}
<div class="js-product-variants{% if quickshop %} js-product-quickshop-variants{% endif %} form-row">
	{% set has_size_variations = false %}
	{% for variation in product.variations %}
		<div class="js-product-variants-group {% if variation.name in ['Color', 'Cor'] %}js-color-variants-container{% endif %} {% if quickshop %} col-12{% else %}{% if loop.length == 1 %} col-6 {% else %} col-12 {% endif %} {% if loop.length == 3 %} col-md-4 {% else %} col-md-6 {% endif %}{% endif %}">
			{% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index , select_id: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']', select_custom_class: 'js-variation-option js-refresh-installment-data', select_data_attr: 'product-id', select_data_val: product.id} %}
				{% block select_options %}
					{% for option in variation.options %}
						<option value="{{ option.id }}" {% if product.default_options[variation.id] == option.id %}selected="selected"{% endif %}>{{ option.name }}</option>
					{% endfor %}
				{% endblock select_options%}
			{% endembed %}
		</div>
		{% if variation.name in ['Talle', 'Talla', 'Tamanho', 'Size'] %}
			{% set has_size_variations = true %}
		{% endif %}
	{% endfor %}
	{% if has_one_variant and not quickshop %}
		{% include "snipplets/product/product-quantity.tpl" %}
	{% endif %}
	{% if show_size_guide and settings.size_guide_url and has_size_variations %}
		{% set has_size_guide_page_finded = false %}
		{% set size_guide_url_handle = settings.size_guide_url | trim('/') | split('/') | last %}

		{% for page in pages if page.handle == size_guide_url_handle and not has_size_guide_page_finded %}
			{% set has_size_guide_page_finded = true %}
			{% if has_size_guide_page_finded %}
				<a data-toggle="#size-guide-modal" data-modal-url="modal-fullscreen-size-guide" class="js-modal-open js-fullscreen-modal-open btn-link font-small col-12 mb-4">
					{% include "snipplets/svg/ruler-combined.tpl" with {svg_custom_class: "svg-inline--fa fa-lg svg-icon-text mr-1"} %}
					{{ 'Guía de talles' | translate }}
				</a>
				{% embed "snipplets/modal.tpl" with{modal_id: 'size-guide-modal', modal_position: 'bottom', modal_transition: 'slide', modal_header: true, modal_footer: false, modal_width: 'centered', modal_form_class: 'modal-fixed-wrapper', fixed_header: true, modal_mobile_full_screen: 'true'} %}
					{% block modal_head %}
						{{ 'Guía de talles' | translate }}
					{% endblock %}
					{% block modal_body %}
						<div class="user-content">
							{{ page.content }}
						</div>
					{% endblock %}
				{% endembed %}
			{% endif %}
		{% endfor %}
	{% endif %}
</div>
{% if quickshop %}
	</div>
{% endif %}