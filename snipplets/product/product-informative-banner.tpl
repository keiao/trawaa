{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings, "#{banner}_show") %}
    {% set product_informative_banner_title = attribute(settings, "#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings, "#{banner}_description") %}
    {% set has_product_informative_banner = product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %}
        <div class="form-row mb-4 {% if loop.first and product.description is empty %}mt-4{% endif %}">
        </div>


    <div class="accordion-container">
        {% if product_informative_banner_title %}
            <div class="mb-1 font-weight-bold form-label accordion-header">
                {{ product_informative_banner_title }}
            </div>
        {% endif %}
        <div class="accordion-content" style="display: none;">
            {% if product_informative_banner_description %}
                <p class="m0">{{ product_informative_banner_description }}</p>
            {% endif %}
        </div>
 {# <span class="material-symbols-outlined">
            remove
            </span>
           
            <span class="material-symbols-outlined">
            add
            </span> #}
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<script>
    $(document).ready(function() {
        // Maneja el clic en el encabezado del acordeón
        $('.accordion-header').click(function() {
            // Encuentra el contenido asociado a este título
            const content = $(this).next('.accordion-content');
            
            // Comprueba si el contenido está visible o no
            if (content.is(":visible")) {
                if ($(this).hasClass("open")) {
                    content.slideUp(350);
                    $(this).removeClass("open");
                    $(this).addClass("active");
                } else {
                    $('.accordion-content').not(content).slideUp(350);
                    content.slideDown(350).addClass("open").removeClass("active");
                    $('.accordion-icon').not(icon).text('+');
                }
            } else {
                $('.accordion-content').not(content).slideUp(350);
                content.slideDown(350).addClass("open").removeClass("active");
            }
        });
        
        // Si el elemento que se ha hecho clic no es un acordeón, lo cerramos
        $(document).on('click', function(event) {
            if (!$(event.target).hasClass('accordion-header') && !$(event.target).hasClass('accordion-content')) {
                $('.accordion-content.open').slideUp(350).removeClass("open");
            }
        });
    });
</script>

    {% endif %}
{% endfor %}
