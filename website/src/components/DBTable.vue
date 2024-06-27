<template>
	<DataTable :value="games" :rows="5" paginator>
		<Column field="id" header="ID"></Column>
		<Column field="category" header="Category"></Column>
		<Column field="name" header="Name"></Column>
		<Column field="description" header="Description"></Column>
		<Column field="creator" header="Creator"></Column>
	</DataTable>
</template>

<script setup>
import {ref} from 'vue';
import init from 'sql.js';
import wasm from 'sql.js/dist/sql-wasm.wasm?url';
import archive from '../../../archive.db?url';

const {Database} = await init({locateFile: file => wasm});

const request = await fetch(archive);
const db = new Database(new Uint8Array(await request.arrayBuffer()));

const result = db.exec('SELECT id, category_id, name, description FROM games')[0].values.map(row => ({
	id: row[0],
	category: row[1],
	name: row[2],
	description: row[3]
}));

const games = ref(result);
</script>
