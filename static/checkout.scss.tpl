{% if store.allows_checkout_styling %}

{#/*============================================================================
checkout.scss.tpl

    -This file contains all the theme styles related to the checkout based on settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
        -static/css/style-async.scss.tpl --> For non critical styles witch will be loaded asynchronously
        -static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{#/*============================================================================
  Global
==============================================================================*/#}

{# /* // Colors */ #}

$primary-color: {{ settings.primary_color | default('rgb(77, 190, 207)' | raw ) }};
$foreground-color: {{ settings.text_color | default('rgb(102, 102, 102)' | raw ) }};
$background-color: {{ settings.background_color | default('rgb(252, 252, 252)' | raw ) }};

{# /* // Font */ #}

$heading-font: {{ settings.font_headings | default('Muli') | raw }};
$body-font: {{ settings.font_rest | default('Muli') | raw }};

{# /* // Box */ #}

$box-background: lighten($background-color, 10%);

{% if settings.theme_variant == 'squared' %}

  {# /* // Squared variant */ #}

  $box-radius: 0;
  $box-shadow: none;
  $box-border-color: rgba($foreground-color, .14);
  $form-control-radius: 0;

{% else %}

  {# /* // Rounded variant */ #}

  $box-radius: 10px;
  $box-shadow: 0 0 10px 0 rgba($foreground-color, 0.1);
  $box-border-color: rgba($foreground-color, .14);
  $form-control-radius: 40px;
{% endif %}

{# /* // Functions */ #}

@function set-background-color($background-color) {
  @if lightness($background-color) > 95% {
    @return lighten($background-color, 10%);
  } @else {
    @return desaturate(lighten($background-color, 7%), 5%);
  }
}

@function set-input-color($background-color, $foreground-color) {
  @if lightness($background-color) > 70% {
    @return desaturate(lighten($foreground-color, 5%), 80%);
  } @else {
    @return desaturate(lighten($background-color, 5%), 80%);
  }
}

{# /* // Mixins */ #}

@mixin prefix($property, $value, $prefixes: ()) {
	@each $prefix in $prefixes {
    	#{'-' + $prefix + '-' + $property}: $value;
	}
   	#{$property}: $value;
}

{# /* // Scrollbars */ #}

::-webkit-scrollbar {
  width: 10px;
}

{# /*  Track */ #}
::-webkit-scrollbar-track {
  background: #f1f1f1; 
}

{# /*  Handle */ #}
::-webkit-scrollbar-thumb {
  background: #888; 
}

{# /*  Handle on hover */ #}
::-webkit-scrollbar-thumb:hover {
  background: #555; 
}

{#/*============================================================================
  React
==============================================================================*/#}

{# /* // Box */ #}

$box-background: lighten($background-color, 10%);
$box-text-shadow: null;
@if lightness($foreground-color) > 95% {
  $box-text-shadow: 0 2px 1px rgba(darken($foreground-color, 80%), 0.1);
} @else {
  $box-text-shadow: 0 2px 1px rgba(lighten($foreground-color, 80%), 0.1);
}

$base-red: #c13a3a;

$xs: 0;
$sm: 576px;
$md: 768px;
$lg: 992px;
$xl: 1200px;

body {
  font-family: $body-font;
  color: $foreground-color;
  background-color: $background-color;
}
a {
  color: $primary-color;
  text-decoration: none;

  &:hover, &:focus {
    color: darken($primary-color, 20%);

    svg {
      fill: darken($primary-color, 20%);
    }
  }

  svg {
    fill: $primary-color;
  }
}

{# /* // Text */ #}

.title {
  color: $foreground-color;
}

{# /* // Header */ #}

.header { 
  background-color: lighten($background-color, 10%);
  border-color: $primary-color;
}

.security-seal {
  color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
}

{# /* // Container */ #}

.container {
  max-width: 100%;
  width: 100%;
}

.main-container {
  .row{
    &.m-bottom.m-top {
      margin-top: 0 !important;
      margin-bottom: 0 !important;
    }
    .col-md-8 {
      padding: 15px 30px 30px 30px;
    }
  }
}

{# /* // Headbar */ #}

.headbar {
  background: {% if settings.head_background == 'light' %}$background-color{% elseif settings.head_background == 'dark' %}$foreground-color{% else %}$primary-color{% endif %};
  {% if settings.head_background == 'light' %}
    border-bottom: 1px solid rgba($foreground-color, .1);
  {% endif %}
  box-shadow: none;

  .row {
    -ms-flex-align: center;
    align-items: center;
    -ms-flex-pack: center;
    justify-content: center;

    .col.text-left {
      text-align: center !important;
      -ms-flex: 0 0 50%;
      flex: 0 0 50%;
      max-width: 50%;
      margin-left: 25%;
    }
    .col.text-right {
      -ms-flex: 0 0 25%;
      flex: 0 0 25%;
      max-width: 25%;
    }
  }
}

.headbar-logo-img {
  max-width: 100%;
  max-height: 60px;
}

.headbar-logo-text {
  float: none;
  font-family: $heading-font;
  font-size: 22px;
  font-weight: 300;
  color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};

  &:hover {
    color: rgba({% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %}, .5);
  }
}

.headbar-continue {
  margin: 0 !important;
  font-weight: 400;
  color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
  &:hover,
  &:focus {
    color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
    opacity: .8;

    .headbar-continue-icon {
      fill: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
    }
  }
  &-icon {
    margin-left: 5px;
    fill: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
  }
}

{# /* // Form */ #}

.form-control {
  color: $foreground-color;
  background: $background-color;
  border-color: $box-border-color;
  border-radius: $form-control-radius;

  &:focus {
    border-color: $foreground-color;
    outline: none;    
  }
}
textarea.form-control {
  border-radius: $box-radius;
}

.form-options-content {
  font-size: 12px;
  line-height: 20px;
  color: rgba($foreground-color, .6);
  border: 0;
}
.form-group.form-group-error .form-control {
  border-color: $base-red;
  border-radius: $form-control-radius;

  &:focus {
    border-color: $base-red;
  }
}

.form-group input[type="radio"] + .form-options-content .unchecked {
  fill: darken($background-color, 10%);
}
.form-group input[type="radio"] + .form-options-content .checked {
  fill: $primary-color;
}

.form-group input[type="radio"]:checked + .form-options-content {
  border: 1px solid $primary-color;
  border-color: darken($background-color, 10%);
  
  + .form-options-accordion {
    border-color: darken($background-color, 10%);
  }
  
  .checked {
    fill: $primary-color;
  }
}
.form-group input[type="checkbox"]:checked + .form-options-content .checked {
  fill: $foreground-color;
}
.form-group input[disabled] + .form-options-content {
  border-color: darken($background-color, 10%) !important;
  
  .form-options-label {
    color: $foreground-color !important;
  }
  .checked {
    fill: $foreground-color !important;
  }
}
.form-group input[type="checkbox"] + .form-options-content {
  .unchecked {
    fill: $foreground-color;
  }
}

{# /* // Input */ #}

.has-float-label>span,
.has-float-label label {
  padding: 1px 0 0 7px;
  font-weight: 400;
}

.input-label {
  color: $foreground-color;
}

.select-icon {
  right: 15px;
  fill: $foreground-color;
}

.input-group-append {
  margin: 0;
}

{# /* // Buttons */ #}

.btn-primary {
  float: none;
  font-weight: bold;
  color: $background-color;
  border-radius: $form-control-radius;
  border-color: $primary-color;
  text-transform: uppercase;

  {% if settings.theme_variant == 'squared' %}
    color: $primary-color;
    background: $background-color;
    border-bottom: 3px solid $primary-color;
    @include prefix(transition, all 0.09s ease-in, webkit ms moz o);
  {% else %}
    font-weight: normal;
    letter-spacing: 4px;
    background: $primary-color;
    border-radius: 50px;
    @include prefix(transition, all 0.25s ease-in, webkit ms moz o);
    @include prefix(box-shadow, inset 0 0 0 2px $primary-color, webkit ms moz o);
  {% endif %}

  &:hover,
  &:focus,
  &:active {
    {% if settings.theme_variant == 'squared' %}
      color: $background-color;
      background: $primary-color;
    {% else %}
      color: $background-color;
      border-color: $background-color;
      background: $background-color;
      color: $primary-color;
    {% endif %}
  }
  &.btn-loading,
  &:focus {
    {% if settings.theme_variant == 'squared' %}
    color: $primary-color;
    background: $background-color;
    {% else %}
      color: $background-color;
      border-color: $background-color;
      background: $primary-color;
    {% endif %}
  }
}

.btn-secondary {
  color: $foreground-color;
  text-transform: uppercase;
  background: rgba($foreground-color, .14);
  border: none;
  border-radius: $form-control-radius;

  &:hover,
  &:focus,
  &:active,
  &:active:focus {
    color: $foreground-color;
    background: rgba($foreground-color, .14);
    opacity: .8;
  }
  .btn-icon-right {
    fill: $foreground-color;
  }
}

.btn-transparent {
  color: lighten($foreground-color, 15%);

  &:hover {
    color: $primary-color;
    
    .btn-icon-right {
      fill: $primary-color;
    }
  }

  .btn-icon-right {
    fill: lighten($foreground-color, 15%);
  }
}

.btn-link {
  color: $foreground-color;
  text-decoration: none;

  &:hover {
    color: $foreground-color;
    opacity: 0.6;

    svg {
      fill: $foreground-color
    }
  }
}

.btn-picker {
  border-color: $box-border-color;
  border-radius: $box-radius;
}

.login-info {
  margin: 10px 0 0;
  font-size: 12px;
  text-align: center;
  color: rgba($foreground-color, .6);
}

{# /* // Breadcrumb */ #}

.breadcrumb {
  {% if settings.theme_variant == 'squared' %}
    position: relative;
    z-index: 1;
  {% endif %}
  width: calc(100% + 30px);
  max-width: calc(100% + 30px);
  display: inline-block;
  margin: 0 -15px;
  text-align: center;
  background: $background-color;
  border-bottom: 1px solid rgba($foreground-color, .1);

  li {
    display: inline-block;

    .breadcrumb-step {
      height: 40px;
      margin: 0;
      font-size: 12px;
      color: rgba($foreground-color, .6);
      background: none;
      text-transform: none;

      &.active {
        color: $foreground-color;
        background: none;

        &:before,
        &:after {
          position: relative;
          margin: 0 10px;
          border: 0;
          content: ">";
          opacity: .6;
        }
      }

      &.visited {
        color: rgba($foreground-color, .6);
        background: none;
      }
    }
    &:first-child .breadcrumb-step,
    &:last-child .breadcrumb-step {
      padding: 0;
    }
  }
}

{# /* // Accordion */ #}

.accordion {
  color: $foreground-color;
  text-align: left;
  background-color: $background-color;
  border-radius: $box-radius;
  border-color: rgba($foreground-color, .1);
  box-shadow: 0 1px 3px -1px rgba($foreground-color, 0.05);
}

.accordion-section-header-icon {
  fill: $foreground-color;
}

.accordion-rotate-icon {
  fill: $foreground-color;
}

{# /* // Summary */ #}

.mobile-discount-coupon_btn {
  border-radius: $box-radius;
  border-color: darken($background-color, 10%);
  color: lighten($foreground-color, 20%);

  .icon {
    color: lighten($foreground-color, 20%);
  }
}
.summary {
  top: 0; 

  .overlay + .summary-container {
    border: 0;
  }
}
.summary-details {
  padding-top: 30px !important;
  background: $background-color;
}
.summary-container {
  background: $background-color;
  border-bottom: 1px solid rgba($foreground-color, .1);
  box-shadow: none;
}
.summary-img {
  width: 80px;
  height: 80px;
}
.summary-total {
  font-size: 16px;
  font-weight: 700;
  color: $primary-color;
  background: none;
}
.summary-img-thumb {
  left: 0;
  border-radius: 0;
  &:after {
    box-shadow: none;
  }
}
.summary-arrow-rounded {
  background: none;
  .summary-arrow-icon {
    fill: $foreground-color;
  }
}
.summary-title {
  color: $foreground-color;
}

{# /* // Radio */ #}

.radio-group {
  border-radius: $box-radius;

  &.radio-group-accordion {
    border-color: $box-border-color;
    {% if settings.theme_variant == 'rounded' %}
      box-shadow: $box-shadow;
    {% endif %}

    .radio {
      padding: 15px 15px;
      color: rgba($foreground-color, .6);
      border-color: rgba($foreground-color, .1);
      &:first-child {
        border-radius: $box-radius $box-radius 0 0;
      }
      &.active {
        margin: 0;
        color: $foreground-color;
        border: 1px solid rgba($foreground-color, .6);
        border-bottom: none;
        .label {
          padding-bottom: 15px;
          border-bottom: 1px solid rgba($foreground-color, .1);
        }
        & + .radio-content {
          padding-top: 5px;
          border: 1px solid rgba($foreground-color, .6);
          border-top: none;
        }
      }
      .label {
        font-size: 16px;
        font-weight: 700;
      }
      .description {
        width: calc(100% - 35px);
        margin-left: 35px;
        font-weight: 400;
      }
      &-content:last-child {
        border-radius: 0 0 $box-radius $box-radius;
      }
    }
  }
}

.radio input:checked + .selector:before {
  {% if settings.theme_variant == 'squared' %}
    background-image: radial-gradient(circle, $foreground-color 0%, $foreground-color 40%, transparent 50%, transparent 100%);
  {% else %}
    background-image: radial-gradient(circle, $primary-color 0%, $primary-color 40%, transparent 50%, transparent 100%);
  {% endif %}
  border-color: $foreground-color;
}
.radio input:disabled:checked + .selector:before {
  background-image: radial-gradient(circle, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.5) 50%, transparent 50%, transparent 100%);
}

.radio .selector:before {
  width: 20px;
  height: 20px;
  margin: 1px 15px 0 0;
  border: 2px solid rgba($foreground-color, 0.6);
}

.radio-content {
  background: $background-color;
  border: 0;
  box-shadow: none;
}
.shipping-option {
  background: $background-color;
  margin-bottom: -1px;
  border-radius: 0;
  border-color: rgba($foreground-color, 0.1);

  &:first-child {
    border-radius: $box-radius $box-radius 0 0;
  }
  &:last-child {
    border-radius: 0 0 $box-radius $box-radius;
  }
  &:only-child {
    border-radius: $box-radius;
  }
  &.active {
    position: relative;
    border: 1px solid rgba($foreground-color, .6);
    .shipping-method-item-price {
      color: $primary-color;
    }
  }
}

{# /* // Panel */ #}

.panel {
  padding: 0;
  color: $foreground-color;
  background-color: $background-color;
  text-align: left;
  border-radius: $box-radius;
  box-shadow: none;
  border: 0;

  &.panel-with-header {
    padding-top: 0;
    p {
      margin: 0 0 25px 0;
      text-align: center;
      &.text-small-extra {
        text-align: left;
      }
    }
  }
  &.summary-details {
    {% if settings.theme_variant == 'rounded' %}
      width: calc(100% - 15px);
      margin-top: 30px;
      padding-top: 0 !important;
      box-shadow: $box-shadow;
    {% endif %}
  }
  .panel-subheader:before {
    display: inline-block;
    width: 18px;
    margin: 0 15px 0 3px;
    vertical-align: middle;
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" fill="%23{{ settings.text_color |trim('#') }}"><path d="M313.6 288c-28.7 0-42.5 16-89.6 16-47.1 0-60.8-16-89.6-16C60.2 288 0 348.2 0 422.4V464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48v-41.6c0-74.2-60.2-134.4-134.4-134.4zM416 464c0 8.8-7.2 16-16 16H48c-8.8 0-16-7.2-16-16v-41.6C32 365.9 77.9 320 134.4 320c19.6 0 39.1 16 89.6 16 50.4 0 70-16 89.6-16 56.5 0 102.4 45.9 102.4 102.4V464zM224 256c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm0-224c52.9 0 96 43.1 96 96s-43.1 96-96 96-96-43.1-96-96 43.1-96 96-96z"/></svg>');
  }
  .panel-submodule:last-child .panel-subheader:before,
  .shipping-options .panel-subheader:before {
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" fill="%23{{ settings.text_color |trim('#') }}"><path d="M192 96c-52.935 0-96 43.065-96 96s43.065 96 96 96 96-43.065 96-96-43.065-96-96-96zm0 160c-35.29 0-64-28.71-64-64s28.71-64 64-64 64 28.71 64 64-28.71 64-64 64zm0-256C85.961 0 0 85.961 0 192c0 77.413 26.97 99.031 172.268 309.67 9.534 13.772 29.929 13.774 39.465 0C357.03 291.031 384 269.413 384 192 384 85.961 298.039 0 192 0zm0 473.931C52.705 272.488 32 256.494 32 192c0-42.738 16.643-82.917 46.863-113.137S149.262 32 192 32s82.917 16.643 113.137 46.863S352 149.262 352 192c0 64.49-20.692 80.47-160 281.931z"/></svg>');
  }
  .new-shipping-flow .panel-subheader-ship:before {
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" fill="%23{{ settings.text_color |trim('#') }}"><path d="M226.8 94.6H0V63.8h242.2c8.5 0 15.4 6.9 15.4 15.4v41.6h70.1c4.7 0 9.1 2.1 12 5.8l57 71.2c2.2 2.7 3.4 6.1 3.4 9.6v85.5c0 8.5-6.9 15.4-15.4 15.4h-30.1c-6.2 16.6-22.3 28.5-41.1 28.5-24.2 0-43.9-19.6-43.9-43.9 0-24.2 19.6-43.9 43.9-43.9 18.8 0 34.9 11.8 41.1 28.5h14.7v-64.7l-49-61.2h-62.7v141.3c0 8.5-6.9 15.4-15.4 15.4h-85.5v-30.8h70.1V94.6zm-70.1 56.9H28.5v-30.8h128.2v30.8zm-28.5 57H0v-30.8h128.2v30.8zm-42.7 71.2c-7.2 0-13.1 5.9-13.1 13.1 0 7.2 5.9 13.1 13.1 13.1 7.2 0 13.1-5.9 13.1-13.1 0-7.2-5.9-13.1-13.1-13.1zm-43.9 13.2c0-24.2 19.6-43.9 43.9-43.9s43.9 19.6 43.9 43.9c0 24.2-19.6 43.9-43.9 43.9s-43.9-19.7-43.9-43.9zm271.8-13.2c-7.2 0-13.1 5.9-13.1 13.1 0 7.2 5.9 13.1 13.1 13.1 7.2 0 13.1-5.9 13.1-13.1 0-7.2-5.9-13.1-13.1-13.1z"/></svg>');
  }
  .new-shipping-flow .panel-subheader-pickup:before {
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" fill="%23{{ settings.text_color |trim('#') }}"><path d="M198.3 0c-82.5 0-150 67.5-150 150 0 60 20 77.5 135 242.5 3.8 5 9.4 7.5 15 7.5s11.3-2.5 15-7.5c115-165 135-182.5 135-242.5 0-82.5-67.5-150-150-150zm0 348.5c-11.3-16.1-21.5-30.6-30.8-43.7C93.9 200.4 85.8 187.7 85.8 150c0-62 50.5-112.5 112.5-112.5S310.8 88 310.8 150c0 37.7-8.1 50.4-81.7 154.8-9.3 13.1-19.5 27.6-30.8 43.7z"/></svg>');
  }

  .shipping-address-container .panel-subheader:before {
    display: none;
  }
}
.panel-header {
  margin: 0;
  font-family: $heading-font;
  font-size: 30px;
  font-weight: bold;
  color: $foreground-color;
  border: 0;
  text-shadow: none;
}
.panel-subheader {
  font-weight: 400;
}
.panel-header-sticky {
  background-color: $background-color;
}
.panel-footer {
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
  background: darken($background-color, 2%);
  &-wa {
    border-color: darken($background-color, 5%);
  }
}
.panel-footer-form {
  input {
    border-color: $foreground-color;
  }
  .input-group-addon {
    background: $background-color;
    border-color: $foreground-color;
  }
  .disabled {
    background: darken($background-color, 15%) !important;
  }
}

{# /* // Table */ #}

.table-footer {
  display: block;
  margin-top: 15px;
  font-size: 22px;
  color: $primary-color;
  border-top: 1px solid rgba($foreground-color, 0.1);

  .text-semi-bold {
    font-weight: 400;
  }
}

.table-subtotal {
  padding: 15px 0 0;
  border-color: $box-border-color;
  border-width: 1px;

  td {
    padding: 3px 0;
  }
  .table tr {
    display: block;
  }
  .table-footer td {
    padding: 20px 0;
  }
}

.table .table-discount-coupon,
.table .table-discount-promotion {
  color: $primary-color;
  border: 0;
}

{# /* // Shipping Options */ #}

.shipping-options {
  {% if settings.theme_variant == 'squared' %}
    padding-bottom: 1px;
  {% endif %}
  color: rgba($foreground-color, .6);

  .radio-group {
    border-radius: $box-radius;
    {% if settings.theme_variant == 'rounded' %}
      box-shadow: $box-shadow;
    {% endif %}
  }

  .btn {
    margin: 0;
    border: 1px solid rgba($foreground-color, .1);
    border-top: none;
    border-radius: 0 0 $box-radius $box-radius;
  }
}

.new-shipping-flow {
  .radio-group {
    box-shadow: none;
  }
  {% if settings.theme_variant == 'rounded' %}
    .shipping-options-ship, .shipping-options-pickup {
      box-shadow: $box-shadow;
      border-radius: $box-radius;
    }
    .shipping-options .btn {
      margin-top: -10px;
      padding-top: 20px;
      border: 0;
    }
  {% endif %}
}

.shipping-method-item > span {
  width: 100%;
}

.shipping-method-item-desc,
.shipping-method-item-name {
  max-width: 70%;
  color: desaturate(lighten($foreground-color, 10%), 80%);
}

.shipping-method-item-price {
  float: right;
  font-size: 16px;
  color: rgba($foreground-color, .6);
}

.price-striked {
  display: block;
  margin: 5px 0 0 !important;
  font-size: 14px;
  color: rgba($foreground-color, .6);
  text-align: right;
}

{# /* // Discount Coupon */ #}

.box-discount-coupon button {
  color: $foreground-color;
  background: none;

  svg {
    width: 20px !important;
    fill: $primary-color;
  }
  &:hover {
    background: none;
    opacity: 0.5;
  }
}
.box-discount-coupon-applied {
  padding: 15px;
  color: $foreground-color;
  {% if settings.theme_variant == 'squared' %}
    background-color: rgba($foreground-color, .1);
    border: 0;
  {% else %}
    background-color: $background-color;
    border: 1px solid $foreground-color !important;
  {% endif %}
  border-radius: $form-control-radius;

  .coupon-icon {
    fill: $foreground-color;
  }
}

{# /* // Order Status */ #}

.orderstatus {
  border: 1px solid rgba($foreground-color, .1);
  box-shadow: $box-shadow;
}

{# /* // Destination */ #}

.destination {
  border-color: rgba($foreground-color, 0.1);
  &-icon svg {
    fill: $primary-color;
  }
}

{# /* // User Detail */ #}

.user-detail {
  text-align: left;
  &-icon svg {
    fill: $primary-color;
  }
}

{# /* // History */ #}

.history-item-done .history-item-title {
  color: $foreground-color;
}
.history-item-failure .history-item-title {
  color: $base-red;
}
.history-item-progress-icon svg {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);  
  } @else {
    fill: $background-color;
  }
}
.history-item-progress-icon:after {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);
    border-color: darken($background-color, 10%);
  } @else {
    fill: $background-color;
    border-color: $background-color;
  }
}
.history-item-progress-icon-failure svg {
  fill: $base-red;
}
.history-item-progress-icon-success svg {
  fill: $primary-color;
}
.history-item-progress-icon-success:after {
  border-color: $primary-color;
}

{# /* // History Canceled */ #}

.history-canceled {
  border-top-right-radius: $box-radius;
  border-top-left-radius: $box-radius;
  
  &-round {
    border-bottom-right-radius: $box-radius;
    border-bottom-left-radius: $box-radius;
  }
}
.history-canceled-header {
  border-color: rgba($box-border-color, 0.7);
  border-top-left-radius: $box-radius;
  border-top-right-radius: $box-radius;
}
.history-canceled-icon svg {
  fill: darken($background-color, 45%);
}

{# /* // Offline Payment */ #}

.ticket-coupon {
  background: darken($background-color, 4%);
  border-color: $box-border-color;
}

{# /* // Status */ #}

.status {
  border: 1px solid rgba($foreground-color, .1); 
  box-shadow: $box-shadow;
  padding: 25px 0;
  &-icon svg {
    fill: $primary-color;
  }
}

{# /* // Tracking */ #}

.success-order-id {
  position: relative;
  z-index: 1;
  padding-top: 50px;
  background: $background-color;
  border-bottom: 1px solid rgba($foreground-color, .1);
  text-align: center;
}
.tracking-item-time {
  color: $foreground-color;
}

{# /* // WhatsApp Opt-in */ #}

.whatsapp-form input, 
.whatsapp-form .input-group-addon {
  border-color: $primary-color;
}

{# /* // Helpers */ #}

.border-top {
  border-color: rgba($box-border-color, .4);
}

{# /* // Errors */ #}

.alert-danger-bagged {
  {% if settings.theme_variant == 'squared' %}
    margin: 0;
  {% else %}
    margin: 0 20px;
    max-width: calc(100% - 40px);
  {% endif %}
  padding-top: 6px;
  border-bottom-left-radius: $box-radius;
  border-bottom-right-radius: $box-radius;
}

.general-error {
  background: $base-red;
  border-color: lighten($base-red, 10%);
}

{# /* // Badge */ #}

.badge {
  padding-top: 20px;
  border: 0; 
}

{# /* // Payment */ #}

.payment-item-discount {
  color: $primary-color;
}

.payment-option {
  border-radius: $box-radius;
  color: $foreground-color;
  background-color: $background-color;
  border-color: rgba($foreground-color, .1);
  box-shadow: 0 1px 3px -1px rgba($foreground-color, 0.05);
}

.radio-content.payment-option-content {
  background: darken($background-color, 2%);
  border: 1px solid rgba($foreground-color, .1);
  border-top: 0;
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
}

{# /* // Overlay */ #}

.overlay {
  background: rgba(darken($background-color, 10%), 0.6);
}
.overlay-title {
  color: rgba($foreground-color, .7);
}

{# /* // List Picker */ #}

.list-picker .unchecked {
  fill: $foreground-color;
}
.list-picker li {
  border-color: $box-border-color;
  background: lighten($background-color, 10%);
  
  &:hover {
    color: $primary-color;
  }

  &.active {
    background: $background-color;
    color: $primary-color;

    .checked {
      fill: $primary-color;
    }
  }
}

.list-picker-content {
  background: lighten($background-color, 10%);
  border-color: $box-border-color;
}

{# /* // Loading */ #}

.loading {
  background: rgba(darken($background-color, 2%), 0.5);
  color: $primary-color;
}
.loading-spinner {
  color: $primary-color;
}
{% if settings.theme_variant == 'rounded' %}
  .loading-skeleton {
    float: left;
    width: 100%;
    border: 1px solid rgba($foreground-color, .1);
    border-radius: $box-radius;
    box-shadow: $box-shadow;
  }
{% endif %}
.loading-skeleton-radio {
  margin: 0 0 -1px 0;
  {% if settings.theme_variant == 'rounded' %}
    border-radius: 0;
    border: 0;
    border-bottom: 1px solid rgba($foreground-color, .1);
    &:last-child {
      border: 0;
    }
  {% else %}
    border-color: rgba($box-border-color, 0.1);
    border-radius: $box-radius;
    &:not(:first-child) {
      border-top: 0;
    }
  {% endif %}
}

{# /* // Spinner */ #}

.round-spinner {
  border-color: $primary-color;
  border-left-color: darken($primary-color, 5%);
  
  &:after {
    border-color: $primary-color;
    border-left-color: darken($primary-color, 5%);
  }
}

.spinner > .spinner-elem {
  background: $primary-color;
}

.spinner-inverted > .spinner-elem {
  {% if settings.theme_variant == 'rounded' %}
    background: $background-color;
  {% else %}
    background: $primary-color;
  {% endif %}
}

{# /* // Sign Up */ #}

.signup {
  border: 1px solid rgba($foreground-color, .1);
  padding: 25px 0;
  box-shadow: $box-shadow;
  &-icon svg {
    fill: $primary-color;
  }
}

{# /* // Modal */ #}

.modal-dialog {
  background: $background-color;
}

{# /* // List */ #}

.list-group-item {
  border-color: rgba($foreground-color, .1);
}

{# /* // Announcement */ #}

.announcement {
  color: $background-color;
  {% if settings.theme_variant == 'squared' %}
    margin-left: -15px;
    margin-right: -15px;
  {% endif %}

  &-bg {
    background: $primary-color;
    box-shadow: 0px 3px 5px -1px rgba(darken($primary-color, 20%), 0.35);
    border-radius: $box-radius;
    opacity: 1;
    z-index: 1;
  }

  &-message {
    z-index: 2;
    color: $background-color;
  }

  &-close {
    color: $background-color;
    z-index: 3;
  }
}

{# /* // Alert */ #}

.alert-info {
  background-color: rgba($primary-color, .15);
  border-color: rgba($primary-color, .2);
  color: desaturate(darken($primary-color, 10%), 30%);

  .alert-icon {
    fill: desaturate(darken($primary-color, 10%), 20%);
  }
}
{# /* // Chip */ #}

.chip {
  background-color: rgba($primary-color, .15);
  color: desaturate(darken($primary-color, 10%), 30%);
  {% if settings.theme_variant == 'squared' %}
    border-radius: 0;
  {% endif %}
}

{# /* // Tooltip */ #}

.tooltip-icon {
  fill: $foreground-color;
}

{# /* // Review Block Detailed  */ #}
.price--display__free {
  color: $primary-color;
}

.review-block-detailed-item {
  border-bottom: 1px solid rgba($foreground-color, 0.1);
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
  &:last-child {
    border-radius: 0 0 $box-radius $box-radius;
  }
}

.review-block-detailed {
  border: 1px solid rgba($foreground-color, 0.1);
  border-radius: $box-radius;
  background-color: $background-color;
}

{# /* // Tabs */ #}

.tabs-wrapper {
  margin-top: -21px;
  border-top-right-radius: 10px;
  border-top-left-radius: 10px;
  background: $background-color;
  border-bottom-color: darken($background-color, 10%);
}

.tab-item.active {
  color: $primary-color;
  font-weight: bold;
}

.tab-indicator {
  background-color: $primary-color;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Max width 576px */ #}

@media (max-width: $sm) {

  .security-seal {
    color: #000000;

    .d-inline-block:first-child {
      position: absolute;
      top: 1px;
      left: 50%;
      margin-left: -13px;
    }
    p {
      display: inline-block;
      &.text-semi-bold {
        margin-right: 50px !important;
      }
    }
    &-badge {
      margin: 0;
    }
  }

  .headbar .row .col {
    text-align: center !important;
    flex-basis: auto;
  }

  .headbar .row .col.text-left {
    -ms-flex: 0 0 100%;
    flex: 0 0 100%;
    max-width: 100%;
    margin-left: 0;
    order: 2;
  }

  .headbar .row .col.text-right {
    -ms-flex: 0 0 100%;
    flex: 0 0 100%;
    max-width: 100%;
    margin: -12px 0 15px 0;
    background: #aac67b;
  }

  .breadcrumb {
    border: 0; 
  }

  .summary .panel {
    border: 0;
  }

  .summary-details {
    padding-top: 0 !important;
  }

  .panel.summary-details {
    border: 0;
    box-shadow: -2px 3px 7px 3px rgba($foreground-color,0.1);
    {% if settings.theme_variant == 'rounded' %}
      width: 100%;
      margin-top: 0;
    {% endif %}
  }

  .panel-header {
    font-size: 22px;
  }

  .panel-subheader {
    font-size: 12px;
  }

  .orderstatus-footer {
    background: $background-color;
  }

}

{# /* // Max width 768px */ #}

@media (max-width: $md) {

  .main-container .row .col-md-8 {
    padding: 0 15px 30px 15px;
  }

  .status {
    margin-top: 20px;
  }

}

{# /* // Min width 768px */ #}

@media (min-width: $md) {

  .status,
  .signup {
    padding: 40px 0;
  }

  .success-order-id {
    padding: 0;
  }

  {% if settings.theme_variant == 'squared' %}
    .main-container .row .col-md-8:after {
      position: fixed;
      top: 0;
      left: 66.666667%;
      height: 100%;
      border-right: 1px solid rgba($foreground-color, .1);
      content: '';
    }
  {% endif %}

}

{# /* // Max width 0px */ #}

@media (max-width: $xs) {

  .modal-xs {
    background: $background-color;
  }

}

{% endif %}
