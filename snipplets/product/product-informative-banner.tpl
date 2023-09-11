{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings, "#{banner}_show") %}
    {% set product_informative_banner_title = attribute(settings, "#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings, "#{banner}_description") %}
    {% set has_product_informative_banner = product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %}
        <div class="form-row mb-4 {% if loop.first and product.description is empty %}mt-4{% endif %}">
            <div class="accordion-container">
                {% if product_informative_banner_title %}
                    <div class="mb-1 font-weight-bold form-label accordion-header">
                        <span class="accordion-icon">+</span>
                        {{ product_informative_banner_title }}
                    </div>
                {% endif %}
                <div class="accordion-content" style="display: none;">
                    {% if product_informative_banner_description %}
                        <p class="m0">{{ product_informative_banner_description }}</p>
                    {% endif %}
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function() {
                // Maneja el clic en el encabezado del acordeón
                $('.accordion-header').click(function() {
                    // Desactiva temporalmente el encabezado para evitar clics repetidos
                    $(this).off('click');
                    
                    // Encuentra el contenido asociado a este título
                    const content = $(this).next('.accordion-content');
                    const icon = $(this).find('.accordion-icon');
                    
                    // Detiene cualquier animación en curso y luego toggle para abrir o cerrar el acordeón
                    content.stop().slideToggle(350, function() {
                        // Restaura el evento de clic después de que se complete la animación
                        $(this).prev('.accordion-header').on('click', function() {
                            // Maneja el clic nuevamente
                            const content = $(this).next('.accordion-content');
                            const icon = $(this).find('.accordion-icon');
                            
                            // Detiene cualquier animación en curso y luego toggle para abrir o cerrar el acordeón
                            content.stop().slideToggle(350, function() {
                                // Restaura el evento de clic después de que se complete la animación
                                $(this).prev('.accordion-header').on('click', arguments.callee);
                            });
                            
                            // Cambia el ícono
                            icon.text(icon.text() === '+' ? '-' : '+');
                        });
                        
                        // Cambia el ícono
                        icon.text(icon.text() === '+' ? '-' : '+');
                    });
                });
            });
        </script>
    {% endif %}
{% endfor %}
