<script setup lang="ts">
import {ref, inject} from 'vue';
import {Database} from 'sql.js';

const games = ref(
	inject<Database>('db')!
		.exec('SELECT id, category_id, name, description FROM games')[0]
		.values.map(row => ({
			id: row[0],
			category: row[1],
			name: row[2],
			description: row[3]
		}))
);
</script>

<template>
	<DataTable :value="games" :rows="5" paginator>
		<Column field="id" header="ID"></Column>
		<Column field="category" header="Category"></Column>
		<Column field="name" header="Name"></Column>
		<Column field="description" header="Description"></Column>
		<Column field="creator" header="Creator"></Column>
	</DataTable>
</template>
