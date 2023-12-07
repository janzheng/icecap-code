

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

    // Extract orders for each scenario
    for (let i = 1; i <= 5; i++) {
      let numOrders = parseInt(entry[`s${i}_num_orders`]);
      if (isNaN(numOrders) && i !== 1) continue; // Skip if no orders for this scenario

      for (let j = 1; j <= (numOrders || 1); j++) { // For s1, there's only 1 order
        let orderKey = i === 1 ? '' : `s${i}_order${j}`; // For s1, keys don't have the order part
        let order = {
          'scenario': i,
          'name': entry[`${orderKey}_name`],
          'containers': i === 1 ? entry['cup_cone'] : entry[`${orderKey}_cup_cone`],
          'scoops': [],
          'toppings': []
        };

        // For s1 and s2, flavor is directly in the order
        if ([1, 2].includes(i)) {
          order['scoops'].push(i === 1 ? entry['flavor'] : entry[`${orderKey}_flavor`]);
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
          for (let topping of ['caramel', 'jerky', 'sprinkles']) {
            if (entry[`${orderKey}_toppings___${topping}`]) {
              order['toppings'].push(entry[`${orderKey}_toppings___${topping}`]);
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