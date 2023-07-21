<div class="js-visible-on-cart-filled js-has-new-shipping js-shipping-calculator-container container-fluid" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

  {# Define contitions to show shipping calculator and store branches on cart #}

  {% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}

  {# Saved shipping not available #}

  <div class="js-shipping-method-unavailable alert alert-warning row" style="display: none;">
    <div class="mr-1">
      <strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible para este carrito. ' | translate }}</strong>
    </div>
    <div>
      {{ '¡No te preocupes! Podés elegir otro.' | translate}}
    </div>
  </div>

  {# Shipping calculator and branch link #}

  <div id="cart-shipping-container" class="row" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

    {% if template == 'cart' %}
      <div class="col-12 col-md-6 {% if settings.theme_variant == 'rounded' %}pl-0 pr-0{% endif %}">
    {% endif %}
      {% if show_cart_fulfillment %}
        <div class="js-fulfillment-info js-allows-non-shippable w-100" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>
          {# Used to save shipping #}

          <span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hidden">{{ cart.shipping_data.name }}</span>

          {# Shipping Calculator #}

          {% if store.has_shipping %}
            {% include "snipplets/shipping/shipping-calculator.tpl" with {'product_detail': false} %}
          {% endif %}

          {% if store.branches %}

            {# Link for branches #}

            {% include "snipplets/shipping/branches.tpl" with {'product_detail': false} %}
          {% endif %}
        </div>
      {% endif %}
    {% if template == 'cart' %}
      </div>
    {% endif %}
  </div>
</div>