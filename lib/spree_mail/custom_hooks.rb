module SpreeMail
  class CustomHooks < Spree::ThemeSupport::HookListener
    # custom hooks go here
    
    #replace :admin_product_form_right, 'admin/hooks/product_form_right'
    #
    #replace :cart_item_price, 'hooks/cart_item_price'
    #replace :cart_item_total, 'hooks/cart_item_total'
    #
    #insert_before :inside_cart_form, 'hooks/wholesale_customer_id'
    #  
    #insert_after :admin_orders_index_headers, 'admin/hooks/admin_orders_index_headers'
    #insert_after :admin_orders_index_rows,    'admin/hooks/admin_orders_index_rows'
    #insert_after :admin_orders_index_search,  'admin/hooks/admin_orders_index_search'
    
    insert_after :footer_left,  'hooks/footer_left'
    insert_after :footer_right,  'hooks/footer_right'
    insert_after :admin_tabs,   'admin/hooks/subscribers_tab'
    insert_after :signup_below_password_fields, 'hooks/signup_checkbox'

  end
end