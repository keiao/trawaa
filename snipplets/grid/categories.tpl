{% if filter_categories %}
    <div class="col-12 col-sm-4 mb-5 mb-sm-3 p-0 p-sm-3">
        <h4 class="font-weight-bold mb-3">{{ "Categorías" | translate }}</h4>
        <ul class="list-unstyled">
            {% for category in filter_categories %}
                <li class="d-inline-block mr-md-3 mb-3 w-100 w-auto-md" data-item="{{ loop.index }}"><a href="{{ category.url }}" title="{{ category.name }}" class="btn-link">{{ category.name }}</a></li>
                {% if loop.index == 8 and filter_categories | length > 8 %}
                    <div class="js-accordion-container d-none d-md-inline-block" style="display: none;">
                {% endif %}
                {% if loop.last and filter_categories | length > 8 %}
                    </div>
                    <a href="#" class="js-accordion-toggle btn btn-link btn-link-primary pl-0 float-left w-100 mt-2 text-left d-block d-md-none">
                        <span class="js-accordion-toggle-inactive">
                            {{ 'Ver más' | translate }}
                        </span>
                        <span class="js-accordion-toggle-active" style="display: none;">
                            {{ 'Ver menos' | translate }}
                        </span>
                    </a>
                {% endif %}
            {% endfor %}
        </ul>
    </div>
{% endif %}