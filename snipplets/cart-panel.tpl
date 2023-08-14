<div class="js-ajax-cart-list">
    {# Cart panel items #}
    {% if cart.items %}
      {% for item in cart.items %}
        {% include "snipplets/cart-item-ajax.tpl" %}
      {% endfor %}
    {% endif %}
</div>
<div class="js-empty-ajax-cart" {% if cart.items_count > 0 %}style="display:none;"{% endif %}>
 	{# Cart panel empty #}
    <div class="alert alert-info" data-component="cart.empty-message">{{ "El carrito de compras está vacío." | translate }} </div>
</div>
<div id="error-ajax-stock" style="display: none;">
	<div class="alert alert-warning">
     	{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link ml-1">{{ "ver otros acá" | translate }}</a>
    </div>
</div>

<div style="width: 100%; max-width:100%; min-width: 0px;">
  {% include "snipplets/cart-slider-product.tpl" %}
</div>

{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

{% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}
  
  {# includes free shipping progress bar: only if store has free shipping with a minimum #}
  
  {% include "snipplets/shipping/shipping-free-rest.tpl" %}
{% endif %}

{% include "snipplets/cart-shipping.tpl" with {'cart_popup': true} %}
