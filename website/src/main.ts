import {createApp} from 'vue';
import App from './App.vue';

import PrimeVue from 'primevue/config';
import {definePreset} from '@primevue/themes';
import Aura from '@primevue/themes/aura';

import Button from 'primevue/button';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';

createApp(App)
	.use(PrimeVue, {
		theme: {
			preset: definePreset(Aura, {
				semantic: {
					primary: {
						50: '{rose.50}',
						100: '{rose.100}',
						200: '{rose.200}',
						300: '{rose.300}',
						400: '{rose.400}',
						500: '{rose.500}',
						600: '{rose.600}',
						700: '{rose.700}',
						800: '{rose.800}',
						900: '{rose.900}',
						950: '{rose.950}'
					}
				}
			})
		}
	})
	.component('Button', Button)
	.component('Column', Column)
	.component('DataTable', DataTable)
	.mount('#app');
