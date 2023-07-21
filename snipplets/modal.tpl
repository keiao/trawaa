{# /*============================================================================
  #Modal
==============================================================================*/

#Properties
    // ID
    // Position - Top, Right, Bottom, Left
    // Transition - Slide and Fade
    // Width - Full and Box
    // fixed_header - Sets fixed header on modal (desktop and mobile)
    // fixed_footer - Sets fixed footer on modal (desktop only)
    // modal_form_action - For modals that has a form
    // modal_form_class - For custom form class
    // modal_context - Used for small modals that appear next to the element that triggers it. Always embed this type of modal inside the trigger link for context position.
    // modal_custom_css - Used to add exptra style. (e.g remove paddings in order to improve scrollbar behavior to the version with fixed modal-footer)

#Head
    // Block - modal_head
#Body
    // Block - modal_body
#Footer
    // Block - modal_footer

#}

{% set modal_overlay = modal_overlay | default(true) %}
{% set fixed_header_only = fixed_header and not fixed_footer %}
{% set fixed_footer_only = not fixed_header and fixed_footer %}
{% set fixed_header_and_footer = fixed_header and fixed_footer %}

<div {% if modal_data_component %} data-component="{{ modal_data_component }}" {% endif %} id="{{ modal_id }}" class="js-modal {% if modal_mobile_full_screen %}js-fullscreen-modal{% endif %} modal modal-{{ modal_class }} modal-{{modal_position}} transition-{{modal_transition}} modal-{{modal_width}} transition-soft {% if modal_context_sm %}modal-context-md{% endif %} {{ modal_custom_css }} {% if fixed_header or fixed_footer %} modal-fixed-wrapper {% endif %} {% if modal_zindex_top %}modal-zindex-top{% endif %}"  data-position="{{modal_position}}" style="display: none;" >
    {% if modal_form_action %}
    <form action="{{ modal_form_action }}" method="post" class="{{ modal_form_class }} {% if fixed_header or fixed_footer %} modal-fixed-wrapper {% endif %}" {% if modal_form_hook %}data-store="{{ modal_form_hook }}"{% endif %}>
    {% else %}
        {% if fixed_header %}
        <div class="modal-fixed-wrapper">
        {% endif %}
    {% endif %}

    {% if fixed_footer_only %}
    <div class="modal-fixed-wrapper">
        <div class="modal-fixed-wrapper-content">
    {% endif %}

    <div class="js-modal-close {% if modal_mobile_full_screen %}js-fullscreen-modal-close{% endif %} modal-header {% if modal_context_sm %}d-block d-md-none{% endif %}">
        {% if modal_position == 'right' %}
            <span class="modal-close left d-md-none">
                {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-2x"} %}
            </span>
        {% endif %}
        <h3 class="mb-0">{% block modal_head %}{% endblock %}</h3>
        <span class="modal-close right {% if modal_position == 'right' %}d-none d-md-block{% endif %}">
            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "fa-w-10"} %}
        </span>
    </div>

    {% if fixed_header_only %}
        <div class="modal-fixed-wrapper">
            <div class="modal-fixed-wrapper-content">
    {% endif %}

    {% if fixed_header_and_footer %}
    <div class="modal-fixed-wrapper">
        <div class="modal-fixed-wrapper-content">
    {% endif %}

            <div class="modal-body">
                {% block modal_body %}{% endblock %}
            </div>
        {% if fixed_header_and_footer %}
        </div>
        {% endif %}

    {% if fixed_footer_only %}
        </div>
    </div>
    {% endif %}

    {% if modal_footer or fixed_footer_only %}
        <div class="modal-footer d-md-block">
            {% block modal_foot %}{% endblock %}
        </div>
    {% endif %}

    {% if fixed_header_only %}
            </div>
        </div>
    {% endif %}
   
    {% if fixed_header_and_footer %}
    </div>
    {% endif %}
    {% if modal_form_action %}
    </form>

    {% else %}
        {% if fixed_header %}
        </div>
        {% endif %}
    {% endif %}

</div>

<div class="js-modal-overlay modal-overlay {% if modal_zindex_top %}modal-zindex-top{% endif %}" data-modal-id="#{{ modal_id }}" style="display: none;"></div>
