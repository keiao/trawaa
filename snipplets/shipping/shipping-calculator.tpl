{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

{# Free shipping visibility variables #}

{% if product_detail and cart.free_shipping.min_price_free_shipping.min_price %}

	{# Calculate if adding one more product free shipping is achieved #}

	{% set free_shipping_product_threashold = cart.free_shipping.min_price_free_shipping.min_price_raw - (cart.total + product.price) %}

	{% set hide_free_shipping_minimum = (cart.free_shipping.cart_has_free_shipping or not cart.free_shipping.min_price_free_shipping.min_price) or free_shipping_product_threashold <= 0 %}

{% else %}

	{% set hide_free_shipping_minimum = cart.free_shipping.cart_has_free_shipping or not cart.free_shipping.min_price_free_shipping.min_price %}

{% endif %}

{% set free_shipping_minimum_label_changes_visibility = product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set free_shipping_messages_visible = (product_detail and has_free_shipping) or (not product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw == 0) %}

{% set hide_cart_free_shipping_message = not product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 and product_detail %}

{% if product_detail %}
	{% set cart_zipcode = false %}
{% else %}
	{% set cart_zipcode = cart.shipping_zipcode %}
{% endif %}

<div class="{% if product_detail %}product-shipping-calculator{% else %}w-100{% endif %} mb-2" data-store="shipping-calculator">
	
	<div class="js-shipping-calculator-head shipping-calculator-head position-relative transition-soft mt-2 {% if cart_zipcode %}with-zip{% else %}with-form{% endif %} {% if free_shipping_messages_visible %}with-free-shipping{% endif %}">
	
		<div class="js-shipping-calculator-with-zipcode {% if cart_zipcode %}js-cart-saved-zipcode transition-up-active{% endif %} w-100 transition-up position-absolute">

			{% if free_shipping_messages_visible %}

				{# Free shipping labels when calculator is hidden #}

				<div class="free-shipping-title {% if product_detail %}text-md-left{% endif %}  transition-soft">

					{# Free shipping achieved label #}

					<div class="js-free-shipping-title position-absolute transition-up w-100 h4 {% if cart.free_shipping.cart_has_free_shipping %}transition-up-active{% endif %}">
						<span class="font-weight-bold text-accent">{{ "¡Genial! Tenés envío gratis" | translate }}</strong>
					</div>

					{# Free shipping with min price label #}

					{% if include_product_free_shipping_min_wording %}

						{% include "snipplets/shipping/shipping-free-rest.tpl" with {'calculator_label': false, 'product_detail': true} %}

					{% endif %}

					{# Free shipping with min price label #}

					<div class="js-free-shipping-title-min-cost position-absolute transition-up w-100 h5 {% if not hide_free_shipping_minimum %}transition-up-active{% endif %}">
						{{ "<strong class='text-accent'>Envío gratis</strong> superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
					</div>
				</div>

			{% endif %}
			<div class="col-12 p-0">
				<span class="form-label mr-3 mt-2 float-left w-auto">{{ "Entregas para el CP:" | translate }} <strong class="js-shipping-calculator-current-zip">{{ cart_zipcode }}</strong></span>
				<a class="js-shipping-calculator-change-zipcode btn btn-default btn-smallest w-auto d-inline-block float-md-none float-right" href="#">{{ "Cambiar CP" | translate }}</a>
			</div>
		</div>

		<div class="js-shipping-calculator-form transition-up position-absolute">

			{# Shipping calcualtor input #}

			{% embed "snipplets/forms/form-input.tpl" with{
				type_tel: true, 
				input_value: cart_zipcode, 
				input_name: 'zipcode', 
				input_custom_class: 'js-shipping-input', 
				input_label_custom_class: "pl-1", 
				input_custom_label_text: true, 
				input_placeholder: "Tu código postal" | translate, 
				input_label: false, input_append_content: true, 
				form_control_container_custom_class: 'col-7 col-lg-8 pr-0', 
				input_group_custom_class: 'form-row form-group-inline align-items-center mb-3',
				input_aria_label: 'Tu código postal' | translate } %}
				{% block input_custom_label_text %}

					{# Free shipping achieved label #}

					<span class="{% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} font-weight-bold text-accent" {% if not cart.free_shipping.cart_has_free_shipping or hide_cart_free_shipping_message %}style="display: none;"{% endif %}>
						{{ "¡Genial! Tenés envío gratis" | translate }}
					</span>

					{# Free shipping with min price label #}

					<span class="{% if free_shipping_minimum_label_changes_visibility %}js-shipping-calculator-label{% endif %} font-weight-bold" {% if hide_free_shipping_minimum or hide_cart_free_shipping_message %}style="display: none;"{% endif %}>
						{{ "<strong class='text-accent'>Envío gratis</strong> superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
					</span>

					{% if include_product_free_shipping_min_wording %}

						{% include "snipplets/shipping/shipping-free-rest.tpl" with {'calculator_label': true, 'product_detail': true} %}

					{% endif %}

					{# Shipping default label #}

					<span {% if free_shipping_minimum_label_changes_visibility %}class="js-shipping-calculator-label-default"{% endif %} {% if (product_detail and free_shipping_messages_visible) or (cart.free_shipping.min_price_free_shipping.min_price_raw == 0 and has_free_shipping) %}style="display: none;"{% endif %}>

						{# Regular shipping calculator label #}
						
						{{ 'Medios de envío' | translate }}
					</span>
				{% endblock input_custom_label_text %}
				{% block input_form_alert %}
				{% if store.country == 'BR' or 'AR' or 'MX' %}
					{% set zipcode_help_ar = 'https://www.correoargentino.com.ar/formularios/cpa' %}
					{% set zipcode_help_br = 'http://www.buscacep.correios.com.br/sistemas/buscacep/' %}
					{% set zipcode_help_mx = 'https://www.correosdemexico.gob.mx/datosabiertos/gobmx/gobmx_Descarga.html' %}
					<div class="col-12">
						<a class="font-small text-primary mt-3 mb-2 d-block" href="{% if store.country == 'AR' %}{{ zipcode_help_ar }}{% elseif store.country == 'BR' %}{{ zipcode_help_br }}{% elseif store.country == 'MX' %}{{ zipcode_help_mx }}{% endif %}" target="_blank">{{ "No sé mi código postal" | translate }}</a>
					</div>
				{% endif %}
				<div class="col-12">
					<div class="js-ship-calculator-error invalid-zipcode alert alert-danger" style="display: none;">
						{# Specific error message considering if store has multiple languages #}

						{% for language in languages %}
							{% if language.active %}
								{% if languages | length > 1 %}
									{% set wrong_zipcode_wording = ' para ' | translate ~ language.country_name ~ '. Podés intentar con otro o' | translate %}
								{% else %}
									{% set wrong_zipcode_wording = '. ¿Está bien escrito?' | translate %}
								{% endif %}
								{{ "No encontramos este código postal{1}" | translate(wrong_zipcode_wording) }}

								{% if languages | length > 1 %}
									<a href="#" data-toggle="#{% if product_detail %}product{% else %}cart{% endif %}-shipping-country" class="js-modal-open btn-link btn-link-primary text-lowercase">
										{{ 'cambiar tu país de entrega' | translate }}
									</a>
								{% endif %}
							{% endif %}
						{% endfor %}
					</div>
					<div class="js-ship-calculator-error js-ship-calculator-common-error alert alert-danger" style="display: none;">{{ "Ocurrió un error al calcular el envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
					<div class="js-ship-calculator-error js-ship-calculator-external-error alert alert-danger" style="display: none;">{{ "El calculo falló por un problema con el medio de envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
				</div>
				{% endblock input_form_alert %}
				{% block input_append_content %}
					<div class="col-5 col-lg-4 pl-0">
						<button class="js-calculate-shipping btn btn-default btn-block" aria-label="{{ 'Calcular envío' | translate }}">	
							<span class="js-calculate-shipping-wording">{{ "Calcular" | translate }}</span>
							<span class="js-calculating-shipping-wording" style="display: none;">{{ "Calculando" | translate }}</span>
						</button>
						{% if shipping_calculator_variant %}
							<input type="hidden" name="variant_id" id="shipping-variant-id" value="{{ shipping_calculator_variant.id }}">
						{% endif %}
					</div>
				{% endblock input_append_content %}
			{% endembed %}
		</div>
	</div>
	<div class="js-shipping-calculator-spinner mb-3 float-left w-100 transition-soft text-center text-md-left" style="display: none;">
		<div class="spinner-ellipsis"></div>
	</div>
	<div class="js-shipping-calculator-response mb-3 float-left w-100 {% if product_detail %}list{% endif %}" style="display: none;"></div>
</div>

{# Shipping country modal #}

{% if languages | length > 1 %}

	{% if product_detail %}
		{% set country_modal_id = 'product-shipping-country' %}
	{% else %}
		{% set country_modal_id = 'cart-shipping-country' %}
	{% endif %}

	{% embed "snipplets/modal.tpl" with{modal_id: country_modal_id, modal_class: 'bottom modal-centered-small js-modal-shipping-country', modal_position: 'center', modal_transition: 'slide', modal_header: true, modal_footer: true, modal_width: 'centered', modal_zindex_top: true} %}
		{% block modal_head %}
		    {{ 'País de entrega' | translate }}
		{% endblock %}
		{% block modal_body %}
		    {% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: 'País donde entregaremos tu compra' | translate, select_aria_label: 'País donde entregaremos tu compra' | translate, select_custom_class: 'js-shipping-country-select', select_group_custom_class: 'mt-4' } %}
				{% block select_options %}
					{% for language in languages %}
						<option value="{{ language.country }}" data-country-url="{{ language.url }}" {% if language.active %}selected{% endif %}>{{ language.country_name }}</option>
					{% endfor %}
				{% endblock select_options%}
			{% endembed %}
		{% endblock %}
		{% block modal_foot %}
			<a href="#" class="js-save-shipping-country btn btn-primary float-right">{{ 'Aplicar' | translate }}</a>
		{% endblock %}
	{% endembed %}
{% endif %}