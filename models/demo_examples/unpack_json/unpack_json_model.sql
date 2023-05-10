{{
    config(
        enabled=False
    )
}}


{%- set yaml_metadata -%}
userId: STRING
messageId: STRING
receivedAt: STRING
sentAt: STRING
timestamp: STRING
context:
  ip: STRING
  library: 
    name: STRING
    version: STRING
  app: 
    version: STRING
    build: STRING
    name: STRING
  locale: STRING
  page: 
    path: STRING
    referrer: STRING
    title: STRING
    url: STRING
  userAgent: STRING
properties:
  event_id: STRING
  browse_id: STRING
  ahoy_visit_token: STRING
  ahoy_visitor_token: STRING
  country_id: STRING
  region_id: STRING
  zip_code: STRING
  whitelabel_id: STRING
  platform: STRING
  element_load_id: STRING
  element_details: 
    carousel_request_id: STRING
    element_id: STRING
    element_type: STRING
    element_value: STRING
    display_position: STRING
    featured_item: STRING
    product_details: STRING
    retailer_location_id: STRING
    product_id: STRING
  page_details: 
    page_type: STRING
    page_view_id: STRING
    page_id: STRING
    page_value: STRING
  pathname: STRING
  collection_id: STRING
  subject_id: STRING
  collection_type: STRING
  section_details: 
    preferred_placement: STRING
    horizontal_section_rank: STRING
    vertical_section_rank: STRING
    section_type: STRING
  display_details: 
    display_position: STRING
    grid_column: STRING
    grid_row: STRING
  element_attributes: 
    low_stock_label: STRING
  on_sale_ind: 
    buy_one_get_one: STRING
    cpg_coupon: STRING
    on_sale: STRING
    retailer: STRING
  availability_score: STRING
  from_item_modal: STRING
  guest: STRING
  inventory_area_id: STRING
  is_express_member: STRING
  is_initial: STRING
  is_new_user: STRING
  item_id: STRING
  zone_id: STRING
  items_count: STRING
  wl_order_count: STRING
  stock_level: STRING
  warehouse_id: STRING
  service_type: STRING
  whitelabel_retailer: STRING
  api_version: STRING
  parent_collection_id: STRING
  ranking_request_id: STRING
  eligible_id: STRING
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ get_json_schema_string_from_dict(metadata_dict) }}

