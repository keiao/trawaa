{# /*============================================================================
  #Card
==============================================================================*/

#Head
    // Block - card_head
#Body
    // Block - card_body
#Footer
    // Block - card_footer

#}

<div class="{% if card_collapse %}js-card-collapse {% endif %}card {{ card_custom_class }} {% if card_active %}active{% endif %}">
    <div class="{% if card_collapse %}js-card-header-collapse card-header-collapse {% endif %}card-header">
        {% block card_head %}{% endblock %}
        {% if card_collapse %}
            <span class="js-card-collapse-toggle card-collapse-toggle {% if card_active %}active{% endif %}">
                {% include "snipplets/svg/long-arrow-down.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-accent fa-long-arrow-down fa-2x"} %}
            </span>
        {% endif %}
    </div>
    <div class="card-body">
        {% block card_body %}{% endblock %}
    </div>
    {% if card_footer %}
        <div class="card-footer">
            {% block card_foot %}{% endblock %}
        </div>
    {% endif %}
</div>