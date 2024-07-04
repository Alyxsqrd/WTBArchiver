<script setup lang="ts">
import archive from '../../../archive.db?url';

import init from 'sql.js';
import wasm from 'sql.js/dist/sql-wasm.wasm?url';
import {provide} from 'vue';

import Games from './tables/Games.vue';

const request = await fetch(archive);
const buffer = await request.arrayBuffer();

const {Database} = await init({locateFile: () => wasm});
provide('db', new Database(new Uint8Array(buffer)));
</script>

<template>
	<Games></Games>
</template>
