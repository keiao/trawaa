<div class="js-addtocart js-addtocart-placeholder btn btn-primary btn-{% if quickshop %}small{% else %}block{% endif %} btn-transition {{ custom_class }} disabled" style="display: none;">
    <div class="d-inline-block">
        <span class="js-addtocart-text">{{ 'Agregar al carrito' | translate }}</span>
        <span class="js-addtocart-success transition-container btn-transition-success{% if quickshop %}-small{% endif %}">
            {{ '¡Listo!' | translate }}
        </span>
        <div class="js-addtocart-adding transition-container transition-soft btn-transition-progress{% if quickshop %}-small{% endif %}">
            <div class="spinner-ellipsis-invert"></div>
        </div>
    </div>
</div>