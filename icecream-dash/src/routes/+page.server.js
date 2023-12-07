

import { fetchData } from '$lib/redcap-server-utils'
// import { getExclusionReasons, getPathogenTargets } from '$lib/redcap-utils'


function processData(data) {
  let log = data.map(entry => {
    // Initialize _meta object
    entry['_meta'] = {
      'id': entry['icecream_id'],
      'isComplete': entry.ice_cream_scenario_5_complete === 'Complete',
      'orders': []
    };

    // Special case for scenario 1
    if (entry['flavor'] || entry['cup_cone']) {
      entry['_meta']['orders'].push({
        'scenario': 1,
        'containers': entry['cup_cone'],
        'scoops': [entry['flavor']],
        'toppings': []
      });
    }

    // Extract orders for scenarios 2-5
    for (let i = 2; i <= 5; i++) {
      let numOrders = parseInt(entry[`s${i}_num_orders`]);
      if (isNaN(numOrders)) continue; // Skip if no orders for this scenario

      for (let j = 1; j <= numOrders; j++) {
        let orderKey = `s${i}_order${j}`;
        let order = {
          'scenario': i,
          'name': entry[`${orderKey}_name`],
          'containers': entry[`${orderKey}_cup_cone`],
          'scoops': [],
          'toppings': []
        };

        // For s2, flavor is directly in the order
        if (i === 2) {
          order['scoops'].push(entry[`${orderKey}_flavor`]);
        }

        // For s3, flavor is given once and applies to all scoops
        if (i === 3) {
          let numScoops = parseInt(entry[`${orderKey}_scoops`]);
          let flavor = entry[`${orderKey}_flavor`];
          for (let k = 1; k <= numScoops; k++) {
            order['scoops'].push(flavor);
          }
        }

        // For s4 and s5, each scoop has its own flavor
        if ([4, 5].includes(i)) {
          let numScoops = parseInt(entry[`${orderKey}_scoops`]);
          for (let k = 1; k <= numScoops; k++) {
            let flavor = entry[`${orderKey}_scoop${k}`];
            if (flavor) order['scoops'].push(flavor);
          }
        }

        // Extract toppings for s4 and s5
        if ([4, 5].includes(i)) {
          for (let key in entry) {
            let match = key.match(new RegExp(`^${orderKey}_toppings___(.+)`));
            if (match) {
              order['toppings'].push(entry[key]);
            }
          }
        }

        entry['_meta']['orders'].push(order);
      }
    }

    // Filter out empty string keys
    for (let key in entry) {
      if (entry[key] === "") {
        delete entry[key];
      }
    }

    return entry;
  });

  return log;
}

export const load = async () => {

  const icecream = await fetchData();
  
  return {
    icecream: processData(icecream)
  }
}