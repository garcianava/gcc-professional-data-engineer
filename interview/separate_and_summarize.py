def separate_and_summarize(orders):
  # create the results dictionary
  results_dict = dict()
  # iterate over orders list
  for order in orders:
    # is this a new customer?
    if order['customer_id'] not in results_dict.keys():
      # initialize its integer key in results dictionary
      results_dict[order['customer_id']] = {'amount': order['amount'], 'orders':[order]}
    # the customer already exists in results dictionary
    else:
      # sum up amount and append order for the customer unique integer key
      results_dict[order['customer_id']]['amount'] += order['amount']
      results_dict[order['customer_id']]['orders'].append(order)
      
  return results_dict
