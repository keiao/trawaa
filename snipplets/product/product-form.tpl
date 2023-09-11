{# Product name and breadcrumbs #}

{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
{% endembed %}

{# Product price #}

<div class="price-container" data-store="product-price-{{ product.id }}">
    <span class="d-inline-block mr-3">
        <h3 class="js-price-display regular-price" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</h3>
    </span>
    <span class="d-inline-block">
	   <h3 id="compare_price_display" class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</h3>
    </span>
</div>

{# Promotional text #}

{% if product.promotional_offer and not product.promotional_offer.script.is_percentage_off and product.display_price %}
    <div class="js-product-promo-container" data-store="product-promotion-info">
        {% if product.promotional_offer.script.is_discount_for_quantity %}
            {% for threshold in product.promotional_offer.parameters %}
                <h4 class="mb-2 text-accent"><strong>{{ "¡{1}% OFF comprando {2} o más!" | translate(threshold.discount_decimal_percentage * 100, threshold.quantity) }}</strong></h4>
            {% endfor %}
        {% else %}
            <h4 class="mb-2 text-accent"><strong>{{ "¡Llevá {1} y pagá {2}!" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}</strong></h4>
        {% endif %}
        {% if product.promotional_offer.scope_type == 'categories' %}
            <p>{{ "Válido para" | translate }} {{ "este producto y todos los de la categoría" | translate }}:
            {% for scope_value in product.promotional_offer.scope_value_info %}
               {{ scope_value.name }}{% if not loop.last %}, {% else %}.{% endif %}
            {% endfor %}</br>{{ "Podés combinar esta promoción con otros productos de la misma categoría." | translate }}</p>
        {% elseif product.promotional_offer.scope_type == 'all'  %}
            <p>{{ "Vas a poder aprovechar esta promoción en cualquier producto de la tienda." | translate }}</p>
        {% endif %}
    </div>
{% endif %}

{# Product installments #}

{% set installments_info = product.installments_info_from_any_variant %}
{% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
{% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}

{% if show_payments_info or hasDiscount %}
    <div data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments" class="js-fullscreen-modal-open js-product-payments-container js-modal-open row mb-4" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}> 
        {% if show_payments_info %}
            {% set max_installments_without_interests = product.get_max_installments(false) %}
            {% set installments_without_interests = max_installments_without_interests and max_installments_without_interests.installment > 1 %}
            {% set card_icon_color = installments_without_interests ? 'svg-icon-accent' : 'svg-icon-text' %}  

            <div class="col-12 mb-2">
                <span class="float-left mr-2">
                    {% include "snipplets/svg/credit-card-blank.tpl" with {svg_custom_class : "svg-inline--fa fa-lg mr-2 " ~ card_icon_color ~ " float-left "} %}
                </span>
                {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "product-detail-installments d-table text-inline"}}) }}
            </div>
        {% endif %}

        {% if hasDiscount %}
            <span class="col-12 mb-2">
                {% include "snipplets/svg/money-bill-wave.tpl" with {fa_custom_class : "fa-lg mr-2 svg-icon-accent float-left"} %}
                <span><strong class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}</span>
            </span>
        {% endif %}
        <a id="btn-installments" class="btn-link btn-link-primary font-small col" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
            <span class="d-table text-inline">
              {% if not hasDiscount and not settings.product_detail_installments %}
                {% include "snipplets/svg/credit-card-blank.tpl" with {svg_custom_class : "svg-inline--fa fa-lg svg-icon-primary mr-1"} %}
                {{ "Ver medios de pago" | translate }}
              {% else %}
                {{ "Ver más detalles" | translate }}
              {% endif %}
            </span>
        </a>
    </div>
{% endif %}

{# Product form, includes: Variants, CTA and Shipping calculator #}

 <form id="product_form" class="js-product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
	<input type="hidden" name="add_to_cart" value="{{product.id}}" />

    {% set has_one_variant = true %}
    {% for variation in product.variations %}
        {% if product.variations | length > 1 %}
            {% set has_one_variant = false %}
        {% endif %}
    {% endfor %}

    {% if product.variations %}
        {% include "snipplets/product/product-variants.tpl" with {show_size_guide: true} %}
    {% endif %}

    {# If product has 1 variation includes quantity input next to variation else it´s included inside product-variants.tpl #}

    {% if not has_one_variant or not product.variations %}
        {% include "snipplets/product/product-quantity.tpl" %}
    {% endif %}
    {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
    {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

    <div class="mb-3 full-width-container">

        {# Add to cart CTA #}

        <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block mb-2 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart"/>

        {# Fake add to cart CTA visible during add to cart event #}

        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "mb-2"} %}

        {% if settings.ajax_cart %}
            <div class="js-added-to-cart-product-message mt-1 mb-3 full-width-container text-center text-md-left" style="display: none;">
                {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-fullscreen-modal-open btn btn-link ml-1" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
            </div>
        {% endif %}

    </div>

    {# Define contitions to show shipping calculator and store branches on product page #}

    {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

    {% if show_product_fulfillment %}

        {# Shipping calculator and branch link #}

        <div id="product-shipping-container" class="product-shipping-calculator list-readonly float-left w-100" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

            {# Shipping Calculator #}

            {% if store.has_shipping %}
                {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
            {% endif %}

            {% if store.branches %}

                {# Link for branches #}
                {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
            {% endif %}
        </div>
    {% endif %}
 </form>

{# Product payments details #}

{% include 'snipplets/product/product-payment-details.tpl' %}

{# Product description and informative banners #}

{% set product_informative_banners_show = settings.product_informative_banner_01_show or settings.product_informative_banner_02_show or settings.product_informative_banner_03_show %}

{% set has_banners_and_description = product_informative_banners_show and product.description is not empty %}

{# Show tabs if there is a description, informative banners and informative banners title #}

<div data-store="product-description-{{ product.id }}">
    {% if has_banners_and_description and settings.product_informative_banners_title %}
        <div class="js-tab-container">
            <ul class="js-tab-group tab-group w-100">
                <li id="tab_head_description" class="js-tab tab active">
                    <a href="#tab_description" class="js-tab-link tab-link">{{ 'Descripción' | translate }}</a>
                </li>
                <li id="tab_head_informative_banners" class="js-tab tab">
                    <a href="#tab_informative_banners" class="js-tab-link tab-link">{{ settings.product_informative_banners_title }}</a>
                </li>
            </ul>
            <div class="js-tabs-content tab-content">
                <div id="tab_description" class="js-tab-panel tab-panel js-gw-tab-pane active">
                    <div class="product-description user-content">
                        {{ product.description }}
                    </div>
                </div>
                <div id="tab_informative_banners" class="js-tab-panel tab-panel js-gw-tab-pane">
                    {% include 'snipplets/product/product-informative-banner.tpl' %}
                </div>
            </div>
        </div>

        {# If there is no title, show informative banners and description without tabs #}

    {% elseif has_banners_and_description and not settings.product_informative_banners_title %}
       
        {% include 'snipplets/product/product-informative-banner.tpl' %}
        <div class="product-description user-content">
            {{ product.description }}
        </div>

        {# If there is no description, show only informative banners #}

    {% elseif product_informative_banners_show and product.description is empty %}
        
        <p class="mb-3 font-weight-bold">{{ settings.product_informative_banners_title }}</p>

        {% include 'snipplets/product/product-informative-banner.tpl' %}

        {# If there is no informative banners, show only description #}

    {% elseif not product_informative_banners_show and product.description is not empty %}
        <div class="product-description user-content">
            {{ product.description }}
        </div>
    {% endif %}
</div>

{# Product share #}

{% include 'snipplets/social/social-share.tpl' %}


