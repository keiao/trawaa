<div class="form-label {% if store.branches|length > 1 %}mb-1{% else %}mb-0{% endif %}" data-store="branches"> 
    {% if store.branches|length > 1 %}
        {{ 'Nuestros locales' | translate }}
    {% else %}
        {{ 'Nuestro local' | translate }}
    {% endif %}
</div>
<div class="mb-4 w-100">
    {% if store.branches|length > 1 %}
        <div class="js-toggle-branches btn-link btn-link-primary">
            <span class="js-see-branches">
                {{ 'Ver opciones' | translate }}
                {% include "snipplets/svg/long-arrow-down.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-primary"} %}
            </span>

            <span class="js-hide-branches" style="display: none;">
                {{ 'Ocultar opciones' | translate }}
                {% include "snipplets/svg/long-arrow-left.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-primary"} %}
            </span>
        </div>
    {% endif %}

    {# Store branches #}
        
    <ul class="js-store-branches-container {% if product_detail %}list-readonly{% endif %} list-unstyled box mb-2 mt-4 full-width-container" {% if store.branches|length > 1 %}style="display: none;"{% endif %}>

        {# Selectable branches #}

        {% for branch in store.branches %}
            <li class="{% if product_detail %}list-item{% else %}radio-button-item{% endif %}" data-store="branch-item-{{ branch.code }}">

                {# If cart use radiobutton #}
            
                {% if not product_detail %}
                    <label class="js-shipping-radio js-branch-radio radio-button" data-loop="branch-radio-{{loop.index}}">
                        <input 
                        class="js-branch-method {% if cart.shipping_data.code == branch.code %} js-selected-shipping-method {% endif %} shipping-method" 
                        data-price="0" 
                        {% if cart.shipping_data.code == branch.code %}checked{% endif %} type="radio" 
                        value="{{branch.code}}" 
                        data-name="{{ branch.name }} - {{ branch.extra }}"
                        data-code="{{branch.code}}" 
                        data-cost="{{ 'Gratis' | translate }}"
                        name="option" 
                        style="display:none">
                        <span class="radio-button-content">
                            <div class="radio-button-icons-container">
                                <span class="radio-button-icons">
                                    <span class="radio-button-icon unchecked"></span>
                                </span>
                            </div>
                            <div class="radio-button-label">
                {% endif %}
                                <div class="{% if product_detail %}list-item-content{% else %}radio-button-text{% endif %} row"> 
                                    <div class="col-8 pr-0 font-small">
                                        <div class="opacity-60">
                                            {{ branch.name }} <span class="ml-1">{{ branch.extra }}</span>
                                        </div>
                                    </div>
                                    <div class="col-4 text-right">
                                        <span class="shipping-price d-inline-block font-weight-bold text-primary">
                                            <div>
                                                {{ 'Gratis' | translate }}
                                            </div>
                                        </span>
                                    </div>
                                </div>
                {% if not product_detail %}
                            </div>
                        </span>
                    </label>
                {% endif %}
            </li>
        {% endfor %}
    </ul>
</div>
