{# IMPORTANT Do not remove this hidden subtotal, it is used by JS to calculate cart total #}
<div class="subtotal-price hidden" data-priceraw="{{ cart.total }}"></div>

{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}

{# Used to assign currency to total #}
<div id="store-curr" class="hidden">{{ cart.currency }}</div>

<div class="{% if not cart_page%}cart-footer{% endif %} {% if not (settings.theme_variant == 'rounded' and cart_page) %}pt-3{% endif %}">

  {% if cart_page %}

    <div class="d-none d-md-block mb-2">

      {# Check if store has free shipping without regions or categories #}

      {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

      {% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}
        
        {# includes free shipping progress bar: only if store has free shipping with a minimum #}
        
        {% include "snipplets/shipping/shipping-free-rest.tpl" %}
      {% endif %}

    </div>

  {% endif %}

  {# Cart panel subtotal #}
  <div class="js-visible-on-cart-filled row mb-1" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-subtotal">
    <span class="col">
      {{ "Subtotal" | translate }}:
    </span>
    <span class="js-ajax-cart-total js-cart-subtotal col text-right" data-priceraw="{{ cart.subtotal }}" data-component="cart.subtotal" data-component-value="{{ cart.subtotal }}">{{ cart.subtotal | money }}</span>
  </div>
  <div id="shipping-cost-container" class="js-fulfillment-info js-visible-on-cart-filled js-shipping-cost-table row mb-1" {% if cart.items_count == 0 or (not cart.has_shippable_products) %}style="display:none;"{% endif %}>
    <span class="col-auto">{{ 'Envío:' | translate }}</span>
    <span class="col text-right opacity-40" id="shipping-cost">
      {% if show_calculator_on_cart %}
        {% if cart_page %}
          <span class="d-none d-md-block">{{'Calcular para verlo' | translate }}</span>
        {% endif %}
        {% if cart_page %}
          <span class="d-block d-md-none">
        {% endif %}
            {{ "Calculalo arriba para verlo" | translate }}
        {% if cart_page %}
          </span>
        {% endif %}
      {% else %}
        {{ "El costo se calcula más adelante" | translate }}
      {% endif %}
    </span>
    <span class="col text-right opacity-40 js-calculating-shipping-cost" style="display: none">
      {{ "Calculando" | translate }}...
    </span>
    <span class="col text-right opacity-40 js-shipping-cost-empty" style="display: none">
        {% if cart_page %}
          <span class="d-none d-md-block">{{'Calcular para verlo' | translate }}</span>
        {% endif %}
        {% if cart_page %}
          <span class="d-block d-md-none">
        {% endif %}
            {{ "Calculalo arriba para verlo" | translate }}
        {% if cart_page %}
          </span>
        {% endif %}
    </span>
  </div>

  {# Cart panel promos #}
  <div class="js-total-promotions text-accent font-weight-bold">
    <span class="js-promo-in" style="display:none;">{{ "en" | translate }}</span>
    <span class="js-promo-all" style="display:none;">{{ "todos los productos" | translate }}</span>
    <span class="js-promo-buying" style="display:none;"> {{ "comprando" | translate }}</span>
    <span class="js-promo-units-or-more" style="display:none;"> {{ "o más" | translate }}</span>
    {% for promotion in cart.promotional_discount.promotions_applied %}
      {% if(promotion.scope_value_id) %}
        {% set id = promotion.scope_value_id %}
      {% else %}
        {% set id = 'all' %}
      {% endif %}
        <span class="js-total-promotions-detail-row row" id="{{ id }}">
          <span class="col">
            {% if promotion.discount_script_type != "custom" %}
              {% if promotion.discount_script_type == "NAtX%off" %}
                {{ promotion.selected_threshold.discount_decimal_percentage * 100 }}% OFF
              {% else %}
                {{ promotion.discount_script_type }}
              {% endif %}

              {{ "en" | translate }} {% if id == 'all' %}{{ "todos los productos" | translate }}{% else %}{{ promotion.scope_value_name }}{% endif %}

              {% if promotion.discount_script_type == "NAtX%off" %}
                <span>{{ "Comprando {1} o más" | translate(promotion.selected_threshold.quantity) }}</span>
              {% endif %}
            {% else %}
              {{ promotion.scope_value_name }}
            {% endif %}
            :
          </span>
          <span class="col text-right">-{{ promotion.total_discount_amount_short }}</span>
        </span>
    {% endfor %}
  </div>

  {# Cart panel total #}

  <div class="js-cart-total-container js-visible-on-cart-filled mb-3 mt-3 cart-total" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-total">
    <h3 class="row text-primary mb-0">
      <strong class="col">{{ "Total" | translate }}:</strong>
      <strong class="js-cart-total {% if cart.free_shipping.cart_has_free_shipping %}js-free-shipping-achieved{% endif %} {% if cart.shipping_data.selected %}js-cart-saved-shipping{% endif %} col text-right" data-component="cart.total" data-component-value="{{ cart.total}}">{{ cart.total | money }}</strong>
    </h3>

    {# IMPORTANT Do not remove this hidden total, it is used by JS to calculate cart total #}
    <div class='total-price hidden'>
      {{ "Total" | translate }}: {{ cart.total | money }}
    </div>
    {{ component('installments', {'location': 'cart', container_classes: { installment: "font-small mt-1 text-right"}}) }}
  </div>

  <div class="js-visible-on-cart-filled container-fluid" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

    {# No stock alert #}

    <div id="error-ajax-stock" class='alert alert-warning' role='alert' style="display:none;">
       {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link">{{ "ver otros acá" | translate }}</a>
    </div>

    {# Cart panel CTA #}
    
    {% set cart_total = (settings.cart_minimum_value * 100) %}

    {% if cart_page %}

      {# Cart page CTA and minimum alert: Needs to be present or absence on DOM to work correctly with minimum price feature #}

      {% if cart.checkout_enabled %}
        <div class="row mb-3">
          <input id="go-to-checkout" class="btn btn-primary btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" data-component="cart.checkout-button"/>
        </div>
      {% else %}

        {# Cart minium alert #}

        <div class="alert alert-warning mt-4">
          {{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total | money) }}
        </div>
      {% endif %}

  
    {% else %}

      {# Cart popup CTA and minimum alert #}

      <div class="js-ajax-cart-submit row mb-3" {{ not cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-submit-div">
        <input class="btn btn-primary btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" data-component="cart.checkout-button"/>
      </div>

      {# Cart minium alert #}

      <div class="js-ajax-cart-minimum alert alert-warning mt-4" {{ cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-minumum-div">
        {{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total | money) }}
      </div>
      <input type="hidden" id="ajax-cart-minimum-value" value="{{ cart_total }}"/>

    {% endif %}

    {# Cart panel continue buying link #}

    <div class="row mb-2">
      <div class="text-center w-100">
        <a href="{% if cart_page %}{{ store.products_url }}{% else %}#{% endif %}" class="{% if not cart_page %}js-modal-close js-fullscreen-modal-close{% endif %} btn-link">{{ 'Ver más productos' | translate }}</a>
      </div>
    </div>
  </div>
</div>
