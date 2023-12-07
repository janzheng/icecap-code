<script>   
	import * as Avatar from "$lib/components/ui/avatar";
	import { Button } from "$lib/components/ui/button";
	import * as Card from "$lib/components/ui/card";
	import { Input } from "$lib/components/ui/input";
	import * as Select from "$lib/components/ui/select";
	import { Separator } from "$lib/components/ui/separator";
	import { Icons } from "$lib/components/docs/icons";
	import { Label } from "$lib/components/ui/label";

  export let entry


  // Group orders by scenario
  let ordersByScenario = entry._meta.orders.reduce((groups, order) => {
    if (!groups[order.scenario]) {
      groups[order.scenario] = [];
    }
    groups[order.scenario].push(order);
    return groups;
  }, {});
</script>

<Card.Root class="p-0 mb-2">
	<Card.Header>
		<Card.Title>
      Ice Cream ID: {#if entry._meta.id}{entry._meta.id}{:else}<span class="text-sm text-slate-500">N/A</span>{/if}
    </Card.Title>
		<Card.Description>
			{entry._meta.isComplete ? 'Complete' : 'Open'}
		</Card.Description>
	</Card.Header>
	
  <Card.Content>
    {#if Object.keys(ordersByScenario).length > 0}
      {#each Object.keys(ordersByScenario) as scenario}
        <div class="border-t-2 border-gray-200 p-0 my-2 pt-1">
          <p class="font-bold text-xs text-slate-400 mb-2">Scenario: {scenario}</p>
          {#each ordersByScenario[scenario] as order, len}
            {#if order.name}
              <p>Customer Name: {order.name}</p>
            {:else}
              <p class="text-sm text-slate-400">Customer Name: N/A</p>
            {/if}
            {#if order.containers}
              <p>Container: {order.containers}</p>
            {:else}
              <p class="text-sm text-slate-400">Container: N/A</p>
            {/if}
            {#if order.scoops.length > 0}
              <p>Scoops: {order.scoops.join(', ')}</p>
            {:else}
              <p class="text-sm text-slate-400">Scoops: N/A</p>
            {/if}
            {#if order.toppings.filter(x=>x).length > 0}
              <p>Toppings: {order.toppings.filter(x=>x).join(', ')}</p>
            {:else}
              <p class="text-sm text-slate-400">Toppings: N/A</p>
            {/if}

            {#if len + 1 < ordersByScenario[scenario].length}
              <hr class="block mt-2 pt-2 border-neutral-100" />
            {/if}

          {/each}
        </div>
      {/each}
    {:else}
      <div class="border-t-2 border-gray-200 p-0 my-2 pt-1">
        <p class="font-bold text-slate-400 mb-2">No orders entered</p>
      </div>
    {/if}
  </Card.Content>
</Card.Root>