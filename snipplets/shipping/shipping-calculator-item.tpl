{# On first calculation select as default the first option: If store only has pickup option selects pickup else selects shipping option #}

{% if has_featured_shipping %}
    {% set checked_option = featured_option and loop.first and not pickup %}
{% else %}
    {% set checked_option = featured_option and loop.first and pickup %}
{% endif %}

{% if store.has_smart_shipping_no_auto_select %}
    {% set checked_option = false %}
{% endif %}

<li class="js-shipping-list-item radio-button-item list-item" data-store="shipping-calculator-item-{{ option.code }}">
    <label class="js-shipping-radio radio-button" data-loop="shipping-radio-{{loop.index}}" data-shipping-type="{% if pickup %}pickup{% else %}delivery{% endif %}" data-component="shipping.option">
        <input 
        id="{% if featured_option %}featured-{% endif %}shipping-{{loop.index}}" 
        class="js-shipping-method {% if not featured_option %}js-shipping-method-hidden{% endif %} {% if pickup %}js-pickup-option{% endif %} shipping-method" 
        data-price="{{option.cost.value}}" 
        data-code="{{option.code}}" 
        data-name="{{option.name}}" 
        data-cost="{% if option.show_price %} {% if option.cost.value == 0  %}{{ 'Gratis' | translate }}{% else %}{{option.cost}}{% endif %}{% else %} {{ 'A convenir' | translate }} {% endif %}" 
        type="radio" 
        value="{{option.code}}" 
        {% if checked_option %}checked="checked"{% endif %} name="option" 
        style="display:none" />
        <span class="radio-button-content">
            <div class="radio-button-icons-container">
                <span class="radio-button-icons">
                    <span class="radio-button-icon unchecked"></span>
                </span>
            </div>
            <div class="radio-button-label">

                {# Improved shipping option with no carrier img and ordered shipping info #}
                <div class="radio-button-text row"> 
                    <div class="col-8 pr-0 font-small">
                        <div class="opacity-60 {% if option.payment_rules or option.time or option.suboptions is not empty %}mb-2{% endif %}" data-component="option.name"">
                            {{option.short_name}} {% if option.method == 'branch' %}<span class="ml-1">{{ option.extra.extra }}</span>{% endif %}
                        </div>
                        {% if option.time %}
                            <div class="opacity-80 {% if option.suboptions is not empty or option.payment_rules %}mb-2{% endif %}" data-component="option.date">
                                {% if store.has_smart_dates %}
                                    {{option.dates}}
                                {% else %}
                                    {{option.time}}
                                {% endif %}
                            </div>
                        {% endif %}                        
                        {% if option.suboptions is not empty %}
                            <div {% if option.payment_rules %}class="mb-2"{% endif %}>
                                {% include "snipplets/shipping_suboptions/#{option.suboptions.type}.tpl" with {'suboptions': option.suboptions} %}
                            </div>
                        {% endif %}
                        {% if option.payment_rules %}
                            <div class="font-small">
                                <span class="d-table float-left mr-1">
                                    {% include "snipplets/svg/info-circle.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text"} %}
                                </span>
                                <span class="d-table">
                                    <i>{{option.payment_rules}}</i>
                                </span>
                            </div>
                        {% endif %}
                        {% if option.warning['enable'] %}
                            <div class="w-100 mb-0 mt-3 mx-3 alert alert-warning">
                                {{ option.warning['message'] }}
                            </div>
                        {% endif %}
                    </div>
                    {% if option.show_price %} 
                        <div class="col-4 text-right" data-component="option.price">
                            <span class="shipping-price d-inline-block font-weight-bold {% if option.cost.value == 0  %}text-accent shipping-price-free{% endif %}">
                                <div class="mb-1">
                                    {% if option.cost.value == 0  %}
                                        {{ 'Gratis' | translate }}
                                    {% else %}
                                        {{option.cost}}
                                    {% endif %}
                                </div>
                                {% if option.cost.value == 0 and option.old_cost.value %}
                                    <div class="price-compare text-foreground font-small opacity-50 mr-0 font-weight-normal">{{option.old_cost}}</div>
                                {% endif %}
                            </span>
                        </div>
                    {% endif %}
                </div>
            </div>
        </span>
    </label>
</li>