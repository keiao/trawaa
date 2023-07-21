{% if settings.welcome_message %}
    <section class="section-welcome-home">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    {% if settings.welcome_message and settings.welcome_text %}
                    <div class="row">
                    {% endif %}
                    <h2 class="h2 h1-md align-self-center mb-md-0 {% if settings.theme_variant == 'squared' and settings.welcome_text %}col-12 col-md-6 text-right text-center-xs{% else %}text-center {% if  settings.theme_variant == 'rounded' %} col-12{% endif %}{% endif %}">{{ settings.welcome_message }}</h2>
                    {% if settings.welcome_text %}
                        <p class="h3 welcome-text font-secondary align-self-center mb-0 {% if  settings.theme_variant == 'squared' and settings.welcome_message %}col-12 col-md-6 text-left text-center-xs{% else %}text-center {% if  settings.theme_variant == 'rounded' %} col-12 mt-4{% endif %}{% endif %}">{{ settings.welcome_text }}</p>
                    {% endif %}
                    {% if settings.welcome_message and settings.welcome_text %}
                    </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </section>
{% endif %}