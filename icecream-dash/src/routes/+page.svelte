<script>
  import { browser } from '$app/environment';
  import { onMount } from 'svelte';
  import IceCream from '$lib/components/IceCream.svelte'
  import { Button } from "$lib/components/ui/button";
  import { Input } from "$lib/components/ui/input";

  export let data;
  export let search = '';
  export let mode = null;

  let inclusionState = 'all'; // 'all', 'meets', 'doesNotMeet'
  let inclusionMessage = 'Inclusion: Show All';

  let statusState = 'all'; // 'all', 'open', 'completed'
  let statusMessage = 'Status: Open & Completed';

  let filteredIcecream = [];

  function applyFilters() {
    filteredIcecream = data.icecream.filter(entry => {
      let meetsSearchCriteria = !search || JSON.stringify(entry._meta).toLowerCase().includes(search.toLowerCase());
      let meetsInclusionCriteria = inclusionState === 'all' || (inclusionState === 'meets' && entry._meta.inclusion) || (inclusionState === 'doesNotMeet' && !entry._meta.inclusion);
      let meetsStatusCriteria = statusState === 'all' || (statusState === 'open' && !entry._meta.isComplete) || (statusState === 'completed' && entry._meta.isComplete);
      return meetsSearchCriteria && meetsInclusionCriteria && meetsStatusCriteria;
    });

    if(browser)
      console.log('filtered ice cream:', filteredIcecream)
  }

  if(browser)
    console.log('icecream:', data.icecream)

  function toggleInclusion() {
    if (inclusionState === 'all') {
      inclusionState = 'meets';
      inclusionMessage = 'Inclusion: Meets';
    } else if (inclusionState === 'meets') {
      inclusionState = 'doesNotMeet';
      inclusionMessage = 'Inclusion: Does Not Meet';
    } else {
      inclusionState = 'all';
      inclusionMessage = 'Inclusion: Show All';
    }
    applyFilters();
  }

  function toggleStatus() {
    if (statusState === 'all') {
      statusState = 'open';
      statusMessage = 'Status: Open';
    } else if (statusState === 'open') {
      statusState = 'completed';
      statusMessage = 'Status: Completed';
    } else {
      statusState = 'all';
      statusMessage = 'Status: Open & Completed';
    }
    applyFilters();
  }

  onMount(applyFilters);
</script>

<style>
    /* You can still write custom styles if needed */
</style>

<div class="container mx-auto p-4 | ">
  <h1 class="text-2xl font-bold | mb-4">🍦 Ice Cream Orders</h1>
  <div class="controls w-full | my-4">
    <form class="flex w-full  items-center space-x-2">
      <Input class="max-w-xs" type="Type to search" placeholder="search" bind:value={search} on:input={applyFilters} />
      <Button class="hover:border-slate-900 border-2 border-solid" variant="secondary" on:click={toggleStatus}>{statusMessage}</Button>
      <Button class="hover:border-slate-900 border-2 border-solid" variant="secondary" on:click={toggleInclusion}>{inclusionMessage}</Button>
    </form>
    {#if filteredIcecream.length > 0}
      <div class="status | my-4 text-slate-700 text-sm">
        <p>Showing {filteredIcecream.length} of {data.icecream.length} entries.</p>
      </div>
    {/if}
  </div>

  <div class="items | grid grid-cols-3 gap-2">
    {#each filteredIcecream as entry}
      <IceCream {entry} />
    {/each}
  </div>
</div>