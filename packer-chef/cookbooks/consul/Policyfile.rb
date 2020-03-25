name 'consul'
default_source :supermarket
run_list 'consul::default'
cookbook 'consul', path: '.'
