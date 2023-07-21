{# Product quantity #}
{% if product.available and product.display_price %}
    {% if not has_one_variant or not product.variations %}
    <div class="form-row">
    {% endif %}
    <div class="{% if product.variations %}{% if has_one_variant %}col-6 {% else %}col-12{% endif %}{% else %}col-12{% endif %} col-md-6" data-component="product.adding-amount">
        <label class="form-label">{{ 'Cantidad' | translate }}</label>
        {% set form_quantity_class = settings.product_stock ? ' mb-2' : '' %}
        {% embed "snipplets/forms/form-input.tpl" with{
        type_number: true, input_value: '1', 
        input_name: 'quantity' ~ item.id, 
        input_custom_class: 'js-quantity-input text-center h5', 
        input_label: false, 
        input_append_content: true, 
        input_group_custom_class: 'js-quantity form-quantity' ~ form_quantity_class, 
        form_control_container_custom_class: 'col', 
        form_data_component: 'product.adding-amount',
        input_min: '1',
        input_data_component: 'adding-amount.value',
        input_aria_label: 'Cambiar cantidad' | translate } %}
            {% block input_prepend_content %}
            <div class="row m-0 align-items-center">
                <span class="js-quantity-down text-center btn" data-component="product.quantity.minus">
                    {% include "snipplets/svg/minus.tpl" %}
                </span>
            {% endblock input_prepend_content %}
            {% block input_append_content %}
                <span class="js-quantity-up text-center btn" data-component="product.quantity.plus">
                    {% include "snipplets/svg/plus.tpl" %}
                </span>
            </div>
            {% endblock input_append_content %}
        {% endembed %}
        {% if settings.product_stock %}
            <div class="font-small pt-2 pb-3 text-center">
                <span class="js-product-stock">{{ product.selected_or_first_available_variant.stock }}</span> {{ "en stock" | translate }}
            </div>
        {% endif %}
    </div>
    {% if not has_one_variant or not product.variations %}
    </div>
    {% endif %}
{% endif %}