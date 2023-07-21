<div class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %}" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item" data-component-value="{{ item.product.id }}">

  {% set show_free_shipping_label = item.product.free_shipping and not (cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price) %}

  <div class="cart-item {% if cart_page %}row align-items-md-center {% if settings.theme_variant == 'squared' %}mb-0 ml-1 mr-1 ml-md-3 mr-md-3{% else %}{% if loop.last %}mb-0{% else %}mb-5{% endif %}{% endif %}{% else %}form-row{% endif %}">

    {# Cart item image #}
    <div class="{% if cart_page %}col-3 col-md-auto{% else %}col-3 pr-3{% endif %}">
      <a href="{{ item.url }}">
        <img src="{{ item.featured_image | product_image_url('medium') }}" class="img-fluid {% if cart_page %}cart-item-img{% endif %}" />
      </a>
    </div>
    <div class="{% if cart_page %}col-9 col-md pl-0 pl-md-3{% else %}col-9 d-flex align-items-center{% endif %}">
      <div class="{% if cart_page %}row align-items-center{% else %}w-100{% endif %}">

        {# Cart item name #}
        <div class="h6 mb-3 mb-md-0 {% if cart_page %}col-12 col-md-6 h4-md font-weight-normal{% else %}cart-item-name{% endif %}" data-component="line-item.name">
          <a href="{{ item.url }}">
            <span class="mb-1" data-component="name.short-name">{{ item.short_name }}</span>
            <span class="font-small opacity-50" data-component="name.short-variant-name">{{ item.short_variant_name }}</span>
          </a>
          {% if show_free_shipping_label %}
            <div class="my-1">
              <span class="label label-accent label-small font-smallest">{{ "Envío gratis" | translate }}</span>
            </div>
          {% endif %}
        </div>

        {# Cart item subtotal mobile #}
        <div class="js-cart-item-subtotal cart-item-subtotal font-weight-bold mb-3 {% if cart_page %}col-12 d-md-none{% else %}mt-2{% endif %}" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value="{{item.subtotal}}">{{ item.subtotal | money }}</div>

        {# Cart item quantity controls #}
        {% if cart_page %}
          <div class="col-12 col-md-3 text-center">
        {% endif %}

        {% if cart_page %}
          {% set cart_quantity_class = 'mb-0' %}
        {% else %}
          {% set cart_quantity_class = 'mb-2' %}
        {% endif %}

          <div class="cart-item-quantity {% if cart_page %}m-md-auto{% endif %}">
            {% embed "snipplets/forms/form-input.tpl" with{
              type_number: true, 
              input_value: item.quantity, 
              input_name: 'quantity[' ~ item.id ~ ']', 
              input_data_attr: 'item-id',
              input_data_val: item.id,
              input_group_custom_class: 'form-quantity small ' ~ cart_quantity_class, 
              input_custom_class: 'js-cart-quantity-input text-center', 
              input_label: false, input_append_content: true, 
              input_data_component: 'quantity.value',
              input_data_component_value: item.quantity,
              form_control_container_custom_class: 'col pl-0 pr-0'} %}
                {% block input_prepend_content %}
                <div class="row m-0 align-items-center " data-component="line-item.quantity">
                  <span class="js-cart-quantity-btn text-center btn" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.minus">
                    {% include "snipplets/svg/minus.tpl" %}
                  </span>
                {% endblock input_prepend_content %}
                {% block input_append_content %}
                  <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                    {% include "snipplets/svg/sync.tpl" with {svg_custom_class : "svg-inline--fa fa-spin svg-icon-text"} %}
                  </span>
                  <span class="js-cart-quantity-btn text-center btn" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.plus">
                    {% include "snipplets/svg/plus.tpl" %}
                  </span>
                </div>
                {% endblock input_append_content %}
            {% endembed %}
          </div>
        {% if cart_page %}
        </div>
        {% endif %}


        {% if cart_page %}
          {# Cart item subtotal #}
          <h5 class="js-cart-item-subtotal col-3 text-center d-none d-md-block mb-0 h4-md" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value="{{item.subtotal}}">{{ item.subtotal | money }}</h5>
        {% endif %}
      </div>
    </div>

    {# Cart item delete #}
    <div class="cart-item-delete {% if cart_page %}col-md-1 text-right position-relative-md{% endif %}">
      <button type="button" class="btn btn-icon" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
        {% include "snipplets/svg/trash.tpl" with {svg_custom_class : "svg-inline--fa fa-lg svg-icon-text"} %}
      </button>
    </div>
  </div>
  {% if cart_page and settings.theme_variant == 'squared' %}
    <div class="divider w-100"></div>
  {% endif %}
</div>